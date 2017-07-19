<?php
class Alarm extends CI_Controller
{
	function __construct()
	{		
		parent::__construct();
		session_start();
        $this->load->model('CurrentAlarmModel','',TRUE);
        $this->load->model('SubnetModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
	}
    
	function generateNodeId($parent_id)
    {
        if($parent_id == 0 || $parent_id == '0') $parent_id = '';
        $nodes   = "";
        $res    = $this->SubnetModel->get_by_parentid($parent_id);
        if($res->num_rows() == 0) {
            $node = $this->NodeModel->get_by_subnet_id($parent_id);
            if($node->num_rows() != 0) {
                foreach($node->result() as $row)
                {
                    $nodes.= "'". $row->id . "',";
                }
            }
            return $nodes;
        }
        foreach($res->result() as $row)
        {
            $nodes.= $this->generateNodeId($row->id);
        }    
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
        
        $hosts    = '';
        if($node_id != '' && $node_id != '_') $hosts    = "'".$node_id."',";
        elseif($site_id != '' && $site_id != '_') $hosts    = $this->generateNodeId($site_id);
        elseif($region_id != '' && $region_id != '_') $hosts    = $this->generateNodeId($region_id);
        if(!empty($hosts)) $hosts = substr($hosts, 0, strlen($hosts) - 1);
        
        #print $hosts;
        $severity = '';
        if($severity_id != '' && $severity_id != '_') $severity = "'".$severity_id."'";
        
        $rows     = $this->CurrentAlarmModel->getCurrentAlarms($hosts, '', $severity, '', '', '', $limit, $start)->result();
        $data     = array();        
        $i=0;
        foreach($rows as $row)
        {
            if($row->severity == 'CRITICAL') $row->severity = '<span class="label label-sm label-danger"> '.$row->severity.' </span>';
            elseif($row->severity == 'MAJOR') $row->severity = '<span class="label label-sm label-info"> '.$row->severity.' </span>';
            elseif($row->severity == 'MINOR') $row->severity = '<span class="label label-sm label-success"> '.$row->severity.' </span>';
            elseif($row->severity == 'WARNING') $row->severity = '<span class="label label-sm label-warning"> '.$row->severity.' </span>';
            else $row->severity = '<span class="label label-sm label-default"> '.$row->severity.' </span>';
            
            $data[$i]      = array('<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input name="id[]" type="checkbox" class="checkboxes" value="'.$row->id.'"/><span></span></label>', $row->regional, $row->site, $row->label, $row->address, $row->ddtime, $row->severity, $row->alarm_name, $row->alarm_counter);
            #$rows[$i]->id   = '<input type="checkbox" class="checkboxes" value="'.$row->id.'" />';
            $i++;
        }
		$response = array();
        $response['data']   = $data;
        $response['customActionStatus'] = 'OK';
        #$response['customActionMessage']    = 'Group action successfully has been completed. Well done!';
        $response['customActionMessage']    = '';
        $response['draw']   = $draw;
        $response['recordsTotal']   = $this->CurrentAlarmModel->count_all();
        $response['recordsFiltered']= $this->CurrentAlarmModel->getCurrentAlarmsCount($hosts, '', $severity, '', '', '');
        
        print json_encode($response);
	}
}
?>