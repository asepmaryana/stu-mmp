<?php
class NodeModel extends CI_Model 
{
	// table name
	public $table	= 'pms.node';

	function __construct()
	{
		parent::__construct();
	}
	
	// get number of genset_brand in database
	function getCount($cari, $region, $poller, $status, $device_id)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));
        $region  = str_replace('_', ' ', $region);
        $region  = strtolower(trim($region));
        $poller  = str_replace('_', ' ', $poller);
        $poller  = strtolower(trim($poller));
        $status  = str_replace('_', ' ', $status);
        $status  = strtolower(trim($status));
        $device_id  = str_replace('_', ' ', $device_id);
        $device_id  = strtolower(trim($device_id));
        
	    $sql   = "select count(id) as total from ".$this->table."_view ";
        if($cari != '') $sql    .= "where lower(name) like '%".$cari."%' or lower(address) like '%".$cari."%' ";
        
        if($region != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and region_id = '$region' ";
            else $sql    .= "where region_id = '$region' ";
        }
        
        if($poller != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and poller_agent = '$poller' ";
            else $sql    .= "where poller_agent = '$poller' ";
        }
        
        if($status != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and opr_status_id = '$status' ";
            else $sql    .= "where opr_status_id = '$status' ";
        }
        
        if($device_id != '') {
            if(preg_match('/where/', $sql)) $sql    .= "and device_id = '$device_id' ";
            else $sql    .= "where device_id = '$device_id' ";
        }
        
		$rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
	}
	
	// get node with paging
	function get_paged_list($cari, $region, $poller, $status, $device_id, $sort, $order, $limit = 10, $offset = 0)
	{
	    $cari  = str_replace('_', ' ', $cari);
        $cari  = strtolower(trim($cari));
	    $region  = str_replace('_', ' ', $region);
        $region  = strtolower(trim($region));
        $poller  = str_replace('_', ' ', $poller);
        $poller  = strtolower(trim($poller));
        $status  = str_replace('_', ' ', $status);
        $status  = strtolower(trim($status));
        $device_id  = str_replace('_', ' ', $device_id);
        $device_id  = strtolower(trim($device_id));
        
	    if($cari != '') $this->db->like('lower(name)', $cari);
        if($region != '') $this->db->where('region_id', $region);
        if($poller != '') $this->db->where('poller_agent', $poller);
        if($status != '') $this->db->where('opr_status_id', $status);
        if($device_id != '') $this->db->where('device_id', $device_id);
        
		$this->db->order_by($sort, $order);
		return $this->db->get($this->table.'_view', $limit, $offset);
	}
	
	// get node by id
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table.'_view');
	}
	
    function get_by_subnet_id($id)
	{
	    $this->db->select('id, name, address');
		$this->db->where('subnet_id', $id);
        $this->db->where('device_id !=', 11);
        $this->db->order_by('name', 'asc');
		return $this->db->get($this->table);
	}
    
	// add new node
	function save($data)
	{
		return $this->db->insert($this->table, $data);		
	}
	
	// update node by id
	function update($id, $data)
	{
		$this->db->where('id', $id);
		return $this->db->update($this->table, $data);
	}
	
	// delete node by id
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
    
    function get_oid($device_id)
    {
        $this->db->where('device_id', $device_id);
		return $this->db->get('pms.device_object');
    }
    
    function get_count_status($opr_status_id)
    {
        $rs = $this->db->query("select count(id) as total from ".$this->table." where opr_status_id='$opr_status_id'");        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
    }
    
    function get_device_stat()
    {
        $this->db->order_by('id', 'asc');
		return $this->db->get('pms.device_stat_view');
    }
    
    function get_device_alarm_stat()
    {
        $this->db->order_by('id', 'asc');
		return $this->db->get('pms.device_alarm_view');
    }
    
    function get_count_rect_region($region_id)
    {
        $sql   = "select count(id) as total from ".$this->table."_view where dtype_id = 2 and region_id = '$region_id' ";
        $rs = $this->db->query($sql);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
    }
    
    function get_count_rect_region_list($region_id)
    {
        $this->db->select('region, site, name, address, device, status');
        $this->db->where('region_id', $region_id);
        $this->db->where('dtype_id', 2);
        $this->db->order_by('name', 'asc');
		return $this->db->get($this->table.'_view');
    }
    
    function get_info($node_id)
    {
        $this->db->where('node_id', $node_id);
        return $this->db->get('pms.node_info');
    }
    
    function get_by_ip($address)
	{
		$this->db->where('address', $address);
        $this->db->order_by('device_id', 'asc');
		return $this->db->get($this->table.'_view');
	}
    
    function get_by_region_and_type_id($region_id, $device_type_id)
	{
	    $sql   = "select id, name ";
        $sql    .= "from pms.node_view ";        
        $sql    .= "where region_id = $region_id and dtype_id = $device_type_id ";        
        return $this->db->query($sql);
	}
    
    function get_by_parent_and_type($parent_id, $device_types)
	{
	    $sql   = "select node.id, node.name, node.address, d.device_type_id ";
        $sql    .= "from pms.node node ";
        $sql    .= "left join pms.device d on node.device_id = d.id ";
        if(!empty($parent_id)) $sql    .= "where node.subnet_id='$parent_id' ";
        if(!empty($device_types)) {
            if(preg_match("/where/", $sql)) $sql    .= "and node.device_id IN ($device_types) ";
            else $sql    .= "where node.device_id IN ($device_types) ";
        }
        $sql    .= "order by node.name asc ";
        #print $sql.'<br>';
        return $this->db->query($sql);
	}
}
?>