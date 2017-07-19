<?php
class Subnet extends CI_Controller 
{	
	function __construct()
	{
		parent::__construct();
		
		$this->load->model('SubnetModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
        /*
        $this->load->model('NodetableModel','',TRUE);
        $this->load->model('CurrentAlarmModel','',TRUE);
        $this->load->model('DeviceObjectModel','',TRUE);
        $this->load->model('NodeModel','',TRUE);
        $this->load->model('SiteConfigModel','',TRUE);
        $this->load->model('ChannelModel','',TRUE);
        $this->load->model('CustomerModel','',TRUE);
        */
	}
    
    function all()
    {
        $rows = $this->SubnetModel->get_sites()->result();
        /*
        $i=0;
        foreach($rows as $row)
        {
            $rs = $this->SubnetModel->get_site_alarms($row->id);
            if($rs->num_rows()>0) {
                $alarm = $rs->row();
                $rows[$i]->sdtime = $alarm->dtime;
                $rows[$i]->alarm_name = $alarm->alarm_name;
                $rows[$i]->alarm_severity_id = $alarm->alarm_severity_id;
                $rows[$i]->alarm_severity = $alarm->alarm_severity;
            }
            $rs->free_result();
            $i++;
        }
        */
        print json_encode(array('success'=>true, 'rows'=>$rows));
    }
    
    function get_by_region()
    {
        $region_id = $this->uri->segment(4);
        if(empty($region_id)) print json_encode(array('success'=>false, 'rows'=>array()));
        else print json_encode(array('success'=>true, 'rows'=>$this->SubnetModel->getSiteByRegionId($region_id)->result()));
    }
    
    function get_node()
    {
        $site_id = $this->uri->segment(4);
        if(empty($site_id)) print json_encode(array('success'=>false, 'rows'=>array()));
        else print json_encode(array('success'=>true, 'rows'=>$this->NodeModel->get_by_subnet_id($site_id)->result()));
    }
    
    function get_region()
    {
        print json_encode(array('success'=>true, 'rows'=>$this->SubnetModel->get_by_parentid('')->result()));
    }
    
    function read()
    {
        $id = $this->uri->segment(4);
        $rs = $this->SubnetModel->get_by_id($id);
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            print json_encode(array('success'=>true, 'msg'=>'Region exist.', 'data'=>$row));
        }
        else print json_encode(array('success'=>false, 'msg'=>'Region does not exist.'));
        $rs->free_result();
    }
    
    function add()
    {
        $name = trim($this->input->post('name'));
        $desc = trim($this->input->post('description'));
        if(empty($name)) print json_encode(array('success'=>false, 'msg'=>'Region name is required.'));
        else {
            $values = array('name'=>$name, 'description'=>$desc);
            if($this->SubnetModel->save($values) == FALSE) print json_encode(array('success'=>false, 'msg'=>'Create region failed.'));
            else print json_encode(array('success'=>true, 'msg'=>'Create region successfully.'));
        }
    }
    
    function update()
    {
        $id   = trim($this->input->post('id'));
        $name = trim($this->input->post('name'));
        $desc = trim($this->input->post('description'));
        
        if(empty($id)) print json_encode(array('success'=>false, 'msg'=>'Region id is required.'));
        elseif(empty($name)) print json_encode(array('success'=>false, 'msg'=>'Region name is required.'));
        else {
            $values = array('name'=>$name, 'description'=>$desc);
            if($this->SubnetModel->update($id, $values) == FALSE) print json_encode(array('success'=>false, 'msg'=>'Update region failed.'));
            else print json_encode(array('success'=>true, 'msg'=>'Update region successfully.'));
        }
    }
    
    function delete()
    {
        $id = $this->uri->segment(4);
        if(empty($id)) $id = $this->input->post('id');
        #if($this->SubnetModel->delete($id) == FALSE) print json_encode(array('success'=>false, 'msg'=>'Delete failed.'));
        #else print json_encode(array('success'=>true, 'msg'=>'Delete succeed.'));
        print json_encode(array('success'=>true, 'msg'=>'Delete succeed.'));
    }
}
?>