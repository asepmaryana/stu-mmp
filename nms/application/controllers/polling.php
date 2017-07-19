<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * Created 8:55 AM 8/5/2016, Author Haris Hardianto
 */


/**
 * Class Pool
 * @property Polling_Model $polling_model
 * @property Debug_Model $debug_model
 * @property DataLog_Model $datalog_model
 */
class Polling extends CI_Controller {

    function __construct()
    {
        parent::__construct();
        $this->load->model('polling_model');
        $this->load->model('debug_model');
        $this->load->model('datalog_model');

    }


    public function index()
    {
        $data = $this->input->get('message');

        $updated_at = substr($data, 214, 4) . '-' . substr($data, 218, 2) . '-' . substr($data, 220, 2) . ' ' . substr($data, 222, 2) . ':' . substr($data, 224, 2). ':' . substr($data, 226, 2);
        $imei = substr($data, 0, 15);
        $chanel = substr($data, 16, 2);
        $group = substr($data, 19, 2);
        $pole = $site_id = ($group * 8 - 7);

        $row['dtime'] = date('Y-m-d h:i:s');
        $row['msg'] = $data;

        //insert data to  debug table
        $this->debug_model->saveRawData($row);

        $dt= $lg = substr($data, 22, strlen($data) - 34);

        //update data on  site table
        for ($x = 0; $x <= 7; $x++) {
            $rs = substr($dt, ($x * 24), 24);

            $col['updated_at'] = $updated_at;
            $col['chanel'] = $chanel;
            $col['vbatt'] = substr($rs, 0, 2) . '.' . substr($rs, 2, 2);
            $col['pvoltage'] = substr($rs, 4, 2) . '.' . substr($rs, 6, 2);
            $col['ibatt'] = ((substr($rs, 8, 1) == 'N' | substr($rs, 8, 1) == 'n') ? '-' : '') . substr($rs, 9, 2) . '.' . substr($rs, 11, 2);
            $col['iload'] = substr($rs, 13, 2) . '.' . substr($rs, 15, 2);
            $col['temperature_ctrl'] = substr($rs, 17, 2) . '.' . substr($rs, 19, 1);
            $col['temperature_batt'] = substr($rs, 20, 2) . '.' . substr($rs, 22, 1);
            $col['status'] = substr($rs, 23, 1);

            $this->polling_model->updatedataPoll($imei, $pole++, $col);

        }

        //insert data from message to  datalog table
        for ($y = 0; $y <= 7; $y++) {
            $ls = substr($lg, ($y * 24), 24);
            $log['site_id'] = $site_id++;
            $log['dtime'] = $updated_at;
            $log['vbatt'] = substr($ls, 0, 2) . '.' . substr($ls, 2, 2);
            $log['pvoltage'] = substr($ls, 4, 2) . '.' . substr($ls, 6, 2);
            $log['ibatt'] = ((substr($rs, 8, 1) == 'N' | substr($rs, 8, 1) == 'n') ? '-' : '') . substr($ls, 9, 2) . '.' . substr($ls, 11, 2);
            $log['iload'] = substr($ls, 13, 2) . '.' . substr($ls, 15, 2);
            $log['temperature_ctrl'] = substr($ls, 17, 2) . '.' . substr($ls, 19, 1);
            $log['temperature_batt'] = substr($ls, 20, 2) . '.' . substr($ls, 22, 1);
            $log['status'] = substr($ls, 23, 1);

            $this->datalog_model->saveDataLog($log);
        }

    }

}
/* End of file Polling.php */
/* Location: ./application/controllers/Polling.php */
?>