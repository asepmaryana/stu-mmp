<?php
class TresholdModel extends CI_Model 
{
	// table name
	public $table	= 'pms.treshold';

	function __construct()
	{
		parent::__construct();
	}
    
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
    function get_by_node_object($node_id, $device_object_id)
	{
		$this->db->where('node_id', $node_id);
        $this->db->where('device_object_id', $device_object_id);
		return $this->db->get($this->table);
	}
    
	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	// update subnet by id
	function update($id, $data)
	{
		$this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
	// delete subnet by id
	function delete($id)
	{
		$this->db->where('id', $id);
		return $this->db->delete($this->table);
	}
	
	function getRows()
	{
		$this->db->order_by('id','asc');
		return $this->db->get($this->table);
	}
	
	function clear()
	{
		return $this->db->truncate($this->table);
	}  
}
?>