<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Created 3:10 PM 6/8/2016, Author Haris Hardianto
 */

class Monitoring extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        //$this->load->model('model_name');
    }
	
	public function index()
	{
	    $data['page'] = 'Monitoring';
	    
		$this->load->view('v_Monitoring');
	}
}

/* End of file Monitoring.php */
/* Location: ./application/controllers/Monitoring.php */