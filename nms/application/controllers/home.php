<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Home extends CI_Controller {
    
    function __construct()
    {
        parent::__construct();
        session_start();
        if($this->session->userdata('uid') == '') redirect('../login');
        $this->load->model('api/SubnetModel','',TRUE);
        $this->load->model('api/AlarmSeverityModel','',TRUE);
    }
	
	function index()
	{	    
	    $topolog            = '';
        $region             = $this->SubnetModel->getRegion()->result();
        /*
        $menu               = '';
        foreach($region as $r)
        {
            $menu   .= '<li class="nav-item">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-globe"></i>
                                <span class="title">'.$r->name.'</span>';
            if($this->SubnetModel->has_child($r->id) > 0)   $menu .= '<span class="arrow"></span>';
            $menu   .= '</a>';
            $menu   .= $this->generateChild($r, 0);
            $menu   .= '</li>';
        }
        */
	    $data['page']       = 'Home';
        $data['region']     = $region;
        $data['severity']   = $this->AlarmSeverityModel->getRows()->result();
        #$data['menu']       = $menu;
        
        #print $menu;
		$this->load->view('home', $data);
        #print $this->generateTree('', '', 0);
	}
    
    function generateChild($subnet, $level)
    {
        if($level > 2) $level = 0;
        $level++;
        
        $menu   = '';
        $res    = $this->SubnetModel->get_by_parentid($subnet->id);
        if($res->num_rows() == 0) return $menu;
        else {
            $menu   .= '<ul class="sub-menu">';
            foreach($res->result() as $row)
            {
                $menu .= '<li class="nav-item">';
                if($this->SubnetModel->has_child($row->id) > 0) {
                    $menu   .= '<a href="javascript:;" class="nav-link nav-toggle">
                                <i class="fa fa-sitemap"></i> '.$row->name.'
                                <span class="arrow"></span>';
                }
                else {
                    $menu   .= '<a href="'.base_url().'subnet/view/'.$row->id.'" class="nav-link">
                                <i class="icon-pointer"></i> '.$row->name;
                }
                $menu   .= '</a>';
                $menu .= $this->generateChild($row, $level);
                $menu .= '</li>';
            }
            $menu   .= '</ul>';
        }
        
        return $menu;
    }
}

/* End of file home.php */
/* Location: ./application/controllers/home.php */
?>