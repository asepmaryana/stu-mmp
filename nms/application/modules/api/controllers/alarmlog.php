<?php
class Alarmlog extends CI_Controller
{
	function __construct()
	{		
		parent::__construct();
		session_start();
        $this->load->model('AlarmLogModel','',TRUE);
        $this->load->model('SubnetModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
	}
    
    function generate_node_by_site($site_id)
    {
        if($site_id == 0 || $site_id == '0') $site_id = '';
        $nodes   = "";
        $rows    = $this->SubnetModel->get_node_by_site(explode('_', $site_id))->result();
        foreach($rows as $row) $nodes.= "'". $row->id . "',";
        if(strlen($nodes) > 0) $nodes = substr($nodes, 0, strlen($nodes)-1);
        return $nodes;
    }
    
    function generate_node_by_region($region_id)
    {
        if($region_id == 0 || $region_id == '0') $region_id = '';
        $nodes   = "";
        $rows    = $this->SubnetModel->get_node_by_region(explode('_', $region_id))->result();
        foreach($rows as $row) $nodes.= "'". $row->id . "',";
        if(strlen($nodes) > 0) $nodes = substr($nodes, 0, strlen($nodes)-1);
        return $nodes;
    }
    
	function getlist()
	{
	    $draw     = isset($_REQUEST['draw']) ? intval($_REQUEST['draw']) : 1;  
		$start    = isset($_REQUEST['start']) ? intval($_REQUEST['start']) : 0;
        $limit    = isset($_REQUEST['length']) ? intval($_REQUEST['length']) : 10;
        $ordby    = isset($_REQUEST['order[0][column]']) ? intval($_REQUEST['order[0][column]']) : 1;
        $ordir    = isset($_REQUEST['order[0][dir]']) ? intval($_REQUEST['order[0][dir]']) : 'asc';
        
        $region_id  = $this->uri->segment(4);
        $site_id    = $this->uri->segment(5);
        $node_id    = $this->uri->segment(6);
        $severity_id= $this->uri->segment(7);
        $alarm_id   = $this->uri->segment(8);
        $from       = $this->uri->segment(9);
        $to         = $this->uri->segment(10);
        $doc        = $this->uri->segment(11);
        
        $hosts    = '';
        if($node_id != '' && $node_id != '_') $hosts    = str_replace('_', ',', $node_id);
        elseif($site_id != '' && $site_id != '_') $hosts    = $this->generate_node_by_site($site_id);
        elseif($region_id != '' && $region_id != '_') $hosts    = $this->generate_node_by_region($region_id);
        #if(!empty($hosts)) $hosts = substr($hosts, 0, strlen($hosts) - 1);
        
        $severity   = '';
        if($severity_id != '' && $severity_id != '_') $severity = str_replace('_', ',', $severity_id);        
        $alarm      = '';
        if($alarm_id != '' && $alarm_id != '_') $alarm = str_replace('_', ',', $alarm_id);
        
        if(empty($from) || $from == '_') $from = date('Y-m-d');
        if(empty($to) || $to == '_') $to = $from;
        
        $data     = $this->AlarmLogModel->get_list($hosts, '1', $severity, $alarm, $from, $to, 'id', 'asc')->result();
        if($doc == 'xls')
        {
            #print '<pre>';
            #print_r($data);
            #print '</pre>';            
            require_once 'phpexcel/PHPExcel/IOFactory.php';
            $objReader = PHPExcel_IOFactory::createReader('Excel2007');
            $objPHPExcel = $objReader->load("application/views/reporting/alarmlog.xlsx");
            $i=1;
            foreach($data as $row)
            {
                $i++;
                $n = $i - 1;
                $objPHPExcel->getActiveSheet()->setCellValue('A'.$i, $n);
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$i, $row->regional);
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$i, $row->site);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$i, $row->label);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$i, $row->address);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$i, $row->ddtime);
                $objPHPExcel->getActiveSheet()->setCellValue('G'.$i, $row->ddtime_end);
                $objPHPExcel->getActiveSheet()->setCellValue('H'.$i, $row->severity);
                $objPHPExcel->getActiveSheet()->setCellValue('I'.$i, $row->alarm_name);
            }
            $this->load->helper('excel');
            download_excel($objPHPExcel, 'Fault Report');
            
        }
        else
        {
            $response = array();
            $response['data']   = $data;
            $response['customActionStatus'] = 'OK';
            #$response['customActionMessage']    = 'Group action successfully has been completed. Well done!';
            $response['customActionMessage']    = '';
            $response['draw']   = $draw;
            $response['recordsTotal']   = count($data); #$this->AlarmLogModel->count_all();
            $response['recordsFiltered']= count($data);
            print json_encode($response);
        }
	}
}
?>