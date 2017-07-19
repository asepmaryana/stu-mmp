<?php
class UserModel extends CI_Model 
{
	public $table	= 'pms.users';

	function __construct()
	{
		parent::__construct();
	}
	
	function count_all()
	{
		return $this->db->count_all($this->table);
	}
	
	// get user with paging
	function get_paged_list($limit = 10, $offset = 0)
	{
		$this->db->select("users.*, user_level.name as levelname");
		$this->db->join('level', 'users.level_id=level.id', 'left');
		$this->db->order_by('id','desc');
		return $this->db->get($this->table, $limit, $offset);
	}

	function get_by_id($id)
	{
		$this->db->where('id', $id);
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
	
	function delete($id)
	{
		$this->db->where('id', $id);
		$this->db->delete($this->table);
	}
	
	function authenticate($username, $password)
	{
	    $this->db->where('username', $username);
        $this->db->where('password', $password);
        $query = $this->db->get($this->table);
		if($query->num_rows() > 0) {
			$row 	= $query->row();
			$info 	= array(
                'uid'       => $row->id,
                'username'  => $row->username,
                'level'	    => $row->role_id	
            );
			$this->session->set_userdata($info);
			return true;
		}
        else return false;
	}
	
	function lists($opid=0)
	{
		if($opid != 0) $this->db->where('level_id', $opid);
		return $this->db->get($this->table);
	}
}
?>