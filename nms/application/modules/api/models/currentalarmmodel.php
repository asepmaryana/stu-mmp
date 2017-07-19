<?php
class CurrentAlarmModel extends CI_Model 
{
    // severity constant
    public $CRITICAL        = 1;
    public $MAJOR           = 2;
    public $MINOR           = 3;
    public $WARNING         = 4;
    public $COMMUNICATION   = 5;
    
	// table name
	public $table	= 'pms.alarm_temp';

	function __construct()
	{
		parent::__construct();
	}
	
	function count_all()
	{
		return $this->db->count_all($this->table);
	}
	
	function get_paged_list($limit = 10, $offset = 0, $filter="")
	{
	    //$sql   = "select top $limit date_time,event_id,priority,message,agent_addr from eventlog where event_id not in (select top ".($limit * $offset)." event_id from eventlog)";
		$sql   = "select top $limit * from $table where event_id not in (select top ".$offset." event_id from $table) and $filter";
        //echo $sql."<br>";
        return $this->db->query($sql);
	}
	
    function getRows($filter="")
	{
	    //$sql   = "select top $limit date_time,event_id,priority,message,agent_addr from eventlog where event_id not in (select top ".($limit * $offset)." event_id from eventlog)";
		$sql   = "select * from $table $filter";
        return $this->db->query($sql);
	}
    
    function getTotalRows($filter="")
	{
		$sql   = "select count(event_id) as total from $table where $filter";
        //echo $sql."<br>";
        $query = $this->db->query($sql);
        if ($query->num_rows() > 0)
        {
            foreach ($query->result() as $row)
            {
                return $row->total;
            }
        } 
	}
    
	function get_by_id($id)
	{
		$this->db->where('event_id', $id);
		return $this->db->get($this->table);
	}
	
	function save($data)
	{
		$this->db->insert($this->table, $data);
		return $this->db->insert_id();
	}
	
	function update($id, $data)
	{
		$this->db->where('id', $id);
		$this->db->update($this->table, $data);
	}
    
    function countAlarm($hosts, $severity)
    {
        $sql    = "select count(id) as jumlah from pms.alarm_temp_view where node_id in($hosts) and alarm_severity_id = $severity";
        $rs     = $this->db->query($sql)->row();
        return $rs->jumlah;
    }        
    
    function getAlarms($hosts, $devicesTypes, $severity, $limit, $offset)
    {
        $sql    = "select id, regional, site, label, address, ddtime, severity, alarm_name, alarm_counter, notes, acknowledge ";
        $sql    .= "from pms.alarm_temp_view alt ";
        
        if(!empty($hosts)) $sql .= "where alt.node_id in ($hosts) ";
        if(!empty($devicesTypes)) {
            if(preg_match("/where/", $sql)) $sql    .= "and alt.device_type_id IN ($devicesTypes) ";
            else $sql    .= "where alt.device_type_id IN ($devicesTypes) ";
        }
        if(!empty($severity)) {
            if(preg_match("/where/", $sql)) $sql .= "and alt.alarm_severity_id IN ($severity) ";
            else $sql .= "where alt.alarm_severity_id IN ($severity) ";
        }
        
        $sql .= "order by alt.dtime desc ";
        $sql .= "limit $limit offset $offset ";
        #print $sql;
        return $this->db->query($sql);                
    }
    
    function getCurrentAlarms($hosts, $devicesTypes, $severity, $alarm, $from, $to, $limit, $offset)
    {
        $sql    = "select id, regional, site, label, address, ddtime, severity, alarm_name, alarm_counter, notes, acknowledge ";
        $sql    .= "from pms.alarm_temp_view ";
        
        if(!empty($hosts)) $sql .= "where node_id in ($hosts) ";
        if(!empty($devicesTypes)) {
            if(preg_match("/where/", $sql)) $sql    .= "and device_id IN ($devicesTypes) ";
            else $sql    .= "where device_id IN ($devicesTypes) ";
        }
        if(!empty($severity)) {
            if(preg_match("/where/", $sql)) $sql .= "and alarm_severity_id IN ($severity) ";
            else $sql .= "where alarm_severity_id IN ($severity) ";
        }
        if(!empty($alarm)) {
            if(preg_match("/where/", $sql)) $sql  .= "and alarm_list_id IN ($alarm) ";
            else $sql  .= "where alarm_list_id IN ($alarm) ";
        }
        if(!empty($from) && !empty($to)) {
            if(preg_match("/where/", $sql)) $sql  .= "and dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
            else $sql  .= "where dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
        }
        $sql .= "order by id desc ";
        if($limit != '' && $offset != '' && $limit != '_' && $offset != '_') $sql .= "limit $limit offset $offset ";
        #print $sql;
        return $this->db->query($sql);
    }
    
