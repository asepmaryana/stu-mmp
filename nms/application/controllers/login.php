<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Created 11:49 AM 6/8/2016, Author Haris Hardianto
 */

class Login extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        session_start();
        //$this->load->model('model_name');
    }
	
	function index()
	{
	    if($this->session->userdata('uid') != '') redirect('../home');
        else
        {
            $data['page'] = 'Login';
            $this->load->view('login');
        }
	}
    
    function logout()
	{
	    $this->session->sess_destroy();
		redirect('../login');
	}
}
/* End of file Login.php */
/* Location: ./application/controllers/Login.php */
?>