<?php
class TrapModel extends CI_Model 
{
	// table name
	public $table	= 'pms.trap';

	function __construct()
	{
		parent::__construct();
	}
    
	function get_by_id($id)
	{
		$this->db->where('id', $id);
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