    function getCurrentAlarmsCount($hosts, $devicesTypes, $severity, $alarm, $from, $to)
    {
        $sql    = "select count(id) as total ";
        $sql    .= "from pms.alarm_temp_view ";
        
        if(!empty($hosts)) $sql .= "where node_id in ($hosts) ";
        if(!empty($devicesTypes)) {
            if(preg_match("/where/", $sql)) $sql    .= "and device_id IN ($devicesTypes) ";
            else $sql    .= "where device_id IN ($devicesTypes) ";
        }
        if(!empty($severity)) {
            if(preg_match("/where/", $sql)) $sql .= "and alarm_severity_id IN ($severity) ";
            else $sql .= "where alarm_severity_id IN ($severity) ";
        }
        if(!empty($alarm)) {
            if(preg_match("/where/", $sql)) $sql  .= "and alarm_list_id IN ($alarm) ";
            else $sql  .= "where alarm_list_id IN ($alarm) ";
        }
        if(!empty($from) && !empty($to)) {
            if(preg_match("/where/", $sql)) $sql  .= "and dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
            else $sql  .= "where dtime between '".$from." 00:00:00' and '".$to." 23:59:59' ";
        }
        #print $sql;
        $query = $this->db->query($sql);
        if($query->num_rows() > 0) {
             $row = $query->row();
             return $row->total;
        } else return 0;
    }            
    
    function ackAlarm($alarm_id)
    {
        $alarm_id = str_replace('_', ',', $alarm_id);
        $sql    = "update pms.alarm_temp set acknowledge='1' where id IN(".$alarm_id.")";
        #echo $sql."<br>";
        $this->db->query($sql);
    }
    
    function update_ackAlarm($event_id)
    {
        $event_id = str_replace(':', ',', $event_id);
        $sql    = "update current_alarm set acknowledge=1 where event_id IN(".$event_id.")";
        #echo $sql."<br>";
        return $this->db->query($sql);
    }
    
    function remark($event_id, $remark)
    {
        $sql    = "update current_alarm set remark='$remark' where event_id=" . $event_id;
        //echo $sql."<br>";
        $this->db->query($sql);
    }

    function update_remark($event_id, $remark)
    {
        $sql    = "update current_alarm set remark='$remark' where event_id=" . $event_id;
        //echo $sql."<br>";
        return $this->db->query($sql);
    }
    
    function update_label($label, $node_id, $alarm_list_id, $alarm_index)
	{
	    $data = array('alarm_name'=>$label);
		$this->db->where('node_id', $node_id);
        $this->db->where('alarm_list_id', $alarm_list_id);
        $this->db->where('alarm_index', $alarm_index);
		$this->db->update($this->table, $data);
	}
    
    
    
    
    
    
    
    
    //Baeny
    function NationalSeverityAlarmSummaries()
    {
        $sql = " select alarm_severity.id, severity, b.count_alarm,b.alarm_severity_id from alarm_severity left join (select count(event_id) as count_alarm, alarm_severity_id from current_alarm  group by alarm_severity_id) as b on alarm_severity.id = b.alarm_severity_id";
    
        //echo $sql."<br>";
        return $this->db->query($sql);
    }
    
    function RegionSeverityAlarmSummaries($node_id)
    {
        $sql = " select alarm_severity.id, severity, b.count_alarm,b.alarm_severity_id from alarm_severity left join (select count(event_id) as count_alarm, alarm_severity_id from current_alarm  group by alarm_severity_id) as b on alarm_severity.id = b.alarm_severity_id";
    
        //echo $sql."<br>";
        return $this->db->query($sql);
    }
    
