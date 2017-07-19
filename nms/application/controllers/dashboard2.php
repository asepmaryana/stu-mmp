<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Created 12:37 PM 6/9/2016, Author Haris Hardianto
 */

class Dashboard2 extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        //$this->load->model('model_name');
    }
	
	public function index()
	{
	    $data['page'] = 'Dashboard2';
	    
		$this->load->view('v_Dashboard2');
	}
}

/* End of file Dashboard2.php */
/* Location: ./application/controllers/Dashboard2.php */