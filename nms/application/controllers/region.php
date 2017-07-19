<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Region extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        //$this->load->model('model_name');
    }
	
    function index()
    {
        $data   = array();
        $this->load->view('admin/region', $data); 
    }
}
/* End of file region.php */
/* Location: ./application/controllers/region.php */
?>