<?php
class SiteConfigModel extends CI_Model 
{
	// table name
	public $table	= 'pms.site_config';

	function __construct()
	{
		parent::__construct();
	}
	
	// get number of genset_brand in database
	function getCount($cari)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));
	    $sql   = "select count(subnet_id) as total from ".$this->table." ";
        if($cari != '') $sql    .= "where lower(nama) like '%".$cari."%' ";
        
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	// get site_config with paging
	function get_paged_list($cari, $sort, $order, $limit = 10, $offset = 0)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));
	    if($cari != '') $this->db->like('lower(nama)', $cari);
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table, $limit, $offset);
	}
	
	// get site_config by id
	function get_by_id($id)
	{
		$this->db->where('subnet_id', $id);
		return $this->db->get($this->table);
	}
	
	// add new site_config
	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	// update site_config by id
	function update($id, $data)
	{
		$this->db->where('subnet_id', $id);
		return $this->db->update($this->table, $data);
	}
	
	// delete site_config by id
	function delete($id)
	{
		$this->db->where('subnet_id', $id);
		return $this->db->delete($this->table);
	}
	
	function getRows()
	{
		$this->db->order_by('subnet_id','asc');
		return $this->db->get($this->table);
	}
	
	function clear()
	{
		return $this->db->truncate($this->table);
	}
}
?>