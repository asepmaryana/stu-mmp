<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Subnet extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        $this->load->model('api/SubnetModel','',TRUE);
        $this->load->model('api/NodeModel','',TRUE);
        $this->load->model('api/SiteConfigModel','',TRUE);
        $this->load->model('api/CurrentAlarmModel','',TRUE);
        $this->load->model('api/AlarmSeverityModel','',TRUE);
        $this->load->helper('http_ping');
    }
	
    function view()
    {
        $subnet_id    = $this->uri->segment(3);
        $row          = $this->SubnetModel->getRow($subnet_id)->row();
        $nodes        = $this->NodeModel->get_by_subnet_id($subnet_id)->result();        
        $info         = $this->SubnetModel->get_info($subnet_id)->row();
        
        $siteName     = (is_object($row)) ? $row->name : "";
        $siteType     = (is_object($row)) ? $row->site_type_id : 1;        
        $site_img     = '';
        $mini         = '';
        $mct          = $this->SubnetModel->getDevice($subnet_id, 1)->row(); // mct
        $label        = '';
        
        $batteryVoltage = 0;
        $vr     = 0;
        $vs     = 0;
        $vt     = 0;
        $ir     = 0;
        $is     = 0;
        $it     = 0;
        $pr     = 0;
        $ps     = 0;
        $pt     = 0;
        $mfr    = 0;
        $mfs    = 0;
        $mft    = 0;
        $temp   = 0;
        $humi   = 0;
        $dor    = 0;
                
        if(is_object($mct)) {
            if(http_ping('http://'.$mct->address) >= 200) {
                $label  = $mct->name.' ['.$mct->address.']';
                # read monitoring status
                $url    = 'http://'.$mct->address.'/status';
                $ch     = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
                #curl_setopt($ch, CURLOPT_POST, 2);
                #curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                $msg    = curl_exec ($ch);
                curl_close ($ch);
                
                $recs   = json_decode($msg);
                if(isset($recs->rows) && count($recs->rows) > 0):
                foreach($recs->rows as $rec)
                {
                    if($rec->id == 1) $batteryVoltage = round(floatval($rec->value), 1);
                    elseif($rec->id == 101) $vr = round(floatval($rec->value), 1);
                    elseif($rec->id == 102) $ir = round(floatval($rec->value), 1);
                    elseif($rec->id == 103) $pr = round(floatval($rec->value), 1);                    
                    elseif($rec->id == 104) $vs = round(floatval($rec->value), 1);
                    elseif($rec->id == 105) $is = round(floatval($rec->value), 1);
                    elseif($rec->id == 106) $ps = round(floatval($rec->value), 1);
                    elseif($rec->id == 107) $vt = round(floatval($rec->value), 1);
                    elseif($rec->id == 108) $it = round(floatval($rec->value), 1);
                    elseif($rec->id == 109) $pt = round(floatval($rec->value), 1);
                    elseif($rec->id == 201) $temp = round(floatval($rec->value), 2);
                    elseif($rec->id == 202) $humi = round(floatval($rec->value), 2);
                    elseif($rec->id == 401) $mfr = $rec->value;
                    elseif($rec->id == 402) $mfs = $rec->value;
                    elseif($rec->id == 403) $mft = $rec->value;
                    elseif($rec->id == 404) $dor = $rec->value;
                }
                endif;
            }
            else $label = 'LOST CONTACT';
        }
        else $label  = "MCT : N/A";
        
        $site_img                = 'simon2000d.jpg';
        $pln_on                  = ($vr > 0 || $vs > 0 || $vt > 0) ? true : false; 
        $main_fail_on            = $this->CurrentAlarmModel->is_main_fail_exists($subnet_id);
        $pln_status              = ($main_fail_on) ? 'OFF' : 'ON';
        
        $door_open_on            = $this->CurrentAlarmModel->is_door_open_exists($subnet_id);
        $door_status             = ($door_open_on) ? 'OPEN' : 'CLOSED';
        
        $data                    = array();
        $data['site']            = $row;
        $data['nodes']           = $nodes;
        $data['siteId']          = $subnet_id;
        $data['siteName']        = $row->name;
        $data['title_site']      = 'SITE '.strtoupper($siteName);
        $data['type_site']       = $siteType;
        $data['info']            = $info;
        $data['site_img']        = $site_img;
        $data['label']           = $row->name;
        $data['vr']              = $vr;
        $data['vs']              = $vs;
        $data['vt']              = $vt;
        $data['ir']              = $ir;
        $data['is']              = $is;
        $data['it']              = $it;
        $data['pr']              = $pr;
        $data['ps']              = $ps;
        $data['pt']              = $pt;
        $data['mfr']             = $mfr;
        $data['mfs']             = $mfs;
        $data['mft']             = $mft;
        $data['temp']            = $temp;
        $data['humi']            = $humi;
        $data['batteryVoltage']  = $batteryVoltage;
        $data['pln_on']          = $pln_on;
        $data['pln_status']      = $pln_status;
        $data['main_fail_on']    = $main_fail_on;
        $data['severity']        = $this->AlarmSeverityModel->getRows()->result();
        $data['door_status']     = $door_status;
        
        $this->load->view('realtime/site', $data);
        #print '<pre>';
        #print_r($data);
        #print '</pre>';
    }
    
    function get_data()
    {
        $subnet_id    = $this->uri->segment(3);
        $rs          = $this->SubnetModel->getDevice($subnet_id, 1);
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            if(http_ping('http://'.$row->address) >= 200) {
                # read monitoring status
                $url    = 'http://'.$row->address.'/status';
                $ch     = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 300);
                #curl_setopt($ch, CURLOPT_POST, 2);
                #curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                $msg    = curl_exec ($ch);
                curl_close ($ch);
                
                $recs   = json_decode($msg);
                if(isset($recs->rows) && count($recs->rows) > 0):
                    $bv = '';
                    $vr = '';
                    $ir = '';
                    $pr = '';
                    $vs = '';
                    $is = '';
                    $ps = '';
                    $vt = '';
                    $it = '';
                    $pt = '';
                    $temp   = '';
                    $humi   = '';
                    $mfr    = '';
                    $mfs    = '';
                    $mft    = '';
                    $dor    = '';
                    foreach($recs->rows as $rec)
                    {
                        if($rec->id == 1) $bv = round(floatval($rec->value), 1);
                        elseif($rec->id == 101) $vr = round(floatval($rec->value), 1);
                        elseif($rec->id == 102) $ir = round(floatval($rec->value), 1);
                        elseif($rec->id == 103) $pr = round(floatval($rec->value), 1);                    
                        elseif($rec->id == 104) $vs = round(floatval($rec->value), 1);
                        elseif($rec->id == 105) $is = round(floatval($rec->value), 1);
                        elseif($rec->id == 106) $ps = round(floatval($rec->value), 1);
                        elseif($rec->id == 107) $vt = round(floatval($rec->value), 1);
                        elseif($rec->id == 108) $it = round(floatval($rec->value), 1);
                        elseif($rec->id == 109) $pt = round(floatval($rec->value), 1);
                        elseif($rec->id == 201) $temp = round(floatval($rec->value), 2);
                        elseif($rec->id == 202) $humi = round(floatval($rec->value), 2);
                        elseif($rec->id == 401) $mfr = $rec->value;
                        elseif($rec->id == 402) $mfs = $rec->value;
                        elseif($rec->id == 403) $mft = $rec->value;
                        elseif($rec->id == 404) $dor = $rec->value;
                    }
                    
                    $pln_on                  = ($vr > 0 || $vs > 0 || $vt > 0) ? true : false; 
                    $main_fail_on            = $this->CurrentAlarmModel->is_main_fail_exists($subnet_id);
                    $pln_status              = ($main_fail_on) ? 'OFF' : 'ON';
                    $door_open_on            = $this->CurrentAlarmModel->is_door_open_exists($subnet_id);
                    $door_status             = ($door_open_on) ? 'OPEN' : 'CLOSED';

                    $data       = array();
                    $data['bv'] = $bv;
                    $data['vr'] = $vr;
                    $data['ir'] = $ir;
                    $data['pr'] = $pr;
                    $data['vs'] = $vs;
                    $data['is'] = $is;
                    $data['ps'] = $ps;
                    $data['vt'] = $vt;
                    $data['it'] = $it;
                    $data['pt'] = $pt;
                    $data['temp'] = $temp;
                    $data['humi'] = $humi;
                    $data['mfr']  = $mfr;
                    $data['mfs']  = $mfs;
                    $data['mft']  = $mft;
                    $data['dor']  = $door_status;
                    $data['pln']  = $pln_status;
                    print json_encode(array('success'=>true, 'msg'=>'Data read succeeed.', 'data'=>$data));
                    
                else:
                    print json_encode(array('success'=>false, 'msg'=>'Data is empty.'));
                endif;
            }
            else print json_encode(array('success'=>false, 'msg'=>'Simon is unreachable.'));
        }
        else print json_encode(array('success'=>false, 'msg'=>'Simon does not exists.'));
    }
    
    function get_status_ac()
    {
        $subnet_id = $this->uri->segment(3);
        $mct       = $this->SubnetModel->getDevice($subnet_id, 1)->row();
        if(http_ping('http://'.$mct->address) >= 200) {
            $img = ($this->CurrentAlarmModel->is_main_fail_exists($subnet_id)) ? '01B.png' : '01A.png';
            print base_url().'assets/images/'.$img;
        }
        else print base_url().'assets/images/01B.png';
    }     
    
    function get_status_rect()
    {
        $subnet_id = $this->uri->segment(3);
        $mct       = $this->SubnetModel->getDevice($subnet_id, 1)->row();
        if(http_ping('http://'.$mct->address) >= 200) {
            $img = ($this->CurrentAlarmModel->is_main_fail_exists($subnet_id)) ? '02B.png' : '02A.png';
            print base_url().'assets/images/'.$img;
        }
        else print base_url().'assets/images/02B.png';
    } 
    
    function get_status_temp()
    {
        $subnet_id = $this->uri->segment(3);
        $mct       = $this->SubnetModel->getDevice($subnet_id, 1)->row();
        if(http_ping('http://'.$mct->address) >= 200) {
            $img = ($this->CurrentAlarmModel->is_temp_exists($subnet_id)) ? '05B.png' : '05A.png';
            print base_url().'assets/images/'.$img;
        }
        else print base_url().'assets/images/05B.png';
    }
    
    function get_status_door()
    {
        $subnet_id = $this->uri->segment(3);
        $mct       = $this->SubnetModel->getDevice($subnet_id, 1)->row();
        if(http_ping('http://'.$mct->address) >= 200) {
            $img = ($this->CurrentAlarmModel->is_door_open_exists($subnet_id)) ? '06B.png' : '06A.png';
            print base_url().'assets/images/'.$img;
        }
        else print base_url().'assets/images/06B.png';
    }
    
    function get_status_batt()
    {
        $subnet_id = $this->uri->segment(3);
        $mct       = $this->SubnetModel->getDevice($subnet_id, 1)->row();
        if(http_ping('http://'.$mct->address) >= 200) {
            $img = ($this->CurrentAlarmModel->is_batt_warn_exists($subnet_id)) ? '07C.png' : '07A.png';
            print base_url().'assets/images/'.$img;
        }
        else print base_url().'assets/images/07B.png';
    }
}
/* End of file subnet.php */
/* Location: ./application/controllers/subnet.php */
?>