<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

if ( ! function_exists('load_menu'))
{
    
    function load_menu()
    {
        $CI =& get_instance();
        $CI->load->model('api/SubnetModel','',TRUE);
        
        $region = $CI->SubnetModel->getRegion()->result();
        $menu   = '';
        foreach($region as $r)
        {
            $menu   .= '<li class="nav-item">
                            <a href="javascript:;" class="nav-link nav-toggle">
                                <i class="icon-globe"></i>
                                <span class="title">'.$r->name.'</span>';
            if($CI->SubnetModel->has_child($r->id) > 0)   $menu .= '<span class="arrow"></span>';
            $menu   .= '</a>';
            $menu   .= generate_child($r, 0);
            $menu   .= '</li>';
        }
        return $menu;
        #print 'menu loaded';
    }
    
    function generate_child($subnet, $level)
    {
        $CI =& get_instance();
        $CI->load->model('api/SubnetModel','',TRUE);
        
        if($level > 2) $level = 0;
        $level++;
        
        $menu   = '';
        $res    = $CI->SubnetModel->get_by_parentid($subnet->id);
        if($res->num_rows() == 0) return $menu;
        else {
            $menu   .= '<ul class="sub-menu">';
            foreach($res->result() as $row)
            {
                $menu .= '<li class="nav-item">';
                if($CI->SubnetModel->has_child($row->id) > 0) {
                    $menu   .= '<a href="javascript:;" class="nav-link nav-toggle">
                                <i class="fa fa-sitemap"></i> '.$row->name.'
                                <span class="arrow"></span>';
                }
                else {
                    $menu   .= '<a href="'.base_url().'subnet/view/'.$row->id.'" class="nav-link">
                                <i class="icon-pointer"></i> '.$row->name;
                }
                $menu .= '</a>';
                $menu .= generate_child($row, $level);
                $menu .= '</li>';
            }
            $menu   .= '</ul>';
        }
        $res->free_result();
        return $menu;
    }
}
?>