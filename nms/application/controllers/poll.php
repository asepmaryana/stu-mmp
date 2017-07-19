<?php
class Poll extends CI_Controller 
{	
	function __construct()
	{
		parent::__construct();
        #session_start();
		#if ($this->session->userdata('username') == "") redirect('login');			
        date_default_timezone_set("Asia/Jakarta");
        
		// load model
		$this->load->model('PollModel','',TRUE);
        $this->load->model('SubnetsModel','',TRUE);
        $this->load->model('NodetableModel','',TRUE);
        $this->load->model('DeviceObjectModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
        $this->load->model('HttpModel','',TRUE);

	}
    
    function index()
    {
        $regions         = $this->SubnetsModel->getRegion()->result();
        
        $data['title']		= "Fault Report";
        $data['regions']    = $regions;
        $data['from']       = date('Y-m-d');
        $data['to']         = date('Y-m-d');
        $data['title']		= "poll";
        
        $this->load->view('report/list_poll', $data);
    }
    
    function loadSubnet()
    {
        $type       = $this->uri->segment(3);
        $regions    = explode(".", substr($this->uri->segment(4), 0, strlen($this->uri->segment(4))));
        $rows       = array();
        $c          = 0;
        for($i=0; $i<count($regions); $i++)
        {
            $res    = $this->SubnetsModel->get_by_parentid($regions[$i]);
            foreach($res->result() as $row)
            {
			    if($row->parent_id != '')
                $rows[$c]   = $row;
				
                $c++;
            }
        }
        $data['rows']   = $rows;
        #$this->load->view('realtime/cb_site', $data);
        if($type == "area") $this->load->view('report/cb_area', $data);
        if($type == "site") $this->load->view('report/cb_site', $data);
        
    }
    
    function loadNode()
    {
        $type       = $this->uri->segment(3);
        $regions    = explode(".", substr($this->uri->segment(4), 0, strlen($this->uri->segment(4))-1));
        $rows       = array();
        $c          = 0;
        for($i=0; $i<count($regions); $i++)
        {
            $res    = $this->NodetableModel->get_by_parentid($regions[$i]);
            foreach($res->result() as $row)
            {
                $rows[$c]   = $row;
                $c++;
            }
        }
        $data['rows']   = $rows;
        if($type == "device") $this->load->view('report/cb_device', $data);
    }
    
    function loadParam()
    {
        $nodes  = $this->uri->segment(3);
        $nodes  = str_replace('.',',', $nodes);
        $data['rows']   = $this->NodetableModel->get_node_param($nodes)->result();
        $this->load->view('report/cb_parameter', $data);
    }
    
    function tes()
    {
        $device     = $this->uri->segment(3);
        $param      = $this->uri->segment(4);
        $from       = $this->uri->segment(5);
        $to         = $this->uri->segment(6);
        
		// load data
        print $device.'/'.$param.'/'.$from.'/'.$to;
    }
    
	function getlist()
	{
	    $page = isset($_POST['page']) ? intval($_POST['page']) : 1;  
        $rows = isset($_POST['rows']) ? intval($_POST['rows']) : 10;  
        $sort = isset($_POST['sort']) ? strval($_POST['sort']) : 'id';  
        $order = isset($_POST['order']) ? strval($_POST['order']) : 'asc';                
        $offset = ($page-1)*$rows;
        
        $device     = $this->uri->segment(3);
        $param      = $this->uri->segment(4);
        $from       = $this->uri->segment(5);
        $to         = $this->uri->segment(6);
        
		// load data
        #print $device.'/'.$param.'/'.$from.'/'.$to;
		$rows = $this->PollModel->get_paged_list($device, $param, $from, $to, $sort, $order, $rows, $offset)->result();
		$data['rows'] = $rows;
		$data['total'] = $this->PollModel->getCount($device, $param, $from, $to);             
        print json_encode($data);        		
	}    	

	function chart()
    {
        $device     = $this->uri->segment(3);
        $param      = $this->uri->segment(4);
        $from       = $this->uri->segment(5);
        $to         = $this->uri->segment(6);
        
        $devices    = explode('_', $device);
        $params     = explode('_', $param);
        $data       = array();
        $out        = array();
        if(count($devices)>0)
        {
            $i=0;
            foreach($devices as $node_id) {
                #print $node_id.'<br/>';
                if($param == '_') $param = '';
                else $param = str_replace('_', ',', $param);
                # verify device param
                $rows   = $this->DeviceObjectModel->get_do_by_node($node_id, $param)->result();
                $object = $rows;
                $param = '';
                foreach($rows as $p) $param .= $p->id.',';
                if(strlen($param)>0) $param = substr($param, 0, strlen($param)-1);
                                
                $node   = $this->NodetableModel->get_node($node_id)->row();
                # data log
                $rows   = $this->PollModel->get_paged_list($node_id, $param, $from, $to, 'id', 'asc', 0, 0)->result();
                #print 'node:'.$node_id.' --> '.$param.', total rows:'.count($rows).'<br/>';
                $out[$i]['id']   = $node->id;
                $out[$i]['node'] = $node->name;
                $out[$i]['param']= $object;
                $out[$i]['data'] = array();
                $jsdate  = '';
                $j=0;
                foreach($rows as $row) {
                    if($jsdate == '') {
                        $jsdate = $row->jsdate;
                        $out[$i]['data'][$j]['jsdate'] = $jsdate;
                        $out[$i]['data'][$j][$row->var_name] = (float)$row->value; 
                    }
                    else {
                        if($jsdate != $row->jsdate) {
                            $j++;
                            $jsdate = $row->jsdate;
                            $out[$i]['data'][$j]['jsdate'] = $jsdate;
                            $out[$i]['data'][$j][$row->var_name] = (float)$row->value;
                        }
                        else $out[$i]['data'][$j][$row->var_name] = (float)$row->value;
                    }
                }
            }
            #print json_encode($data);
            $data['rows']   = $out;
            $this->load->view('report/chart', $data);
        }
        else print 'no device selected '; 
        #print $device.'/'.$param.'/'.$from.'/'.$to;
    }
    
    function xls()
    {
        $device     = $this->uri->segment(3);
        $param      = $this->uri->segment(4);
        $from       = $this->uri->segment(5);
        $to         = $this->uri->segment(6);
        $rows       = $this->PollModel->get_list($device, $param, $from, $to, 'id', 'asc')->result();
        
            require_once 'phpexcel/PHPExcel/IOFactory.php';
            $objReader = PHPExcel_IOFactory::createReader('Excel2007');
            $objPHPExcel = $objReader->load("application/views/report/poll.xlsx");
            $i=1;
            foreach($rows as $row)
            {
                $i++;
                $n = $i - 1;
                $objPHPExcel->getActiveSheet()->setCellValue('A'.$i, $n);
                $objPHPExcel->getActiveSheet()->setCellValue('B'.$i, $row->site);
                $objPHPExcel->getActiveSheet()->setCellValue('C'.$i, $row->name);
                $objPHPExcel->getActiveSheet()->setCellValue('D'.$i, $row->var_name);
                $objPHPExcel->getActiveSheet()->setCellValue('E'.$i, $row->ddtime);
                $objPHPExcel->getActiveSheet()->setCellValue('F'.$i, $row->value);                
            }
            $this->load->helper('excel');
            download_excel($objPHPExcel, 'Polling Report');
            
        #print '<pre>';
        #print_r($rows);
        #print '</pre>';
    }
    
    function trap()
    {
        print 'SAVED';
        $uri    = $_SERVER["REQUEST_URI"];
        $ip     = trim($this->input->post('ip'));
        $data   = trim($this->input->post('data'));
        
        $param  = 'ip='.$ip.'&data='.$data;        
        $dtime  = '';
        
        if($sn != '' && $data != '') {
            $node = $this->NodeModel->get_by_ip($ip)->row();
            if(is_object($node)) {
                $data  = substr($data, 0, strlen($data)-1);
                $datas = explode(',', $data);
                foreach($datas as $dt) {
                    if($dt != '') {
                        list($param_id, $value, $dtime, $alarm) = explode(':', $dt);
                        $dtime = substr($dtime, 0, 4).'-'.substr($dtime, 4, 2).'-'.substr($dtime, 6, 2).' '.substr($dtime, 8, 2).':'.substr($dtime, 10, 2).':'.substr($dtime, 12, 2);
                    }
                }
                #print 'SAVED';
                #update vessel
            }
            #else print $sn.' IS UNREGISTERED ENGINE';
        }
        #else print 'INVALID REQUEST !';
        
        # http log
        $row    = array();
        $row['dtime']   = date('Y-m-d H:i:s');
        $row['uri']     = $uri;        
        $row['param']   = $param;
        
        #$this->HttpModel->save($row);
    }
}
?>