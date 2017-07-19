<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Dashboard extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        $this->load->model('api/SubnetModel','',TRUE);
        $this->load->model('api/NodeModel','',TRUE);
        $this->load->model('api/CurrentAlarmModel','',TRUE);
        $this->load->model('api/AvailabilityMonthlyModel','',TRUE);
        $this->load->model('api/KwhUsageMonthlyModel','',TRUE);
        //$this->load->model('model_name');
    }
	
    function random_color()
    {
        mt_srand((double)microtime()*1000000);
        $c = '';
        while(strlen($c)<6) $c .= sprintf("%02X", mt_rand(0, 255));
        return $c;
    }
    
    function generateDeviceByRegion($region_id, $device_id)
    {
        if($region_id == 0 || $region_id == '0') $region_id = '';
        $nodes   = "";
        $res    = $this->NodeModel->get_by_region_and_type_id($region_id, $device_id);
        if($res->num_rows() == 0) return $nodes;
        foreach($res->result() as $row) $nodes  .= "'".$row->id."',";
        $res->free_result();    
        return $nodes;
    }
    
	function index()
	{
	    $data['page'] = 'Dashboard';
	    # National Connection Summary
        $siteCon     = $this->SubnetModel->get_site_count('', '');
        $deviceCon   = $this->NodeModel->getCount('', '', '', '', '');
        $deviceUp    = $this->NodeModel->get_count_status(1);
        $deviceDown  = $this->NodeModel->get_count_status(2);        
        $data        = array();
        $data['site_con']   = $siteCon;
        $data['device_con'] = $deviceCon;
        $data['device_up']  = $deviceUp;
        $data['device_down']= $deviceCon - $deviceUp;
        
        # National Alarm Severity Summary
        $critical = $this->CurrentAlarmModel->getCurrentAlarmsCount('', '', '1', '','', '');
        $major = $this->CurrentAlarmModel->getCurrentAlarmsCount('', '', '2', '','', '');
        $minor = $this->CurrentAlarmModel->getCurrentAlarmsCount('', '', '3', '','', '');
        $warn  = $this->CurrentAlarmModel->getCurrentAlarmsCount('', '', '4', '','', '');
        $comm  = $this->CurrentAlarmModel->getCurrentAlarmsCount('', '', '5', '','', '');
        
        $data['severity'] = array(
            array('label'=>'Critical', 'value'=>(int)$critical, 'link'=>"JavaScript:severityDetail('Critical','1');", 'color'=>'#FF0000'),
            array('label'=>'Major', 'value'=>(int)$major, 'link'=>"JavaScript:severityDetail('Major','2');", 'color'=>'#0A0FE2'),
            array('label'=>'Minor', 'value'=>(int)$minor, 'link'=>"JavaScript:severityDetail('Minor','3');", 'color'=>'#700AE2'),
            array('label'=>'Warning', 'value'=>(int)$warn, 'link'=>"JavaScript:severityDetail('Warning','4');", 'color'=>'#E28E0A'),
            array('label'=>'Comm', 'value'=>(int)$comm, 'link'=>"JavaScript:severityDetail('Communication','5');", 'color'=>'#A9ABAE')
        );
        
        # National Inventory Summary
        $inv   = $this->NodeModel->get_device_stat()->result();
        $colors= array('#000FFF', '#F8FF01', '#FF6600', '#FF0F00', '#FF9E01', '#FF9E01', '#B0DE09', '#04D215', '#FCD202', '#0D8ECF', '#0D52D1', '#2A0CD0', '#8A0CCF', '#CD0D74', '#754DEB', '#DDDDDD');
        $i=0;
        foreach($inv as $row) {
            $inv[$i]->color = $colors[$i]; #'#'.$this->random_color();
            $inv[$i]->link  = "JavaScript:deviceDetail('','".$row->id."');";
            $i++;
        }
        $data['inv']    = $inv;
        
        $lastmonth = date('F Y', time() - ((date('d')) * 86400));
        $thismonth = date("F Y");
        
        $month1 = (int)date('m', time() - ((date('d')) * 86400));
        $month2 = (int)date('m');
        
        $year1 = (int)date('Y', time() - ((date('d')) * 86400));
        $year2 = (int)date('Y');                
        
        $data['lastmonth'] = $lastmonth;
        $data['thismonth'] = $thismonth;
        $data['month1']    = $month1;
        $data['month2']    = $month2;
        $data['year1']     = $year1;
        $data['year2']     = $year2;
        
        $availability    = array();
        $kwh             = array();
        
        $regions    = $this->SubnetModel->getRegion()->result();
        $i=0;
        foreach($regions as $region)
        {
            $hosts   = $this->generateDeviceByRegion($region->id, 2);
            if(!empty($hosts)) $hosts = substr($hosts, 0, strlen($hosts) - 1);
            
            // AV
            $availability[$i]['region']     = $region->name;
            $availability[$i][$lastmonth]   = $this->AvailabilityMonthlyModel->get_rect_av_mon_region($hosts, $month1, $year1);
            $availability[$i][$thismonth]   = $this->AvailabilityMonthlyModel->get_rect_av_mon_region($hosts, $month2, $year2);
            $availability[$i]['preurl']     = "JavaScript:detailAv('".date('m-Y', time() - ((date('d')) * 86400))."', '".$region->id."', '".$lastmonth."');";
            $availability[$i]['cururl']     = "JavaScript:detailAv('".date('m-Y')."', '".$region->id."', '".$thismonth."');";
            
            // KWH
            $hosts   = $this->generateDeviceByRegion($region->id, 1);
            if(!empty($hosts)) $hosts = substr($hosts, 0, strlen($hosts) - 1);
            
            $kwh[$i]['region']              = $region->name;
            $kwh[$i][$lastmonth]            = $this->KwhUsageMonthlyModel->get_usage_mon_region($hosts, $month1, $year1);
            $kwh[$i][$thismonth]            = $this->KwhUsageMonthlyModel->get_usage_mon_region($hosts, $month2, $year2);
            $kwh[$i]['preurl']              = "JavaScript:detailKWH('".date('m-Y', time() - ((date('d')) * 86400))."', '".$region->id."', '".$lastmonth."');";
            $kwh[$i]['cururl']              = "JavaScript:detailKWH('".date('m-Y')."', '".$region->id."', '".$thismonth."');";
            
            $i++;
        }
        
        $data['av']     = $availability;
        $data['kwh']    = $kwh;        
        
		$this->load->view('dashboard', $data);
	}
}

/* End of file Dashboard.php */
/* Location: ./application/controllers/Dashboard.php */
?>