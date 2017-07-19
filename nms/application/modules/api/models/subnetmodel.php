<?php
class SubnetModel extends CI_Model 
{
	
	public $table	= 'pms.subnet';

	function __construct()
	{
		parent::__construct();
	}
	
    function get_sites()
	{
		return $this->db->get('pms.site_map_view');
	}
    
    function get_site_by_region($regions_id=array())
	{
	    $this->db->select('id,name');
        if(count($regions_id)>0) $this->db->where_in('region_id', $regions_id);
		return $this->db->get('pms.site_view');
	}
    
    function get_node_by_site($subnet_id=array())
	{
	    $this->db->select('id,name');
        if(count($subnet_id)>0) $this->db->where_in('subnet_id', $subnet_id);
        $this->db->where('device_id < 11');
		return $this->db->get('pms.node');
	}
    
    function get_node_by_region($region_id=array())
	{
	    $this->db->select('id,name');
        if(count($region_id)>0) $this->db->where_in('region_id', $region_id);
        $this->db->where('device_id < 11');
		return $this->db->get('pms.node_view');
	}
    
    function get_site_alarms($subnet_id)
    {
        $sql    = "select alt.dtime, al.alarm_name, al.alarm_severity_id ";
        $sql    .= "from pms.alarm_temp alt ";
        $sql    .= "left join pms.alarm_list al on alt.alarm_list_id = al.id ";
        $sql    .= "where alt.node_id in (select id from pms.node where subnet_id = '$subnet_id') ";
        $sql    .= "order by al.alarm_severity_id asc ";
        return $this->db->query($sql);
    }
    
	function count_all()
	{
		return $this->db->count_all($this->table);
	}
	
	function get_paged_list($limit = 10, $offset = 0)
	{
		$this->db->order_by('name','asc');
		return $this->db->get($this->table, $limit, $offset);
	}
	
	function get_by_id($id)
	{
		$this->db->where('id', $id);
		return $this->db->get($this->table);
	}
	
    function get_info($subnet_id)
    {
        $this->db->select('ni.*');
        $this->db->where('n.subnet_id', $subnet_id);
        $this->db->where('n.device_id', '1');
        $this->db->join('pms.node n', 'n.id = ni.node_id');
        return $this->db->get('pms.node_info ni');
    }
    
    function getRow($id)
	{        
		return $this->db->query("select id,name,site_type_id,region_id from pms.site_view left join pms.site_config on site_view.id = site_config.subnet_id where site_view.id='$id'");
	}
    	
	function save($data)
	{
		return $this->db->insert($this->table, $data);
		#return $this->db->insert_id();
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
    
    function get_by_subnetid($id)
	{
		return $this->db->query("select * from pms.subnet where id='$id' order by name asc");
	}
        
    function get_by_parentid($id)
	{
	    $sql   = "select * from pms.subnet ";
        if(empty($id)) $sql .= "where parent_id is null ";
        else $sql   .= "where parent_id='$id' ";
        $sql    .= "order by name asc ";
		return $this->db->query($sql);
	}
    
    function has_child($subnet_id)
    {
        $this->db->select('count(id) as total');
        $this->db->where('parent_id', $subnet_id);
        $rs = $this->db->get($this->table);        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
    }
    
    function get_site_count($region_id, $name)
    {
        $this->db->select('count(id) as total');
        if($region_id != '') $this->db->where('region_id', $region_id);
        if($name != '') $this->db->like('lower(name)', strtolower($name));
        $rs = $this->db->get('pms.site_view');        		
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return $row->total;
        } else return 0;
    }
    
    function getName($subnet_id) 
    {
        $this->db->select('name');
        $this->db->where('id', $subnet_id);
        $rs = $this->db->get($this->table);
        $row = $rs->row();
        if(is_object($row)) return $row->name;
        else return "";
    }
    
    function getSiteByRegionId($subnet_id)
    {
        $sql    = "select id, name from pms.subnet where parent_id in (select id from pms.subnet where parent_id = '$subnet_id') order by name";
        return $this->db->query($sql);
    }           
    
    function getRoot()
    {
        return $this->db->query("select * from pms.subnet where parent_id is null limit 1");
    }
    
    function getRegion()
    {
        return $this->db->query("select * from pms.subnet where parent_id is null");
    }
    
