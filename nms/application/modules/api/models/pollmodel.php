<?php
class PollModel extends CI_Model 
{
	public $table	= 'pms.poll';

	function __construct()
	{
		parent::__construct();
	}
	
	function getCount($hosts, $param, $from, $to)
	{	    
	    $sql   = "select count(id) as total from ".$this->table." ";
        if($hosts != '_') $sql .= "where node_id in (".str_replace('_',',', $hosts).") ";
        if($param != '_') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_object_id in (".str_replace('_', ',', $param).") ";
            else $sql    .= "where device_object_id in (".str_replace('_', ',', $param).") ";
        }
        if($from != '' && $to != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and dtime between '$from 00:00:00' and '$to 23:59:59' ";
            else if(preg_match('/where/', $sql)) $sql    .= "where dtime between '$from 00:00:00' and '$to 23:59:59' ";
        }
        #print $sql.'<br/>';
        
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	function get_paged_list($hosts, $param, $from, $to, $sort, $order, $limit = 10, $offset = 0)
	{	    
	    $sql   = "select id,value,name,site,var_name,ddtime,jsdate from ".$this->table."_view ";
        if($hosts != '' && $hosts != '_') $sql .= "where node_id in (".str_replace('_',',', $hosts).") ";
        if($param != '' && $param != '_') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_object_id in (".str_replace('_', ',', $param).") ";
            else $sql    .= "where device_object_id in (".str_replace('_', ',', $param).") ";
        }
        if($from != '' && $to != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and dtime between '$from 00:00:00' and '$to 23:59:59' ";
            else if(preg_match('/where/', $sql)) $sql    .= "where dtime between '$from 00:00:00' and '$to 23:59:59' ";
        }
        $sql    .= "order by $sort $order ";
        if($limit > 0) $sql  .= "limit $limit offset $offset ";
        #print $sql.'<br/>';
        
        return $this->db->query($sql);
	}
	
    function get_list($hosts, $param, $from, $to, $sort, $order)
	{	    
	    $sql   = "select id,value,name,site,var_name,ddtime,jsdate from ".$this->table."_view ";
        if($hosts != '' && $hosts != '_') $sql .= "where node_id in (".str_replace('_',',', $hosts).") ";
        if($param != '' && $param != '_') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_object_id in (".str_replace('_', ',', $param).") ";
            else $sql    .= "where device_object_id in (".str_replace('_', ',', $param).") ";
        }
        if($from != '' && $to != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and dtime between '$from 00:00:00' and '$to 23:59:59' ";
            else if(preg_match('/where/', $sql)) $sql    .= "where dtime between '$from 00:00:00' and '$to 23:59:59' ";
        }
        $sql    .= "order by $sort $order ";        
        #print $sql.'<br/>';
        
        return $this->db->query($sql);
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
}
?>