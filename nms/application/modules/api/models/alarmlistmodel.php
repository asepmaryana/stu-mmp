<?php
class AlarmListModel extends CI_Model 
{
	// table name
	public $table	= 'pms.alarm_list';

	function __construct()
	{
		parent::__construct();
	}
	
	// get number of alarm_list in database
	function getCount($name, $device, $severity)
	{
	    $cari  = str_replace('_', ' ', $name);
        $cari  = strtolower(trim($cari));
		$sql   = "select count(id) as total from ".$this->table." ";
        if($cari != '') $sql    .= "where lower(alarm_name) like '%".$cari."%' ";
        if($device != '_') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_id = '$device' ";
            else $sql    .= "where device_id = '$device' ";
        }
        if($severity != '_') {
            if(preg_match('/where/', $sql)) $sql    .= "and alarm_severity_id = '$severity' ";
            else $sql    .= "where alarm_severity_id = '$severity' ";
        }
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	// get alarm_list with paging
	function get_paged_list($name, $device, $severity, $sort, $order, $limit = 10, $offset = 0)
	{
	    $cari  = str_replace('_', ' ', $name);
        $cari  = strtolower(trim($cari));
        #print $cari;
        if($cari != '') $this->db->like('alarm_name', $cari);
        if($device != '_') $this->db->where('device_id', $device);
        if($severity != '_') $this->db->where('alarm_severity_id', $severity);
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table.'_view', $limit, $offset);
	}
	
    function get_alarm_list($device, $severity=array(), $sort, $order)
	{
	    $this->db->select('id, alarm_name');
        if(!empty($device)) $this->db->where('device_id', $device);
        if(count($severity)>0) $this->db->where_in('alarm_severity_id', $severity);
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table);
	}
    
    function get_list()
	{
		$this->db->order_by('device_id', 'asc');
		return $this->db->get($this->table.'_view');
	}
    
	// get alarm_list by id
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
	// add new alarm_list
	function save($data)
	{
		return $this->db->insert($this->table, $data);
	}
	
	// update alarm_list by id
	function update($id='', $data)
	{
		if($id != '') $this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
    function updates($ids=array(), $data)
	{
		$this->db->where_in('id', $ids);
		$this->db->update($this->table, $data);
	}
    
	// delete alarm_list by id
	function delete($id)
	{
		$this->db->where('id', $id);
		$this->db->delete($this->table);
	}
    
    function getAlarmName($device_type_id, $severity_id)
    {
        $sql    = "SELECT id, alarm_name FROM pms.alarm_list ";
        if($device_type_id != '_') $sql    .= "WHERE device_id IN ($device_type_id)";
        if($severity_id != '_') {
            if(preg_match("/WHERE/", $sql)) $sql    .= "AND alarm_severity_id IN ($severity_id) ";
            else $sql    .= "WHERE alarm_severity_id IN ($severity_id) ";
        }
        $sql    .= "ORDER BY device_id, id ";        
        
        #print $sql."<br>";
        return $this->db->query($sql);
    }
    
    function getRows($device_type_id)
	{
	    $sql   = "select id, alarm_name from pms.alarm_list ";
        if(!empty($device_type_id)) $sql    .= "where device_id in ($device_type_id) ";
        $sql    .= "order by alarm_name ";
		return $this->db->query($sql);
	}    
}
?>