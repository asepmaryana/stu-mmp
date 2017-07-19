<?php
class AlarmSeverityModel extends CI_Model 
{
	
	public $table	= 'pms.alarm_severity';

	function __construct()
	{
		parent::__construct();
	}
	
	function count_all()
	{
		return $this->db->count_all($this->table);
	}
	
	function get_paged_list($limit = 10, $offset = 0)
	{
		$this->db->order_by('id','asc');
		return $this->db->get($this->table, $limit, $offset);
	}
	
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
	function save($data)
	{
		$this->db->insert($this->table, $data);
		return $this->db->insert_id();
	}
	
	function update($id='', $data)
	{
		if($id != '') $this->db->where('id', $id);
		$this->db->update($this->table, $data);
	}
	
    function updates($ids=array(), $data)
	{
		$this->db->where_in('id', $ids);
		$this->db->update($this->table, $data);
	}
    
	function delete($id)
	{
		$this->db->where('id', $id);
		$this->db->delete($this->table);
	}
    
    function getRows()
	{
	    $this->db->order_by('id','asc');
	    return $this->db->get($this->table);
	}    
}
?>