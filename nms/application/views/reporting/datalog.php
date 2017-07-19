<?php $this->load->view('header'); ?>
<!-- END HEAD -->
<script src="<?php echo base_url();?>assets/global/plugins/amcharts/amcharts/amcharts.js" type="text/javascript"></script>
<script src="<?php echo base_url();?>assets/global/plugins/amcharts/amcharts/serial.js" type="text/javascript"></script>
<script src="<?php echo base_url();?>assets/apps/scripts/datatables-ajax.js" type="text/javascript"></script>
        
<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">

<?php $this->load->view('navbar'); ?>

<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->

<!-- BEGIN CONTAINER -->
<div class="page-container">

    <?php $this->load->view('sidebar');?>

    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
    
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
        
            <!-- BEGIN PAGE HEADER-->
            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <a href="<?php echo base_url() ?>home">Home</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>Reporting</span>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>Polling</span>
                    </li>
                </ul>
            </div>
            <!-- END PAGE BAR -->
            
            <!-- BEGIN PAGE TITLE-->
            <h1 class="page-title"> Polling Report
                <small>Data Summaries</small>
            </h1>
            
            <br/>
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            
            <div class="row">
                
                <div class="col-md-2 col-sm-2">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-globe"></i>
                                <span class="caption-subject">Region</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list">
                                        <?php foreach($region as $r): ?>
                                        <label><input type="checkbox" name="region" value="<?php echo $r->id; ?>" onclick="getRegionSelected()"/> <?php echo $r->name; ?></label>
                                        <?php endforeach; ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-2 col-sm-2">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-pointer"></i>
                                <span class="caption-subject">Site</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list" id="site_block">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-3 col-sm-3">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-settings"></i>
                                <span class="caption-subject">Device</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list" id="node_block">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-3 col-sm-3">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bell"></i>
                                <span class="caption-subject">Parameter</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list" id="param_block">
                                        <label><input type="checkbox" name="param" value="82"/> Batt Voltage </label>
                                        <label><input type="checkbox" name="param" value="112"/> Temperature </label>
                                        <label><input type="checkbox" name="param" value="113"/> Humidity </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-2 col-sm-2">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-calendar"></i>
                                <span class="caption-subject">Time Periode</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <form role="form">
                                    <div class="form-body">
                                        <div class="form-group">
                                            <input type="text" value="<?php echo date('Y-m-d');?>" id="from" class="form-control date-picker input-sm" data-date-format="yyyy-mm-dd" placeholder="From"/>
                                        </div>
                                        <div class="form-group">
                                            <input type="text" value="<?php echo date('Y-m-d');?>" id="to" class="form-control date-picker input-sm" data-date-format="yyyy-mm-dd" placeholder="To"/>
                                        </div>
                                        <div class="form-group">
                                            <div class="btn-toolbar">
                                                <div class="btn-group">
                                                    <a class="btn btn-sm green" href="javascript:;" data-toggle="dropdown">
                                                        <i class="fa fa-user"></i> View
                                                        <i class="fa fa-angle-down"></i>
                                                    </a>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <a href="javascript:;" onclick="show_data_log('tbl')"><i class="fa fa-table"></i> Table </a>
                                                        </li>
                                                        <li>
                                                            <a href="javascript:;" onclick="show_data_log('xls')"><i class="fa fa-download"></i> Excel </a>
                                                        </li>
                                                        <li>
                                                            <a href="javascript:;" onclick="show_data_log('img')"><i class="fa fa-line-chart"></i> Chart </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
            </div>
            
            <div class="row hide" id="result">
                <div class="col-md-12 col-sm-12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <div class="caption"><i class="fa fa-database"></i>Data Log </div>
                            <div class="actions">
                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="show_data_log('xls')"><i class="fa fa-download"></i> Export </a>
                            </div>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <table class="table table-striped table-bordered table-hover" id="data_log_table">
                            <thead>
                                <tr>
                                    <th> Site </th>
                                    <th> Device </th>                                    
                                    <th> Parameter </th>
                                    <th> Date Time </th>
                                    <th> Value </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="row hide" id="chart">
                <div class="col-md-12 col-sm-12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <div class="caption"><i class="fa fa-line-chart"></i>Chart </div>
                        </div>
                    </div>
                    <div class="portlet-body" id="chart_node">
                        
                    </div>
                </div>
            </div>
            
        </div>
        <!-- END CONTENT BODY -->
        
    </div>
    <!-- END CONTENT -->
    
