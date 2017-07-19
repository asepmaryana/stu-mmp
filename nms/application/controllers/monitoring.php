<?php
class Monitoring extends CI_Controller 
{
	function __construct()
	{
		parent::__construct();
        #session_start();
		#if ($this->session->userdata('username') == "") redirect('login');			
        date_default_timezone_set("Asia/Jakarta");
        
		// load model
		$this->load->model('api/PollModel','',TRUE);
        $this->load->model('api/NodeModel','',TRUE);
        $this->load->model('api/HttpModel','',TRUE);
        $this->load->model('api/CurrentAlarmModel','',TRUE);
        $this->load->model('api/TresholdModel','',TRUE);
        $this->load->model('api/TrapModel','',TRUE);
	}
    
    function index() { print 'Monitoring Index'; }
    
    function trap()
    {
        print 'SAVED';
        
        $uri    = $_SERVER["REQUEST_URI"];
        $ip     = trim($this->input->post('ip'));
        $data   = trim($this->input->post('data'));
        
        #$ip     = '192.168.1.100';
        #$data   = '1:0.0:20160719032912:1:10.0:14.0,2:0.0:20160719032912:1:2.0:3.0,3:0.0:20160719032912:1:4.0:5.0,4:0.0:20160719032912:1:6.0:7.0,401:1.0:20160719032914:1:0.0:0.0,402:1.0:20160719032914:1:0.0:0.0,403:1.0:20160719032914:1:0.0:0.0,404:1.0:20160719032914:1:0.0:0.0,405:1.0:20160719032914:1:0.0:0.0,406:1.0:20160719032914:1:0.0:0.0,407:1.0:20160719032914:1:0.0:0.0,408:1.0:20160719032914:1:0.0:0.0,201:27.1:20160719032915:0:0.0:45.0,202:75.599998:20160719032915:2:0.0:70.0,';
        
        $param  = 'ip='.$ip.'&data='.$data;        
        $dtime  = '';
        
        if($ip != '' && $data != '') {
            $node = $this->NodeModel->get_by_ip($ip)->row();
            $rect = '';
            if(is_object($node)) {
                $data  = substr($data, 0, strlen($data)-1);
                $datas = explode(',', $data);
                foreach($datas as $dt) {
                    if($dt != '') {
                        list($param_id, $value, $dtime, $alarm, $min, $max) = explode(':', $dt);
                        $dtime = substr($dtime, 0, 4).'-'.substr($dtime, 4, 2).'-'.substr($dtime, 6, 2).' '.substr($dtime, 8, 2).':'.substr($dtime, 10, 2).':'.substr($dtime, 12, 2);
                        
                        # $alarm = 3 --> comm lost
                        if(intval($alarm) != 3) {
                            $values             = array();
                            $values['node_id']  = $node->id;
                            $values['device_object_id'] = '';
                            $values['dtime']    = $dtime;
                            $values['value']    = floatval($value);
                            
                            switch(intval($node->device_id)) {
                                #simon2000
                                case 1:
                                    #batt Voltage
                                    if(intval($param_id) == 1)    $values['device_object_id'] = 82;
                                    #phase1
                                    elseif(intval($param_id) == 101)    $values['device_object_id'] = 94;
                                    elseif(intval($param_id) == 102)    $values['device_object_id'] = 95;
                                    elseif(intval($param_id) == 103)    $values['device_object_id'] = 96;
                                    elseif(intval($param_id) == 104)    $values['device_object_id'] = 97;
                                    elseif(intval($param_id) == 105)    $values['device_object_id'] = 98;
                                    elseif(intval($param_id) == 106)    $values['device_object_id'] = 99;
                                    elseif(intval($param_id) == 107)    $values['device_object_id'] = 100;
                                    elseif(intval($param_id) == 108)    $values['device_object_id'] = 101;
                                    elseif(intval($param_id) == 109)    $values['device_object_id'] = 102;
                                    
                                    #phase2
                                    elseif(intval($param_id) == 121)    $values['device_object_id'] = 103;
                                    elseif(intval($param_id) == 122)    $values['device_object_id'] = 104;
                                    elseif(intval($param_id) == 123)    $values['device_object_id'] = 105;
                                    elseif(intval($param_id) == 124)    $values['device_object_id'] = 106;
                                    elseif(intval($param_id) == 125)    $values['device_object_id'] = 107;
                                    elseif(intval($param_id) == 126)    $values['device_object_id'] = 108;
                                    elseif(intval($param_id) == 127)    $values['device_object_id'] = 109;
                                    elseif(intval($param_id) == 128)    $values['device_object_id'] = 110;
                                    elseif(intval($param_id) == 129)    $values['device_object_id'] = 111;
                                    
                                    #t/h
                                    elseif(intval($param_id) == 201)    $values['device_object_id'] = 112; #temperature1
                                    elseif(intval($param_id) == 202)    $values['device_object_id'] = 113; # humidity1
                                    elseif(intval($param_id) == 203)    $values['device_object_id'] = 114; #temperature2
                                    elseif(intval($param_id) == 204)    $values['device_object_id'] = 115; # humidity2
                                    
                                    elseif(intval($param_id) == 301)    $values['device_object_id'] = 116; # tank 1
                                    elseif(intval($param_id) == 302)    $values['device_object_id'] = 117; # tank 2
                                break;
                                
                                #AEG ACM1000
                                case 2:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 16; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                break;
                                
                                #Emerson M800D
                                case 3:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 27; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                break;
                                
                                #Emerson M810G
                                case 4:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 43; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                break;
                                
                                #Powerone
                                case 5:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 34; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                    
                                    if($rect != '') $values['node_id']  = $rect->id;
                                break;
                                
                                #AEG CTVT
                                case 6:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 38; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                    
                                    if($rect != '') $values['node_id']  = $rect->id;
                                break;
                                
                                #SC200
                                case 7:
                                    if(intval($param_id) == 1)        $values['device_object_id'] = 43; #battery voltage
                                    elseif(intval($param_id) == 2)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 3)    $values['device_object_id'] = '';
                                    elseif(intval($param_id) == 4)    $values['device_object_id'] = '';
                                break;
                            }
                            
                            if($values['device_object_id'] != '') $this->PollModel->save($values);
                            
                            if($values['device_object_id'] == 82) {
                                # update alarm battery voltage
                                $alarm_list_id  = 10;
                                $alarm_index    = 1;
                                $node_id        = $node->id;
                                #$alarm_count    = $this->CurrentAlarmModel->get_count_alarm($node_id, $alarm_list_id);
                                $treshold       = $this->TresholdModel->get_by_node_object($node_id, 82)->row();
                                
                                $trap             = array();
                                $trap['dtime']    = date('Y-m-d H:i:s');
                                $trap['node_id']  = $node_id;
                                $trap['agent_addr']       = $node->address;
                                $trap['from_addr']        = $node->address;
                                $trap['uptime']           = time();
                                $trap['community']        = 'public';
                                $trap['enterprise']       = 'hmct-Traps';
                                $trap['trap_type']        = 6;
                                $trap['var_name1']        = 'analog-Input-Index';
                                $trap['var_val1']         = $alarm_index;
                                $trap['var_name2']        = 'analog-Input-Value';
                                $trap['var_val2']         = floatval($value);
                                $trap['var_name3']        = 'analog-Input-Value-Threshold';
                                $trap['var_val3']         = floatval($treshold->min_value);
                                
                                if(floatval($value) < floatval($treshold->min_value)) $trap['trap_oid']         = 'analog-Input-Active';
                                else $trap['trap_oid']         = 'analog-Input-Inactive';
                                
                                $this->TrapModel->save($trap);
                            }
                            elseif($values['device_object_id'] == 112) {
                                # update alarm temperature1
                                $alarm_list_id  = 8;
                                $alarm_index    = 1;
                                $node_id        = $node->id;
                                if(floatval($value) > 100) $value = floatval($value)/10;
                                #$alarm_label    = 'High Temperature Room Value '.round($value, 2).', treshold:'.round($max, 2);
                                $alarm_label    = 'High Temperature Room Value '.round($value, 2);
                                $this->CurrentAlarmModel->update_label($alarm_label, $node_id, $alarm_list_id, $alarm_index);
                            }
                            elseif($values['device_object_id'] == 113) {
                                # update alarm humidity1
                                $alarm_list_id  = 9;
                                $alarm_index    = 1;
                                $node_id        = $node->id;
                                if(floatval($value) > 100) $value = floatval($value)/10;
                                #$alarm_label    = 'High Humidity Room Value '.round($value, 2).', treshold:'.round($max, 2);
                                $alarm_label    = 'High Humidity Room Value '.round($value, 2);
                                $this->CurrentAlarmModel->update_label($alarm_label, $node_id, $alarm_list_id, $alarm_index);
                            }
                            elseif($values['device_object_id'] == 114) {
                                # update alarm temperature
                                $alarm_list_id  = 8;
                                $alarm_index    = 2;
                                $node_id        = $node->id;
                                if(floatval($value) > 100) $value = floatval($value)/10;
                                #$alarm_label    = 'High Temperature Room Value '.round($value, 2).', treshold:'.round($max, 2);
                                $alarm_label    = 'High Temperature Room Value '.round($value, 2);
                                $this->CurrentAlarmModel->update_label($alarm_label, $node_id, $alarm_list_id, $alarm_index);
                            }
                            elseif($values['device_object_id'] == 115) {
                                # update alarm temperature
                                $alarm_list_id  = 9;
                                $alarm_index    = 2;
                                $node_id        = $node->id;
                                if(floatval($value) > 100) $value = floatval($value)/10;
                                #$alarm_label    = 'High Humidity Room Value '.round($value, 2).', treshold:'.round($max, 2);
                                $alarm_label    = 'High Humidity Room Value '.round($value, 2);
                                $this->CurrentAlarmModel->update_label($alarm_label, $node_id, $alarm_list_id, $alarm_index);
                            }
                        }
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
}
?>