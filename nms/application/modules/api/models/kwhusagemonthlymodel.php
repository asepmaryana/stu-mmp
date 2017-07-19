<?php
class KwhUsageMonthlyModel extends CI_Model 
{
	// table name
	public $table	= 'pms.kwh_usage_monthly';

	function __construct()
	{
		parent::__construct();
	}
	
	// get number of genset_brand in database
	function getCount($m, $y, $region)
	{
	    $sql   = "select count(id) as total from ".$this->table." ";
        $sql   .= "where month = '$m' and year = '$y' ";
        $sql   .= "and node_id in (select id from pms.node_view where region_id = '$region' and dtype_id = 1)";
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	// get availability_monthly with paging
	function get_paged_list($m, $y, $region, $sort, $order, $limit = 10, $offset = 0)
	{
	    $sql   = "select * from ".$this->table."_view ";        
        $sql   .= "where month = '$m' ";
        $sql   .= "and year = '$y' ";
        $sql   .= "and node_id in (select id from pms.node_view where region_id='$region' and dtype_id = 1) ";
        $sql   .= "order by ".$sort." ".$order." ";
        $sql   .= "limit ".$limit." offset ".$offset;        
        #print $sql.'<br/>';
        return $this->db->query($sql);
	}
	
    function get_list($m, $y, $region, $sort, $order)
	{
	    $sql   = "select * from ".$this->table."_view ";        
        $sql   .= "where month = '$m' ";
        $sql   .= "and year = '$y' ";
        $sql   .= "and node_id in (select id from pms.node_view where region_id='$region' and dtype_id = 1) ";
        $sql   .= "order by ".$sort." ".$order." ";                
        #print $sql.'<br/>';
        return $this->db->query($sql);
	}
	
	// get kwh_usage_monthly by id
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
	// add new kwh_usage_monthly
	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	// update kwh_usage_monthly by id
	function update($id, $data)
	{
		$this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
	// delete kwh_usage_monthly by id
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
    
    function get_usage_mon_region($hosts, $month, $year)
    {
        if(empty($hosts)) return 0;
        $sql    = "SELECT AVG(value) AS val FROM ".$this->table." WHERE node_id IN($hosts) AND month='$month' AND year='$year' ";
        #print $sql.'<br/>';
        $rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            $val = (float)$row->val;
            if($val > 0) return round($val, 2);
            else return 0;
        } else return 0;
    }
}
?>