    function getFirstRegion()
    {
        return $this->db->query("select * from pms.subnet where parent_id in (select id from pms.subnet where parent_id is null) limit 1");
    }
    
    function getArea($region_id)
    {
        return $this->get_by_parentid($region_id);
    }
    
    function getSite($area_id)
    {
        return $this->get_by_parentid($area_id);
    }
    
    function getDevice($parent_id, $group)
    {
        return $this->db->query("select * from pms.node where subnet_id = '$parent_id' and device_id = '$group' limit 1");
    }    
        
    function getStatusSiteBySubnet($subnet_id)
    {
        $status = "";
        $sql = "select status from pms.site_status where subnet_id = '$subnet_id' ";
        //echo $sql;
        $query = $this->db->query($sql);
        
        if ($query->num_rows() > 0)
        {
            $row = $query->row();
            $status = $row->status;
        }
        
        $query->free_result();


        return $status;  
    }    
    
    
    function getStatusSite($subnet_id, $type)
    {
        if ($type == '1')
            $sql = "select site.id,site.name from 
                    (select id, name from pms.subnet where parent_id in (select id from pms.subnet where parent_id in (select id from pms.subnet 
                    where parent_id = (select id from pms.subnet where parent_id is null)))) as site, pms.site_status where site.id = pms.site_status.subnet_id
                     AND pms.site_status.subnet_id in ($subnet_id) order by name asc";
        else if ($type == '2')
            $sql = "select sub.id, sub.name as sitename, node.name as device 
                    from pms.node_status ns 
                    left join pms.node node on node.id = ns.node_id 
                    left join pms.subnet sub on sub.id = ns.subnet_id 
                    where ns.subnet_id in ($subnet_id) order by sub.name asc";        
        else if ($type == '3')
            $sql = "select sub.id, sub.name as sitename, node.name as device, ns.status, ns.dtime 
                    from pms.node_status ns 
                    left join pms.node node ON node.id = ns.node_id 
                    left join pms.subnet sub ON sub.id = ns.subnet_id 
                    where ns.subnet_id in ($subnet_id) 
                    AND ns.status = '1' order by sub.name asc";        
        else if ($type == '4')
            $sql = "select sub.id, sub.name as sitename, node.name as device, ns.status, ns.dtime  
                    from pms.node_status ns  
                    left join pms.node node ON node.id = ns.node_id 
                    left join pms.subnet sub ON sub.id = ns.subnet_id 
                    WHERE ns.subnet_id in ($subnet_id) 
                    AND ns.status = '0' order by sub.name asc";        
        else if ($type == '5')
            $sql = "select sub.id, sub.name as sitename, node.name as device, ns.status, ns.dtime 
                    from pms.node_status ns  
                    left join pms.node node ON node.id = ns.node_id  
                    left join pms.subnet sub ON sub.id = ns.subnet_id  
                    where ns.subnet_id in ($subnet_id)  
                    AND ns.status = '0' AND node.device_id = 1 order by sub.name asc";        
        
        //echo $sql;

        return $this->db->query($sql);
    }    

    //status node
    function getStatusNode($subnet_id)
    {
        $sql = "select ns.node_id, node.name, ns.dtime, ns.status 
                from pms.node_status ns 
                left join pms.node on node.id = ns.node_id 
                where ns.subnet_id = '$subnet_id' order by node.name asc";
        
        //echo $sql;
        return $this->db->query($sql);
    }
    
    
    function getStatusNodeHistory($node_id)
    {
        $sql = "select node.name, nsh.dtime, nsh.dtime_end, nsh.status 
                from pms.node_status_history nsh  
                left join pms.node on node.id = nsh.node_id 
                where nsh.node_id = '$node_id' order by nsh.dtime DESC LIMIT 100";
        
        //echo $sql;
        return $this->db->query($sql);
    }    
        
    function getSearchSite()
    {
         $sql =  "select id, name, parent_id from pms.site_view ";       
         //echo $sql;
         return $this->db->query($sql);           
    }
        
    function getSiteByAreaId($subnet_id)
    {
        $sql    = "select id, name from pms.subnet where parent_id = '$subnet_id' order by name";
        return $this->db->query($sql);
    }            
}
?>