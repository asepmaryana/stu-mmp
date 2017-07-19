<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Reporting extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        $this->load->model('api/SubnetModel','',TRUE);
        $this->load->model('api/NodeModel','',TRUE);
        $this->load->model('api/CurrentAlarmModel','',TRUE);
        $this->load->model('api/AvailabilityMonthlyModel','',TRUE);
        $this->load->model('api/AlarmSeverityModel','',TRUE);
        $this->load->model('api/AlarmListModel','',TRUE);
        //$this->load->model('model_name');
    }
	
    function index()
    { 
        print 'reporting index'; 
    }
    
    function alarmlog()
    {
        $region     = $this->SubnetModel->getRegion()->result();
        $severity   = $this->AlarmSeverityModel->getRows()->result();
        
        $data           = array();
        $data['region'] = $region;
        $data['severity'] = $severity;
        $this->load->view('reporting/alarmlog', $data);
    }
    
    function datalog()
    {
        $region     = $this->SubnetModel->getRegion()->result();
        
        $data           = array();
        $data['region'] = $region;
        $this->load->view('reporting/datalog', $data);
    }
    
    function get_sites()
    {
        $regions    = $this->uri->segment(3);
        $sites      = $this->SubnetModel->get_site_by_region(explode('_', $regions))->result();
        print json_encode(array('success'=>true, 'rows'=>$sites));
        #foreach($sites as $r) print '<label><input type="checkbox" name="site" value="'.$r->id.'" onclick="getSiteSelected()"/> '.$r->name.'</label>';
    }
    
    function get_nodes()
    {
        $nodes = $this->uri->segment(3);
        $rows  = $this->SubnetModel->get_node_by_site(explode('_', $nodes))->result();
        print json_encode(array('success'=>true, 'rows'=>$rows));
    }
    
    function get_node_objects()
    {
        $nodes = $this->uri->segment(3);
        $rows  = $this->SubnetModel->get_node_by_site(explode('_', $nodes))->result();
        print json_encode(array('success'=>true, 'rows'=>$rows));
    }
    
    function get_alarm_list()
    {
        $severities = $this->uri->segment(3);
        $rows  = $this->AlarmListModel->get_alarm_list('1', explode('_', $severities), 'id', 'asc')->result();
        print json_encode(array('success'=>true, 'rows'=>$rows));
    }
}

/* End of file reporting.php */
/* Location: ./application/controllers/reporting.php */
?>