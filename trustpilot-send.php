<?php

use DI\Container;

require_once '../inc/cli_bootstrap.php';

require_once APP_DIR_ROOT.'inc/functions.php';
require_once APP_DIR_ROOT.'inc/class.mandrill.php';
require_once APP_DIR_ROOT.'inc/class.user.php';
require_once APP_DIR_ROOT.'inc/class.log.php';
require_once APP_DIR_ROOT.'inc/class.trustpilotInvite.php';
require_once APP_DIR_ROOT.'src/services.php';

class TrustPilotSend
{
    protected $DIContainer;
    private $db;
    private $user;
    private $mandrill;

    public function __construct(Container $DIContainer)
    {
        $this->db            = $DIContainer->get('db.connection');
        $this->user          = new User($this->db, $DIContainer);
        $this->mandrill      = new Mandrill();
        $this->trustpilot    = new TrustPilotInvite($this->db);
    }

    public function run()
    {
        try {
            $count = 0;
            $arrInviteMembers = $this->user->getCustomersForTrustpilot();

            // Limit invites sent out to 50 per day
            // I'll keep this here just in case Sabine changes her mind :P
            // $invitedMembers = array_slice($arrInviteMembers,0,50);

            foreach ($arrInviteMembers as $inviteMember) {
                $this->sendTrustPilotInvite($inviteMember);
                // Log user in database
                if (!$this->user->checkIfUserReceivedTrustpilot($inviteMember['id'])) {
                    $this->trustpilot->addInvite($inviteMember['id'],$inviteMember['email']);
                }

                echo $inviteMember['email']. " - emailed\n";

                $count++;
            }

            echo $count." members sent out to\n";
            die();

        } catch (Exception $e) {
            // Ensure any exceptions thrown are logged
            Log::store('Trustpilot invite error', $e->getMessage());
        }
    }

    private function sendTrustPilotInvite($user)
    {
        unset($to);
        $blocks = [];

        $vars[0]['name']     = 'FNAME';
        $vars[0]['content']  = $user['firstname'];
        $vars[1]['name']     = 'REDIRECT_TRUSTPILOT';
        $vars[1]['content']  = APP_WEB_ROOT. '/trustpilotRedirect.html?token='.$user['token'];

        // @todo change template in mandrill before deploy
        $template =    'trustpilot-invite';
        $render   =    $this->mandrill->renderTemplate($template, $blocks, $vars);

        $to[0]['name']        = $user['firstname'];
        $to[0]['email']       = $user['email'];

        $subject              = 'Din mening betyder alt for emma.dk VIND 2000 kr';
        $from['from_name']    = 'emma.dk';
        $from['from_email']   = 'website@emma.dk';
        $reply_to             = 'info@emma.dk';

        $response = $this->mandrill->sendTemplate($to, $from, $subject, $render->html, 1, $reply_to);

        return $response;
    }
}

$trustpilot = new TrustPilotSend($container);
$trustpilot->run();
