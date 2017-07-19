<?php
class AlarmLogModel extends CI_Model 
{
	public $table	= 'pms.alarm_log';

	function __construct()
	{
		parent::__construct();
	}
	
    function count_all()
	{
		return $this->db->count_all($this->table);
	}
    
	function get_list_count($hosts, $devicesType, $severity, $alarm, $from, $to)
	{
	    $sql    = "select count(id) as total ";
        $sql    .= "from pms.alarm_log_view ";
        $sql    .= "where dtime_end is not null ";
        if(!empty($hosts)) $sql .= "and node_id in ($hosts) ";
        if(!empty($devicesTypes)) $sql    .= "and device_id IN ($devicesTypes) ";
        if(!empty($severity)) $sql .= "and alarm_severity_id IN ($severity) ";
        if(!empty($alarm)) $sql  .= "and alarm_list_id IN ($alarm) ";
        if(!empty($from) && !empty($to)) $sql  .= "and dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
        	    
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	function get_paged_list($hosts, $devicesType, $severity, $alarm, $from, $to, $sort, $order, $limit = 10, $offset = 0)
	{
	    $sql    = "select id, regional, site, label, address, ddtime, ddtime_end, severity, alarm_name ";
        $sql    .= "from pms.alarm_log_view ";
        $sql    .= "where dtime_end is not null ";
        if(!empty($hosts)) $sql .= "and node_id in ($hosts) ";
        if(!empty($devicesTypes)) $sql    .= "and device_id IN ($devicesTypes) ";
        if(!empty($severity)) $sql .= "and alarm_severity_id IN ($severity) ";
        if(!empty($alarm)) $sql  .= "and alarm_list_id IN ($alarm) ";
        if(!empty($from) && !empty($to)) $sql  .= "and dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
        $sql .= "order by $sort $order ";
        $sql .= "limit $limit offset $offset ";
        #print $sql;
        return $this->db->query($sql);        	    
	}
	
    function get_list($hosts, $devicesType, $severity, $alarm, $from, $to, $sort, $order)
	{
	    $sql    = "select id, regional, site, label, address, ddtime, ddtime_end, severity, alarm_name ";
        $sql    .= "from pms.alarm_log_view ";
        $sql    .= "where dtime_end is not null ";
        if(!empty($hosts)) $sql .= "and node_id in ($hosts) ";
        if(!empty($devicesTypes)) $sql    .= "and device_id IN ($devicesTypes) ";
        if(!empty($severity)) $sql .= "and alarm_severity_id IN ($severity) ";
        if(!empty($alarm)) $sql  .= "and alarm_list_id IN ($alarm) ";
        if(!empty($from) && !empty($to)) $sql  .= "and dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
        $sql .= "order by $sort $order ";        
        #print $sql;
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