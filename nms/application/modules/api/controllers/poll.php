<?php
class Poll extends CI_Controller
{
	function __construct()
	{		
		parent::__construct();
		session_start();
        $this->load->model('PollModel','',TRUE);
        $this->load->model('SubnetModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
        $this->load->model('DeviceObjectModel','',TRUE);
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
        $param_id   = $this->uri->segment(7);
        $from       = $this->uri->segment(8);
        $to         = $this->uri->segment(9);
        $doc        = $this->uri->segment(10);
        
        $hosts      = '';
        if($node_id != '' && $node_id != '_') $hosts    = str_replace('_', ',', $node_id);
        elseif($site_id != '' && $site_id != '_') $hosts    = $this->generate_node_by_site($site_id);
        elseif($region_id != '' && $region_id != '_') $hosts    = $this->generate_node_by_region($region_id);
        #if(!empty($hosts)) $hosts = substr($hosts, 0, strlen($hosts) - 1);
        
        $param      = '';
        if($param_id != '' && $param_id != '_') $param = str_replace('_', ',', $param_id);
        
        if(empty($from) || $from == '_') $from = date('Y-m-d');
        if(empty($to) || $to == '_') $to = $from;
        
        $data     = array();
        if($doc == 'xls')
        {
            $data = $this->PollModel->get_list($hosts, $param, $from, $to, 'id', 'asc')->result();
            #print '<pre>';
            #print_r($data);
            #print '</pre>';            
            require_once 'phpexcel/PHPExcel/IOFactory.php';
            $objReader = PHPExcel_IOFactory::createReader('Excel2007');
            $objPHPExcel = $objReader->load("application/views/reporting/poll.xlsx");
            $i=1;
            foreach($data as $row)
            {
                $i++;
                $n = $i - 1;
                $objPHPExcel->getActiveSheet()->setCellValue('A'.$i, $n);
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$i, $row->site);
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$i, $row->name);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$i, $row->var_name);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$i, $row->ddtime);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$i, number_format($row->value, 2));
            }
            $this->load->helper('excel');
            download_excel($objPHPExcel, 'Poll Report');
        }
        elseif($doc == 'tbl')
        {
            $data = $this->PollModel->get_list($hosts, $param, $from, $to, 'id', 'asc')->result();
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
        else
        {
            $parameters = array();
            if($param != '') $parameters = $this->DeviceObjectModel->get_in(explode(',', $param))->result();
            else $parameters = $this->DeviceObjectModel->get_in(array('82','112','113'))->result();
            
            $nodes  = array();
            if($node_id != '' && $node_id != '_') $nodes    = explode('_', $node_id);
            $i=0;
            foreach($nodes as $nodeId)
            {
                $rows = $this->DeviceObjectModel->get_do_by_node($nodeId, $param)->result();
                $object = $rows;
                $param = '';
                foreach($rows as $p) $param .= $p->id.',';
                if(strlen($param)>0) $param = substr($param, 0, strlen($param)-1);
                
                $node   = $this->NodeModel->get_by_id($nodeId)->row();
                $rows   = $this->PollModel->get_list($nodeId, $param, $from, $to, 'id', 'asc')->result();
                
                $data[$i]['id']   = $node->id;
                $data[$i]['node'] = $node->name;
                $data[$i]['param']= $object;
                $data[$i]['data'] = array();
                $jsdate  = '';
                $j=0;
                foreach($rows as $row) {
                    if($jsdate == '') {
                        $jsdate = $row->jsdate;
                        $data[$i]['data'][$j]['jsdate'] = $jsdate;
                        $data[$i]['data'][$j][$row->var_name] = (float)$row->value; 
                    }
                    else {
                        if($jsdate != $row->jsdate) {
                            $j++;
                            $jsdate = $row->jsdate;
                            $data[$i]['data'][$j]['jsdate'] = $jsdate;
                            $data[$i]['data'][$j][$row->var_name] = (float)$row->value;
                        }
                        else $data[$i]['data'][$j][$row->var_name] = (float)$row->value;
                    }
                }
            }
            
            $response = array();   
            $response['rows']   = $data;
            $response['parameters']     = $parameters;
            print json_encode($response);
        }
	}
}
?>