    function getRegion()
    {
        $sql = "select subnet_id,label from Subnets  where parent_id = (select subnet_id from subnets where parent_id = '')";
        
        //echo $sql."<br>";
        return $this->db->query($sql);
    }

    function getRegionByNode($subnet_id)
    {
        $sql = "select subnet_id,label from Subnets  where parent_id = (select subnet_id from subnets where parent_id = '') and subnet_id = '".$subnet_id."'";
        
        //echo $sql."<br>";
        return $this->db->query($sql);
    }    
    
    function getArea($subnet_id)
    {
        $sql = "select * from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = '')) and parent_id = '".$subnet_id."'";
        
        return $this->db->query($sql);
    }
    
    
    function getSite($subnet_id)
    {
        $sql = "select * from Subnets where parent_id in (select subnet_id from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = ''))) and parent_id = '".$subnet_id."'";
        
        return $this->db->query($sql);
    }
    
    
    function getNodeAlarm($subnet_id)
    {
        $sql = "select node_id,label, noa from NodeTable left join (select COUNT(event_id) as noa, map_id from current_alarm group by map_id) as cur_alarm on map_id = node_id where parent_id = '".$subnet_id."'";
        return $this->db->query($sql);
    }
    
    function checkRegNat($subnet_id)
    {
        $sql = "select id, parent_id from pms.subnet ";
        if($subnet_id != '') $sql   .= "where id = '".$subnet_id."' ";        
        return $this->db->query($sql);
    }
    
    
    function getSeverityAlarmRegional($subnet_id)
    {
        $sql = "select alarm_severity.id, severity, b.count_alarm,b.alarm_severity_id from alarm_severity left join (select count(event_id) as count_alarm, alarm_severity_id from current_alarm, NodeTable,Subnets where map_id = node_id and NodeTable.parent_id = subnet_id and subnet_id in (".$subnet_id.")  group by alarm_severity_id) as b on alarm_severity.id = b.alarm_severity_id";
        
        //echo $sql;
        return $this->db->query($sql);
    
    }
    

    
    
    function NationalEquipmentAlarmSummaries()
    {
        $sql = " select DeviceType.id as type,name, b.count_alarm, b.device_type_id from DeviceType 
                 left join (select count(event_id) as count_alarm,device_type_id from current_alarm group by device_type_id) as b on DeviceType.id = b.device_type_id
               ";
    
        //echo $sql."<br>";
        return $this->db->query($sql);
    }        
    
    function RegionEquipmentAlarmSummaries($hosts)
    {
        $sql    = "select dt.id as type, dt.name, b.count_alarm 
                 from pms.device dt  
                 left join
                 (
                    select count(id) as count_alarm, device_id 
                    from pms.alarm_temp_view ";
                    
        if(!empty($hosts)) $sql .= "where node_id in ($hosts) ";
        
        $sql    .= "group by device_id
                 ) as b 
                 on dt.id = b.device_id
                 order by dt.id asc";                
        //echo $sql."<br>";
        return $this->db->query($sql);
    }      
    
    function getAssetNational()
    {
        $sql = " select (select COUNT(id) as rectifier from rectifier_battery_asset) 
                 as rectifier, (select sum(qty_genset) as genset from genset_asset) as 
                 genset ";
                 
        return $this->db->query($sql);
    }


