<?php
class HttpModel extends CI_Model 
{
	public $table	= 'pms.http';

	function __construct()
	{
		parent::__construct();
	}		
	
	function get_paged_list($sort, $order, $limit = 10, $offset = 0)
	{
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table, $limit, $offset);
	}

	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	function update($id, $data)
	{
		$this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
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
    
    function clearmf($node_id)
    {
        $this->db->where('node_id', $node_id);
        $this->db->where_in('alarm_list_id', array(4,5,6));
        $this->db->delete('pms.alarm_temp');
    }
}
?>