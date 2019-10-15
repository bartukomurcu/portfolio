<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 24/05/2018
 * Time: 14:48
 */


require_once '../inc/cli_bootstrap.php';
require_once '../inc/functions.php';
require_once '../inc/smarty/Smarty.class.php';
require_once '../inc/class.mandrill.php';
require_once '../inc/class.emailTemplate.php';
require_once '../inc/class.login.php';
require_once '../inc/class.product.php';
require_once '../inc/class.brand.php';

use Emma\ORM\Entity\User;

set_time_limit(0);

$mandrill = new \Mandrill();

$header_image = 'https://www.emma.dk/img/emma-mobile-banner.png';
$emailTemplate = new EmailTemplate($mandrill);

/** @var \Emma\ConnectionManager\ConnectionManager $db */
$db = $container->get('db.connection');
/** @var \Doctrine\ORM\EntityManager $em */
$em = $container->get('doctrine.em');

$userRepo = $em->getRepository(User::class);
$customerAddresses = $userRepo->getUsersByGDPRStatus(false);

echo 'Init select users'.PHP_EOL;

$i=0;
$b = new Brand($db);
$arrBrands = $b->getBrands();

$csv    = "sep=,\n";
$csvRow = array();

$csvRow[] = '#';
$csvRow[] = 'Id';
$csvRow[] = 'Email';
$csvRow[] = 'Status';

$csv.= implode(",", $csvRow)."\n";
$priceRestriction = 100;

foreach($customerAddresses as $customerAddress) {
    // Use VisitorsTracking system to get product recommendations for the user
    $visitorsTrackerProducts = new ProductsTracker($db);
    $visitorsTrackerUsers = new UsersTracker($db);

    $connectedUserIds = $visitorsTrackerUsers->getUsersIdsConnectedWithVisitorTrackingId();
    // Get most visited products by user
    $productRecommendationsFromProductsTracker = $visitorsTrackerProducts->getMostVisitedProducts($customerAddress['user_id'], 12, $priceRestriction);
    $invoiceService = new InvoiceService($db);

    // Get most bought products by users
    $mostBoughtProducts = $invoiceService->getUsersMostBoughtProducts($connectedUserIds, 12, $priceRestriction);

    // Combine and shuffle most bought and most visited products by user
    $productRecommendations = removeDuplicatedProducts(array_merge($mostBoughtProducts, $productRecommendationsFromProductsTracker));
    shuffle($productRecommendations);
    $productRecommendations = array_slice($productRecommendations, 0, 12);
    // End of getting product Recommendations

    foreach ($productRecommendations as &$productRecommendation) {
        $brandId = $productRecommendation['brand_id'];
        $brand = $arrBrands[$brandId];
        $brandName = $brand['name'];
        $productRecommendation['brand_name'] = $brandName;
    }

    $smarty = new \Emma\ExtendedSmarty\ExtendedSmarty();
    $smartyPluginsContainer = new \Emma\ExtendedSmarty\SmartyPluginsContainer();
    $smartyPluginsContainer->addPlugin(new \Emma\ExtendedSmarty\SmartyPlugin\GenerateProductGalleryPhotoURL(AWS_S3_GALLERY_BUCKET_ADDRESS));
    $smartyPluginsContainer->addPlugin(new \Emma\ExtendedSmarty\SmartyPlugin\GenerateImageURL(AWS_S3_IMAGES_BUCKET_ADDRESS));
    $smartyPluginsContainer->addPlugin(new \Emma\ExtendedSmarty\SmartyPlugin\MakeLink());
    $smartyPluginsContainer->addPlugin(new \Emma\ExtendedSmarty\SmartyPlugin\DebugDump());

    $smarty->setSmartyPluginsContainer($smartyPluginsContainer);
    $smarty->setTemplateDir(APP_DIR_ROOT.'templates/');
    $smarty->setCompileDir(APP_DIR_ROOT.'templates_c/');
    $smarty->setCacheDir(APP_DIR_ROOT.'cache/');

    $smarty->assign('APP_WEB_ROOT', APP_WEB_ROOT.'/');
    $smarty->assign('showCompetitors', true);
    $smarty->assign('products', $productRecommendations);

    $products_tpl = $smarty->fetch('messages/products-display.tpl');

    $csvRow = array();
    $csvRow[] = $i++;
    $csvRow[] = $customerAddress['user_id'];
    $csvRow[] = $customerAddress['email_address'];

    $name = $customerAddress['firstname'];

    $template = "emailgdpr";
    $subject  = 'Info om data og GDPR læs venligst, modtag 50 cashpoints';

    $token = $customerAddress['token'];
    $to[0]['email'] = $customerAddress['email_address'];
    $to[0]['name'] = '';

    $from['from_name']    = 'emma.dk';
    $from['from_email']   = 'emma@emma.dk';
    $reply_to             = 'emma@emma.dk';

    $blocks[0]['name']    = 'emailgdpr';
    $blocks[0]['content'] = '';

    $vars[0]['name']      = 'NAME';
    $vars[0]['content']   = $name;
    $vars[1]['name']      = 'GDPR_LINK_CP';
    $vars[1]['content']   = APP_WEB_ROOT.'/bonus.html?token='.$token.'&step=assign';
    $vars[2]['name']      = 'GDPR_LINK_UNS';
    $vars[2]['content']   = APP_WEB_ROOT.'/bonus.html?token='.$token.'&step=unsubscribe';
    $vars[3]['name']      = 'email_products';
    $vars[3]['content']   = $products_tpl;

    $result = $emailTemplate->sendEmail($to, $template, $subject,$blocks, $from, $vars, $reply_to);

	if (in_array($result[0]->status, ['sent','queued'])){
    	echo $customerAddress['email_address']."\t=>\tsuccess [".$result[0]->status."]".PHP_EOL;
    } else {
    	echo $customerAddress['email_address']."\t=>\tERROR (".$result[0]->status.")".PHP_EOL;
    }

    $csv.= implode(",", $csvRow)."\n";
}

function removeDuplicatedProducts($array)
{
    uasort($array, function ($a, $b) {
        $a = intval($a['id']);
        $b = intval($b['id']);
        if ($a == $b) return 0;
        return ($a < $b) ? -1 : 1;
    });

    $lastProductId = 0;
    foreach ($array as $key => $value) {
        if ($lastProductId == $value['id'])
            unset($array[$key]);
        $lastProductId = $value['id'];
    }
    return $array;
}

echo $csv;
$filename = "GDPR.csv";
$path = APP_DIR_ROOT.'/inc/';
@file_put_contents('../inc/' . $filename, $csv);