    function getAssetRegional($subnet_id)
    {
        $sql = " select (select COUNT(id) as rectifier from rectifier_battery_asset,Subnets where Subnets.subnet_id= rectifier_battery_asset.subnet_id 
                 and rectifier_battery_asset.subnet_id in (".$subnet_id.")) as rectifier, (select sum(qty_genset) as genset from genset_asset,Subnets where Subnets.subnet_id= genset_asset.subnet_id 
                 and genset_asset.subnet_id in (".$subnet_id.")) as genset";
        //echo $sql."<br>";
        return $this->db->query($sql);        
    }    
    
    
    function getAlarmsBySeverity($hosts, $severity)
    {
        $sql    = "SELECT (SELECT subnets.label FROM subnets WHERE subnets.subnet_id=nodetable.parent_id) AS sitename,nodetable.label,nodetable.address,{$this->table}.event_id,convert(varchar,{$this->table}.dtime,120) as dtime,alarm_severity.severity,AlarmList.name,alarm_name,{$this->table}.acknowledge,{$this->table}.remark, alarm_counter, alarm_code,subnet_id FROM {$this->table} LEFT JOIN nodetable ON nodetable.node_id={$this->table}.map_id LEFT JOIN subnets ON nodetable.parent_id=subnets.subnet_id LEFT JOIN alarm_severity ON {$this->table}.alarm_severity_id=alarm_severity.id LEFT JOIN AlarmList ON {$this->table}.alarm_list_id = AlarmList.id ";
        //$sql    .= "WHERE event_id NOT IN (SELECT TOP ".$offset." event_id FROM {$this->table} ORDER BY dtime DESC) ";
        //if(!empty($hosts)) $sql .= "AND {$this->table}.map_id IN($hosts) ";
        $sql  .= "WHERE {$this->table}.alarm_severity_id = $severity ";
        if(!empty($hosts)) $sql .= "AND {$this->table}.map_id IN($hosts) ";
        //$sql  .= "AND {$this->table}.dtime BETWEEN '".date("Y-m")."-01 00:00:00' AND '".date("Y-m-d H:i:s")."' ";
        $sql  .= " ORDER BY {$this->table}.dtime DESC ";
        //echo $sql."<br>";
        return $this->db->query($sql);        
    }
    
    
    function getAlarmsByNode($hosts)
    {
        $sql    = "SELECT (SELECT subnets.label FROM subnets WHERE subnets.subnet_id=nodetable.parent_id) AS sitename,nodetable.label,nodetable.address,{$this->table}.event_id,{$this->table}.dtime,alarm_severity.severity,AlarmList.name,alarm_name,{$this->table}.acknowledge,{$this->table}.remark,alarm_counter, alarm_code FROM {$this->table} LEFT JOIN nodetable ON nodetable.address={$this->table}.agent_address LEFT JOIN subnets ON nodetable.parent_id=subnets.subnet_id LEFT JOIN alarm_severity ON {$this->table}.alarm_severity_id=alarm_severity.id LEFT JOIN AlarmList ON {$this->table}.alarm_list_id = AlarmList.id ";
        //$sql    .= "WHERE event_id NOT IN (SELECT TOP ".$offset." event_id FROM {$this->table} ORDER BY dtime DESC) ";
        if(!empty($hosts)) $sql .= "WHERE {$this->table}.map_id IN($hosts) ";
        //$sql  .= "AND {$this->table}.dtime BETWEEN '".date("Y-m")."-01 00:00:00' AND '".date("Y-m-d H:i:s")."' ";
        $sql  .= " ORDER BY {$this->table}.dtime DESC ";
        #echo $sql."<br>";
        return $this->db->query($sql);          
    }
    
    
    function getAlarmsByEquipment($hosts, $type)
    {
        $sql    = "SELECT (SELECT subnets.label FROM subnets WHERE subnets.subnet_id=nodetable.parent_id) AS sitename,nodetable.label,nodetable.address,{$this->table}.event_id,{$this->table}.dtime,alarm_severity.severity,AlarmList.name,alarm_name,{$this->table}.acknowledge,{$this->table}.remark,alarm_counter, alarm_code,subnet_id FROM {$this->table} LEFT JOIN nodetable ON nodetable.node_id={$this->table}.map_id LEFT JOIN subnets ON nodetable.parent_id=subnets.subnet_id LEFT JOIN alarm_severity ON {$this->table}.alarm_severity_id=alarm_severity.id LEFT JOIN AlarmList ON {$this->table}.alarm_list_id = AlarmList.id ";
        //$sql    .= "WHERE event_id NOT IN (SELECT TOP ".$offset." event_id FROM {$this->table} ORDER BY dtime DESC) ";
        //if(!empty($hosts)) $sql .= "AND {$this->table}.map_id IN($hosts) ";
        $sql  .= "WHERE {$this->table}.device_type_id = $type ";
        if(!empty($hosts)) $sql .= "AND {$this->table}.map_id IN($hosts) ";
        //$sql  .= "AND {$this->table}.dtime BETWEEN '".date("Y-m")."-01 00:00:00' AND '".date("Y-m-d H:i:s")."' ";
        $sql  .= " ORDER BY {$this->table}.dtime DESC ";
        //echo $sql."<br>";
        return $this->db->query($sql);        
    }      
    
    
    function getCurrentAlarmsCountTactical($hosts, $severity, $from, $to)
    {
        $to = date('Y-m-d', (strtotime($to) + 86400));
        $sql    = "SELECT COUNT(event_id) AS total FROM {$this->table} ";
        if(!empty($hosts)) $sql .= "WHERE {$this->table}.map_id IN($hosts) ";
        if(!empty($severity)) $sql  .= "AND {$this->table}.alarm_severity_id IN ($severity) ";
        if(!empty($from) && !empty($to)) $sql  .= "AND {$this->table}.dtime BETWEEN '".$from." 00:00:00' AND '".$to." 23:59:59' ";
        #echo $sql."<br>";
        $query = $this->db->query($sql);
        if($query->num_rows() > 0) {
             $row = $query->row();
             return $row->total;
        } else return 0;
    }    
    
    //end Baeny   
    
    
    # adding 14 Oct 2011 10:02 - Asep
    function getDetail($eventId)
    {        
        $this->db->where('id', $eventId);
        return $this->db->get('pms.alarm_log');
    }     
    
    function getNodeRegional($subnet_id)
    {
        $sql = "select Region.label as region_name from
                (select subnet_id,label from Subnets  where parent_id = (select subnet_id from subnets where parent_id = '')) as Region,
                (select * from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = ''))) as Area,
                ( select * from Subnets where parent_id in (select subnet_id from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = '')))) as Site,
                NodeTable
                where Region.subnet_id = Area.parent_id and Area.subnet_id = Site.parent_id and NodeTable.parent_id = Site.subnet_id and Site.subnet_id = '$subnet_id'";
        $query = $this->db->query($sql);
        
        $region = '';
        if ($query->num_rows() > 0)
        {
            $region = $query->row()->region_name;
        }
        $query->free_result();                
        return $region;    
    }
    
    function getNodeRegionalx($subnet_id)
    {
        $sql = "select Region.label as region_name from
                (select subnet_id,label from Subnets  where parent_id = (select subnet_id from subnets where parent_id = '')) as Region,
                (select * from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = ''))) as Area,
                ( select * from Subnets where parent_id in (select subnet_id from Subnets where parent_id in (select subnet_id from Subnets 
                where parent_id = (select subnet_id from subnets where parent_id = '')))) as Site,
                NodeTable
                where Region.subnet_id = Area.parent_id and Area.subnet_id = Site.parent_id and NodeTable.parent_id = Site.subnet_id and Site.subnet_id = '$subnet_id'";
        $query = $this->db->query($sql);
        
        $region = '';
        if ($query->num_rows() > 0)
        {
            $region = $query->row()->region_name;
        }
        $query->free_result();
        
        
        return $region;
    
    }
    
    function export($hosts, $devicesType, $alarm, $severity, $from, $to)
    {

        $to = date('Y-m-d', (strtotime($to) + 86400));
        $sql    = "SELECT (SELECT subnets.label FROM subnets WHERE subnets.subnet_id=nodetable.parent_id) AS SITENAME, nodetable.label as EQUIPMENT,nodetable.address as IP,{$this->table}.dtime as DATETIME,alarm_severity.severity as SEVERITY,alarm_name as ALARM,{$this->table}.remark,alarm_counter, alarm_code FROM {$this->table} LEFT JOIN nodetable ON nodetable.node_id={$this->table}.map_id LEFT JOIN subnets ON nodetable.parent_id=subnets.subnet_id LEFT JOIN alarm_severity ON {$this->table}.alarm_severity_id=alarm_severity.id LEFT JOIN AlarmList ON {$this->table}.alarm_list_id = AlarmList.id ";
        $sql    .= "WHERE ";
        if(!empty($hosts)) $sql .= " {$this->table}.map_id IN($hosts) ";
        if(!empty($devicesType)) $sql  .= "AND {$this->table}.device_type_id IN ($devicesType) ";
        if(!empty($severity)) $sql  .= "AND {$this->table}.alarm_severity_id IN ($severity) ";
        if(!empty($alarm)) $sql  .= "AND {$this->table}.alarm_list_id IN ($alarm) ";
        if(!empty($from) && !empty($to)) $sql  .= "AND {$this->table}.dtime BETWEEN '".$from." 00:00:00' AND '".$to." 23:59:59' ";
        $sql  .= " ORDER BY {$this->table}.dtime DESC ";  
        
        //echo "sql ".$sql;
        return $this->db->query($sql);
    }      
    
    
    function getAlarmGenset($address)
    {
        $sql = " select count(event_id) as alarm from current_alarm where agent_address = '$address' AND device_type_id = 3 AND alarm_severity_id = 1 ";
        //echo "sql ".$sql;
        return $this->db->query($sql);
        
    }  
    
    
    function getAlarmGensetData($address)
    {
        $sql = " select * from current_alarm where agent_address = '$address' AND device_type_id = 3";
        //echo "sql ".$sql;
        return $this->db->query($sql);
        
    }    
    
    function get_count_alarm($node_id, $alarm_list_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp where alarm_list_id = $alarm_list_id and node_id = $node_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return $row->total;
        } else return 0;
    }
    
    function is_main_fail_exists($subnet_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp_view where alarm_list_id in(4,5,6) and subnet_id = $subnet_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return ($row->total > 0) ? true : false;
        } else return false;
    }
    
    function is_door_open_exists($subnet_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp_view where alarm_list_id in(7) and subnet_id = $subnet_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return ($row->total > 0) ? true : false;
        } else return false;
    }
    
    function is_temp_exists($subnet_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp_view where alarm_list_id in(8) and subnet_id = $subnet_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return ($row->total > 0) ? true : false;
        } else return false;
    }
    
    function is_batt_warn_exists($subnet_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp_view where alarm_list_id in(10) and subnet_id = $subnet_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return ($row->total > 0) ? true : false;
        } else return false;
    }
    
    function delete($ids)
    {        
        return $this->db->query("delete from ".$this->table." where id in(".$ids.") ");
    }
    
    function get_count_severity($severity_id)
    {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp where alarm_severity_id = $severity_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return $row->total;
        } else return 0;
    }
    
    function get_paged_severity($severity_id, $sort, $order, $limit = 10, $offset = 0)
    {
        $this->db->where('alarm_severity_id', $severity_id);
        $this->db->order_by($sort, $order);
        return $this->db->get($this->table.'_view', $limit, $offset);
    }
    
    function get_severity($severity_id, $sort, $order)
    {
        $this->db->where('alarm_severity_id', $severity_id);
        $this->db->order_by($sort, $order);
        return $this->db->get($this->table.'_view');
    }
    
    function get_count_device($device_id)
    {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp where device_id = $device_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return $row->total;
        } else return 0;
    }
    
    function get_paged_device($device_id, $sort, $order, $limit = 10, $offset = 0)
    {
        $this->db->where('device_id', $device_id);
        $this->db->order_by($sort, $order);
        return $this->db->get($this->table.'_view', $limit, $offset);
    }
    
    function get_device($device_id, $sort, $order)
    {
        $this->db->where('device_id', $device_id);
        $this->db->order_by($sort, $order);
        return $this->db->get($this->table.'_view');
    }
    
    function count_by_nodes($node_id=array())
	{
        if(count($node_id) == 0) return 0;
        $this->db->select('count(id) as total');
        $this->db->where_in('node_id', $node_id);
        
        $rs = $this->db->get($this->table);
        if($rs->num_rows() > 0) {
            $row = $rs->row();
            return intval($row->total);
        }
        else return 0;
	}        
    
    function is_genset_run_exists($subnet_id) {
        $query = $this->db->query("select count(id) as total from pms.alarm_temp_view where alarm_list_id in(48,49) and subnet_id = $subnet_id");
        if($query->num_rows() > 0) {
             $row = $query->row();
             return ($row->total > 0) ? true : false;
        } else return false;
    }
}
?>