<?php
class DeviceObjectModel extends CI_Model 
{
	// table name
	public $table	= 'pms.device_object';

	function __construct()
	{
		parent::__construct();
	}
	
	// get number of genset_brand in database
	function getCount($cari, $device)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));                
	    $sql   = "select count(id) as total from ".$this->table." ";
        if($cari != '') $sql    .= "where lower(name) like '%".$cari."%' ";
        if($device != '-') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_id = $device ";
            else $sql    .= "where device_id = $device ";
        }
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	// get device_object with paging
	function get_paged_list($cari, $device, $sort, $order, $limit = 10, $offset = 0)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));
	    if($cari != '') $this->db->like('lower(name)', $cari);
        if($device != '-') $this->db->where('device_id', $device);
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table.'_view', $limit, $offset);
	}
	
	// get device_object by id
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
    function get_in($ids=array())
	{
	    $this->db->select('id,var_name,unit');
		if(count($ids)>0) $this->db->where_in('id', $ids);
		return $this->db->get($this->table);
	}
    
    function get_by_subnet_id($subnet_id)
	{
		$this->db->where('subnet_id', $subnet_id);
		return $this->db->get('pms.node_object_view');
	}
    
	// add new device_object
	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	// update device_object by id
	function update($id, $data)
	{
		$this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
	// delete device_object by id
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
    
    function get_do_by_node($node_id, $param)
    {
        $sql    = "select * from ".$this->table." ";
        $sql    .= "where device_id = (select device_id from pms.node where id=".$node_id.") ";
        $sql    .= "and id in(".$param.") ";
        return $this->db->query($sql);
    }
}
?>