<?php
class Alarm extends CI_Controller 
{	
	function __construct()
	{
		parent::__construct();			
        date_default_timezone_set("Asia/Jakarta");
        $this->load->model('api/NodeModel','',TRUE);
        $this->load->model('api/TrapModel','',TRUE);
        $this->load->model('api/HttpModel','',TRUE);
	}
    
    function index() { 
        $pin    = '404';
        $idx    = substr($pin, 2, strlen($pin));
        print $pin.' --> '.$idx;
    }
    
    function trapx()
    {
        print 'SAVED';
        $uri    = $_SERVER["REQUEST_URI"];
        $ip     = trim($this->input->post('ip'));
        $data   = trim($this->input->post('data'));
        
        #ip=172.25.97.130&data=201:20150605172112:28.0:0.0:0,201:20150605172122:28.200001:0.0:2,201:20150605172152:28.299999:0.0:0,
        #$ip     = '172.25.97.130';
        #$data   = '201:20150605172112:28.0:0.0:0,201:20150605172122:28.200001:0.0:2,201:20150605172152:28.299999:0.0:0,';
        
        $param  = 'ip='.$ip.'&data='.$data;        
        $dtime  = '';
        
        if($ip != '' && $data != '') {
            $node = $this->NodeModel->get_by_ip($ip)->row();
            if(is_object($node)) {
                $data  = substr($data, 0, strlen($data)-1);
                $datas = explode(',', $data);
                foreach($datas as $dt) {
                    if($dt != '') {
                        list($param_id, $dtime, $value, $treshold, $alarm) = explode(':', $dt);
                        $dtime = substr($dtime, 0, 4).'-'.substr($dtime, 4, 2).'-'.substr($dtime, 6, 2).' '.substr($dtime, 8, 2).':'.substr($dtime, 10, 2).':'.substr($dtime, 12, 2);
                        
                        if($alarm == 3) continue;
                        if($value == '255.5') continue;
                        $values                 = array();
                        $values['dtime']        = $dtime;
                        $values['node_id']      = $node->id;
                        $values['agent_addr']   = $ip;
                        $values['from_addr']    = $ip;
                        $values['uptime']       = time();
                        $values['community']    = 'public';
                        $values['trap_type']    = '6';
                        $values['trap_oid']     = '';

                        switch(intval($node->device_id)) {
                            #Simon2000
                            case 1:
                                $values['enterprise'] = 'hmct-Traps';
                                if(in_array($param_id, array(1,2,3,4))) {
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'analog-Input-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'analog-Input-Inactive';
                                    $values['var_name1']    = 'analog-Input-Index';
                                    $values['var_val1']     = $param_id;
                                    $values['var_name2']    = 'analog-Input-Value';
                                    $values['var_val2']     = $value;
                                    $values['var_name3']    = 'analog-Input-Value-Threshold';
                                    $values['var_val3']     = $treshold;
                                }
                                elseif(in_array($param_id, array(101,102,104,105,107,108))) {
                                    #$values['trap_specific']    = '';
                                    $values['var_val1']         = $value;
                                    $values['var_val2']         = $treshold;
                                    switch(intval($param_id)) {
                                        # voltage phase R
                                        case 101:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseR-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseR-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseR-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseR';
                                            $values['var_name2']    = 'voltage-PhaseR-Treshold';
                                        break;
                                        
                                        # current phase R
                                        case 102:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseR-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseR-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseR-Inactive';
                                            $values['var_name1']    = 'current-PhaseR';
                                            $values['var_name2']    = 'current-PhaseR-Treshold';
                                        break;
                                        
                                        # voltage phase S
                                        case 104:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseS-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseS-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseS-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseS';
                                            $values['var_name2']    = 'voltage-PhaseS-Treshold';                                      
                                        break;
                                        
                                        # current phase S
                                        case 105:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseS-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseS-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseS-Inactive';
                                            $values['var_name1']    = 'current-PhaseS';
                                            $values['var_name2']    = 'current-PhaseS-Treshold';
                                        break;
                                        
                                        # voltage phase T
                                        case 107:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseT-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseT-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseT-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseT';
                                            $values['var_name2']    = 'voltage-PhaseT-Treshold';
                                        break;
                                        
                                        # current phase T
                                        case 108:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseT-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseT-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseT-Inactive';
                                            $values['var_name1']    = 'current-PhaseT';
                                            $values['var_name2']    = 'current-PhaseT-Treshold';
                                        break;
                                    }
                                }
                                # temperature alarm
                                elseif(in_array($param_id, array(201,203))) {
                                    #$values['trap_specific']    = '';
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'temperature-Index';
                                    $values['var_val1']         = ($param_id == 201) ? '1' : '2';
                                    $values['var_name2']        = 'temperature-Value';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'temperature-Value-Threshold';
                                    $values['var_val3']         = $treshold;
                                    if($alarm == 1)     $values['trap_oid'] = 'low-Temperature-Active';
                                    elseif($alarm == 2) $values['trap_oid'] = 'high-Temperature-Active';
                                    elseif($alarm == 0) $values['trap_oid'] = 'high-temperature-Inactive';
                                }
                                # humidity alarm
                                elseif(in_array($param_id, array(202,204))) {
                                    #$values['trap_specific']    = '';
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'humidity-Index';
                                    $values['var_val1']         = ($param_id == 202) ? '1' : '2';
                                    $values['var_name2']        = 'humidity-Value';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'humidity-Value-Threshold';
                                    $values['var_val3']         = $treshold;
                                    if($alarm == 1)     $values['trap_oid'] = 'low-Humidity-Active';
                                    elseif($alarm == 2) $values['trap_oid'] = 'high-Humidity-Active';
                                    elseif($alarm == 0) $values['trap_oid'] = 'high-humidity-Inactive';
                                }
                                # fuel
                                elseif(in_array($param_id, array(301,302))) {
                                    #$values['trap_specific']    = ($alarm == 1 || $alarm == 2) ? 605 : 625;
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'fuel-Index';
                                    $values['var_val1']         = ($param_id == 301) ? '1' : '2';
                                    $values['var_name2']        = 'fuel-Volume-Liter';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'fuel-Volume-Liter-Treshold';
                                    $values['var_val3']         = $treshold;                                    
                                    $values['var_name4']        = 'fuel-Volume-Percent';
                                    $values['var_val4']         = '';
                                    $values['var_name5']        = 'fuel-Volume-Percent-Treshold';
                                    $values['var_val5']         = '';
                                    
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'fuel-Low-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'fuel-Low-Inactive';
                                }
                                # digital input
                                elseif(in_array($param_id, array(401,402,403,404))) {
                                    #$values['trap_specific']    = ($alarm == 1 || $alarm == 2) ? '601' : '621';;
                                    $values['var_name1']        = 'di-Index';
                                    $values['var_val1']         = substr($param_id, 1, strlen($param_id));
                                    $values['var_name2']        = 'di-Value';
                                    $values['var_val2']         = $value;
                                    
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'digital-Input-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'digital-Input-Inactive';
                                }
                            break;
                        }
                        #save if trap_oid is not empty
                        if($values['trap_oid'] != '') $this->TrapModel->save($values);
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
    
    function trap()
    {
        print 'SAVED';
        $uri    = $_SERVER["REQUEST_URI"];
        $ip     = trim($this->input->post('ip'));
        $data   = trim($this->input->post('data'));
        
        #ip=172.25.97.130&data=201:20150605172112:28.0:0.0:0,201:20150605172122:28.200001:0.0:2,201:20150605172152:28.299999:0.0:0,
        #$ip     = '172.25.94.242';
        #$data   = '203:20150510164048:255.5:0.0:2,204:20150510164048:255.5:0.0:2,203:20150510164057:255.5:0.0:0,204:20150510164057:255.5:0.0:0,203:20150510164143:255.5:0.0:2,204:20150510164143:255.5:0.0:2,203:20150510164152:255.5:0.0:0,204:20150510164152:255.5:0.0:0,';
        
        $param  = 'ip='.$ip.'&data='.$data;
        $dtime  = '';
        
        if($ip != '' && $data != '') {
            $node = $this->NodeModel->get_by_ip($ip)->row();
            if(is_object($node)) {
                $data  = substr($data, 0, strlen($data)-1);
                $datas = explode(',', $data);
                foreach($datas as $dt) {
                    if($dt != '') {
                        list($param_id, $dtime, $value, $treshold, $alarm) = explode(':', $dt);
                        $dtime = substr($dtime, 0, 4).'-'.substr($dtime, 4, 2).'-'.substr($dtime, 6, 2).' '.substr($dtime, 8, 2).':'.substr($dtime, 10, 2).':'.substr($dtime, 12, 2);
                        
                        if($alarm == 3) continue;
                        if($value == '255.5') continue;
                        $values                 = array();
                        $values['dtime']        = $dtime;
                        $values['node_id']      = $node->id;
                        $values['agent_addr']   = $ip;
                        $values['from_addr']    = $ip;
                        $values['uptime']       = time();
                        $values['community']    = 'public';
                        $values['trap_type']    = '6';
                        $values['trap_oid']     = '';
                        
                        switch(intval($node->device_id)) {
                            #Simon2000
                            case 1:
                                $values['enterprise'] = 'hmct-Traps';
                                if(in_array($param_id, array(1,2,3,4))) {
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'analog-Input-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'analog-Input-Inactive';
                                    $values['var_name1']    = 'analog-Input-Index';
                                    $values['var_val1']     = $param_id;
                                    $values['var_name2']    = 'analog-Input-Value';
                                    $values['var_val2']     = $value;
                                    $values['var_name3']    = 'analog-Input-Value-Threshold';
                                    $values['var_val3']     = $treshold;
                                }
                                /*
                                elseif(in_array($param_id, array(101,102,104,105,107,108))) {
                                    #$values['trap_specific']    = '';
                                    $values['var_val1']         = $value;
                                    $values['var_val2']         = $treshold;
                                    switch(intval($param_id)) {
                                        # voltage phase R
                                        case 101:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseR-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseR-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseR-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseR';
                                            $values['var_name2']    = 'voltage-PhaseR-Treshold';
                                        break;
                                        
                                        # current phase R
                                        case 102:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseR-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseR-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseR-Inactive';
                                            $values['var_name1']    = 'current-PhaseR';
                                            $values['var_name2']    = 'current-PhaseR-Treshold';
                                        break;
                                        
                                        # voltage phase S
                                        case 104:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseS-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseS-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseS-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseS';
                                            $values['var_name2']    = 'voltage-PhaseS-Treshold';                                      
                                        break;
                                        
                                        # current phase S
                                        case 105:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseS-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseS-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseS-Inactive';
                                            $values['var_name1']    = 'current-PhaseS';
                                            $values['var_name2']    = 'current-PhaseS-Treshold';
                                        break;
                                        
                                        # voltage phase T
                                        case 107:
                                            if($alarm == 1)     $values['trap_oid']         = 'ac-Low-PhaseT-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'ac-High-PhaseT-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'ac-PhaseT-Inactive';
                                            $values['var_name1']    = 'voltage-PhaseT';
                                            $values['var_name2']    = 'voltage-PhaseT-Treshold';
                                        break;
                                        
                                        # current phase T
                                        case 108:
                                            if($alarm == 1)     $values['trap_oid']         = 'current-Low-PhaseT-Active';
                                            elseif($alarm == 2) $values['trap_oid']         = 'current-High-PhaseT-Active';
                                            elseif($alarm == 0) $values['trap_oid']         = 'current-PhaseT-Inactive';
                                            $values['var_name1']    = 'current-PhaseT';
                                            $values['var_name2']    = 'current-PhaseT-Treshold';
                                        break;
                                    }
                                }
                                */
                                # temperature alarm
                                elseif(in_array($param_id, array(201,203))) {
                                    #$values['trap_specific']    = '';
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'temperature-Index';
                                    $values['var_val1']         = ($param_id == 201) ? '1' : '2';
                                    $values['var_name2']        = 'temperature-Value';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'temperature-Value-Threshold';
                                    $values['var_val3']         = $treshold;
                                    if($alarm == 1)     $values['trap_oid'] = 'low-Temperature-Active';
                                    elseif($alarm == 2) $values['trap_oid'] = 'high-Temperature-Active';
                                    elseif($alarm == 0) $values['trap_oid'] = 'high-temperature-Inactive';
                                }
                                # humidity alarm
                                elseif(in_array($param_id, array(202,204))) {
                                    #$values['trap_specific']    = '';
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'humidity-Index';
                                    $values['var_val1']         = ($param_id == 202) ? '1' : '2';
                                    $values['var_name2']        = 'humidity-Value';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'humidity-Value-Threshold';
                                    $values['var_val3']         = $treshold;
                                    if($alarm == 1)     $values['trap_oid'] = 'low-Humidity-Active';
                                    elseif($alarm == 2) $values['trap_oid'] = 'high-Humidity-Active';
                                    elseif($alarm == 0) $values['trap_oid'] = 'high-humidity-Inactive';
                                }
                                /*
                                # fuel
                                elseif(in_array($param_id, array(301,302))) {
                                    #$values['trap_specific']    = ($alarm == 1 || $alarm == 2) ? 605 : 625;
                                    $value                      = $value * 10;
                                    $values['var_name1']        = 'fuel-Index';
                                    $values['var_val1']         = ($param_id == 301) ? '1' : '2';
                                    $values['var_name2']        = 'fuel-Volume-Liter';
                                    $values['var_val2']         = "$value";
                                    $values['var_name3']        = 'fuel-Volume-Liter-Treshold';
                                    $values['var_val3']         = $treshold;                                    
                                    $values['var_name4']        = 'fuel-Volume-Percent';
                                    $values['var_val4']         = '';
                                    $values['var_name5']        = 'fuel-Volume-Percent-Treshold';
                                    $values['var_val5']         = '';
                                    
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'fuel-Low-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'fuel-Low-Inactive';
                                }
                                */
                                # digital input
                                #elseif(in_array($param_id, array(401,402,403,404,405,406,407,408,409,430,431,432))) {
                                #elseif(in_array($param_id, array(402,403,404,405,406))) {
                                elseif(in_array($param_id, array(401,402,403,404))) {
                                    #$values['trap_specific']    = ($alarm == 1 || $alarm == 2) ? '601' : '621';;
                                    $values['var_name1']        = 'di-Index';
                                    $values['var_val1']         = ($param_id < 410) ? substr($param_id, 2, strlen($param_id)) : substr($param_id, 1, strlen($param_id)); 
                                    $values['var_name2']        = 'di-Value';
                                    $values['var_val2']         = $value;
                                    
                                    if($alarm == 1 || $alarm == 2)  $values['trap_oid']         = 'digital-Input-Active';
                                    elseif($alarm == 0)             $values['trap_oid']         = 'digital-Input-Inactive';
                                }
                            break;
                        }
                        #save if trap_oid is not empty
                        if($values['trap_oid'] != '') $this->TrapModel->save($values);
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
        
        $this->HttpModel->save($row);
    }
    
    function mfc()
    {
        $ip = $this->input->post('ip');
        #print $ip;
        $rs   = $this->NodeModel->get_by_ip($ip);
        if($rs->num_rows() > 0) {
            $node   = $rs->row();
            $this->HttpModel->clearmf($node->id);
            print 'Mains Fail was cleared from '.$node->name.' ('.$ip.')';
        }
        else print $ip.' was not registered on NMS';
        $rs->free_result();
    }
    
    function dtime()
    {
        print date('d M Y H:i:s');
    }
}
?>