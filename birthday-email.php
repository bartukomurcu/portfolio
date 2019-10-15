<?php
require_once '../inc/cli_bootstrap.php';

require_once APP_DIR_ROOT. '/inc/functions.php';
require_once APP_DIR_ROOT. '/inc/class.mandrill.php';
require_once APP_DIR_ROOT. '/inc/class.user.php';
require_once APP_DIR_ROOT. '/inc/class.birthday-email.php';
require_once APP_DIR_ROOT. '/inc/class.log.php';

use Emma\GDPRPolicy\Service\GDPRPolicy;

class Birthday
{
    private $db;
    private $user;
    private $today;
    private $points;
    private $mandrill;

    public function __construct($pdo)
    {
        $this->db = $pdo;
        $this->user          = new User($this->db);
        $this->mandrill      = new Mandrill();
        $this->birthdayEmail = new BirthdayEmail($this->mandrill, 'newbirthdaytemplate');
        $this->today         = date('Y-m-d',time());
        $this->points        = 30;

    }
    public function run()
    {
        try {
            $extra['subscription'] = 1;
            $users = $this->user->getUsers('','','','','', '', '', 1, $order_by="u.date_registered DESC, u.firstname DESC ", '','','', $extra,$this->today);
            if(empty($users)) exit('No users found');

            foreach($users as $activeUser){
                echo "user: ".$activeUser['id']." ".$activeUser['email']."\n";
                $this->updatePoints($activeUser);
            }
        } catch (Exception $e) {
            // Ensure any exceptions thrown are logged
            Log::store('Birthday error', $e->getMessage());
        }
    }

    private function updatePoints($user = '')
    {
        if (empty($user)) return;


        $sql = "INSERT INTO pii_points(user_id,points,status,info,joined_date)
                VALUES(:user_id,:points,:status,'birthday',:joined_date)";

        $date = date('Y-m-d H:i:s');
        $status = 0;
        $sth = $this->db->prepare($sql);
        $sth->bindParam(':user_id', $user['id'], PDO::PARAM_STR);
        $sth->bindParam(':points', $this->points, PDO::PARAM_STR);
        $sth->bindParam(':status', $status, PDO::PARAM_BOOL);
        $sth->bindParam(':joined_date', $date, PDO::PARAM_STR);
        $q = $sth->execute();

        $gdpr = new GDPRPolicy($this->db, null);
        $gdprRestriction = $gdpr->getUserGDPRStatus($user['id']);

        if ($gdprRestriction[0]['gdpr_removed'] == 0) {
            $sendEmail = $this->birthdayEmail->sendEmail($user, $this->points);

            if (!isset($sendEmail[0]) && $sendEmail[0]->status !== 'sent') {
                Log::store('Birthday error', 'Unable to send email to user: ' . $user['email']);
            }
        }
    }
}

$birthday = new Birthday($container->get('db.connection'));
$birthday->run();