</div>
<!-- END CONTAINER -->

<script type="text/javascript">

function getRegionSelected()
{
    jumlah = $("input[name='region']:checked").length;
    pilihan = "_";
    $("input[name='region']:checked").each(function(i){ pilihan += $(this).val() + "_";});
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    if(jumlah != 0) 
    {
        $.ajax({
            url: base_url+'reporting/get_sites/'+pilihan,
            dataType: 'json',
            cache: false,
            success: function(msg){ 
                $('#site_block').empty();
                for(i=0;i<msg.rows.length;i++) $('#site_block').append('<label><input type="checkbox" name="site" value="'+msg.rows[i].id+'" onclick="getSiteSelected()"/> '+msg.rows[i].name+'</label>'); 
            }
        });
    }
    else $("#site_block").html('');
    $("#node_block").html('');
    $("#alarm_block").html('');
}

function getSiteSelected()
{
    jumlah = $("input[name='site']:checked").length;
    pilihan = "_";
    $("input[name='site']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    if(jumlah != 0) 
    {
        $.ajax({
            url: base_url+'reporting/get_nodes/'+pilihan,
            dataType: 'json',
            cache: false,
            success: function(msg){ 
                $('#node_block').empty();
                for(i=0;i<msg.rows.length;i++) $('#node_block').append('<label><input type="checkbox" name="node" value="'+msg.rows[i].id+'"/> '+msg.rows[i].name+'</label>'); 
            }
        });
    }
    else $("#node_block").html('');
    $("#alarm_block").html('');
}

function getNodeSelected()
{
    jumlah = $("input[name='node']:checked").length;
    pilihan = "_";
    $("input[name='node']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    if(jumlah != 0) 
    {
        $.ajax({
            url: base_url+'reporting/get_node_objects/'+pilihan,
            dataType: 'json',
            cache: false,
            success: function(msg){ 
                $('#param_block').empty();
                for(i=0;i<msg.rows.length;i++) $('#param_block').append('<label><input type="checkbox" name="node" value="'+msg.rows[i].id+'"/> '+msg.rows[i].name+'</label>'); 
            }
        });
    }
    else $("#param_block").html('');
}

function get_data_log_url()
{
    url  = base_url+"api/poll/getlist";
    pilihan = "_";
    $("input[name='region']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;
    
    pilihan = "_";
    $("input[name='site']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;
    
    pilihan = "_";
    $("input[name='node']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;
    
    pilihan = "_";
    $("input[name='param']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;    
    
    url += '/'+$('#from').val().trim();
    url += '/'+$('#to').val().trim();
    
    return url;
}

function show_data_log(doc)
{
    region_count = $("input[name='region']:checked").length;
    if(region_count == 0) show_msg_dlg('Region Exception', 'Please select one or more region !');
    else
    {
        site_count = $("input[name='site']:checked").length;
        if(site_count == 0) show_msg_dlg('Site Exception', 'Please select one or more site !');
        else {
            node_count = $("input[name='node']:checked").length;
            if(node_count == 0) show_msg_dlg('Device Exception', 'Please select one or more device !');
            else if($('#from').val().trim() == '') show_msg_dlg('Date Exception', 'Please select start date !');
            else if($('#to').val().trim() == '') show_msg_dlg('Date Exception', 'Please select stop date !');
            else {
                if(doc == 'xls') window.open(get_data_log_url()+'/'+doc);
                else if(doc == 'tbl')
                {
                    $.ajax({
                        url: get_data_log_url()+'/'+doc,
                        dataType: 'json',
                        cache: false,
                        success: function(msg){
                            var table = $('#data_log_table').DataTable();
                            table.clear().draw();                            
                            for(i=0;i<msg.data.length;i++)
                            {
                                table.row.add([
                                    msg.data[i].site,
                                    msg.data[i].name,
                                    msg.data[i].var_name,
                                    msg.data[i].ddtime,
                                    parseFloat(msg.data[i].value).toFixed( 2 )
                                ]).draw();
                            }
                        }
                    });
                    $('#result').removeClass('hide');
                    $('#chart').addClass('hide');
                }
                else if(doc == 'img')
                {
                    $.ajax({
                        url: get_data_log_url()+'/'+doc,
                        dataType: 'json',
                        cache: false,
                        success: function(msg){
                            for(var i=0; i<msg.rows.length; i++)
                            {
                                $('#chart_node').append('<div id="chart_poll_'+msg.rows[i].id+'" class="chart" style="height: 500px;"></div>');
                                var params  = msg.rows[i].param;
                                var datas   = msg.rows[i].data;
                                for(var j=0; j<datas.length; j++) datas[j].jsdate = new Date(datas[j].jsdate);
                                var grph = [];
                                for(var k=0; k<params.length; k++)
                                {
                                    grph[k] = {
                                        "id":"g"+params[k].id,
                                        "balloonText": "[[category]]<br><b><span style='font-size:14px;'>[[value]]</span></b>",
                                        "bullet": "round",
                                        "bulletSize": 5,         
                                        //"lineColor": "#d1655d",
                                        "lineThickness": 2,
                                        "negativeLineColor": "#637bb6",
                                        "type": "smoothedLine",
                                        "title": params[k].var_name,
                                        "valueField": params[k].var_name
                                    };
                                }
                                
                                AmCharts.makeChart("chart_poll_"+msg.rows[i].id, {
                                    "type": "serial",
                                    "theme": "light",
                                    "marginTop":0,
                                    "marginRight": 80,
                                    "dataProvider": datas,
                                    "valueAxes": [{
                                        "axisAlpha": 0,
                                        "position": "left"
                                    }],
                                    "graphs": grph,
                                    "chartScrollbar": {
                                        "graph":"g1",
                                        "gridAlpha":0,
                                        "color":"#888888",
                                        "scrollbarHeight":55,
                                        "backgroundAlpha":0,
                                        "selectedBackgroundAlpha":0.1,
                                        "selectedBackgroundColor":"#888888",
                                        "graphFillAlpha":0,
                                        "autoGridCount":true,
                                        "selectedGraphFillAlpha":0,
                                        "graphLineAlpha":0.2,
                                        "graphLineColor":"#c2c2c2",
                                        "selectedGraphLineColor":"#888888",
                                        "selectedGraphLineAlpha":1
                                    },
                                    "chartCursor": {
                                        //"categoryBalloonDateFormat": "YYYY",
                                        "cursorAlpha": 0,
                                        "valueLineEnabled":true,
                                        "valueLineBalloonEnabled":true,
                                        "valueLineAlpha":0.5,
                                        "fullWidth":true
                                    },
                                    //"dataDateFormat": "YYYY",
                                    "categoryField": "jsdate",
                                    "categoryAxis": {
                                        "minPeriod": "mm",
                                        "parseDates": true,
                                        "minorGridAlpha": 0.1,
                                        "minorGridEnabled": true
                                    },
                                    "legend": {
                                        "align": "left",
                                        "marginLeft": 110,
                                        "color": "#000000"
                                    },
                                    "export": {
                                        "enabled": true
                                    },
                                    "titles": [
                                        {
                                          "size": 14,
                                          "text": msg.rows[i].node
                                        }
                                    ]
                                });
                            }
                        }
                    });
                    $('#result').addClass('hide');
                    $('#chart').removeClass('hide');
                }
            }
        }
    }
}

$(document).ready(function(){ 
    $('#data_log_table').dataTable();
});
</script>
<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>