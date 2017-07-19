<?php
class Login extends CI_Controller
{
	function __construct()
	{		
		parent::__construct();
		session_start();
        $this->load->model('UserModel','',TRUE);
	}
	
	function authenticate()
	{						
		$username = trim($this->input->post('username'));
		$password = md5(trim($this->input->post('password')));
		if($this->UserModel->authenticate($username, $password)) print json_encode(array('success'=>true, 'msg'=>'Login success, please wait...'));
		else print json_encode(array('success'=>false, 'msg'=>'Incorrect username or password !'));
	}

	function setpwd()
    {
        if($this->session->userdata('uid') == '') print json_encode(array('success'=>false, 'msg'=>'Your session was expired, please logged in back !'));
        else
        {
            $userid         = $this->session->userdata('uid');
            $username       = $this->session->userdata('username');
            $opassword      = md5(trim($this->input->post('pass_lama')));
            $password       = md5(trim($this->input->post('pass_baru')));
            
            $rs = $this->UserModel->authenticate($username, $opassword);
            if($rs->num_rows() > 0){
                $values     = array('password'=>$password);
                if($this->UserModel->update($userid, $values) === FALSE) print json_encode(array('success'=>false, 'msg'=>'Change password failed !'));
                else print json_encode(array('success'=>true, 'msg'=>'Change password succeed.'));
            }
            else print json_encode(array('success'=>false, 'msg'=>'Incorrect old password !'));
        }
    }
    
	function logout()
	{
	    $this->session->sess_destroy();
		print json_encode(array('success'=>true, 'msg'=>'Logout succeed !'));
	}
}
?>