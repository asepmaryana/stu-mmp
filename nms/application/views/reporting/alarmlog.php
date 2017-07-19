<?php $this->load->view('header'); ?>
<!-- END HEAD -->

<script src="<?php echo base_url();?>assets/apps/scripts/nprogress.js" type="text/javascript"></script>
<script src="<?php echo base_url();?>assets/apps/scripts/app.js" type="text/javascript"></script>
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
                        <span>Alarm</span>
                    </li>
                </ul>
            </div>
            <!-- END PAGE BAR -->
            
            <!-- BEGIN PAGE TITLE-->
            <h1 class="page-title"> Faulty Report
                <small>Fault Summaries</small>
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
                
                <div class="col-md-2 col-sm-2">
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
                
                <div class="col-md-2 col-sm-2">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-puzzle"></i>
                                <span class="caption-subject">Severity</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list">
                                        <?php foreach($severity as $r): ?>
                                        <label><input type="checkbox" name="severity" value="<?php echo $r->id; ?>" onclick="getSeveritySelected()"/> <?php echo $r->name; ?></label>
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
                                <i class="icon-bell"></i>
                                <span class="caption-subject">Alarm Name</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list" id="alarm_block">
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
                                            <a href="javascript:;" class="btn btn-sm blue" onclick="show_alarm_log('json')"><i class="fa fa-search"></i> </a>
                                            <a href="javascript:;" class="btn btn-sm blue" onclick="show_alarm_log('xls')"><i class="fa fa-download"></i> </a>
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
                            <div class="caption"><i class="fa fa-bell"></i>Alarm Log </div>
                            <div class="actions">
                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="show_alarm_log('xls')"><i class="fa fa-download"></i> Export </a>
                            </div>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <table class="table table-striped table-bordered table-hover" id="alarm_log_table">
                            <thead>
                                <tr>
                                    <th> Region </th>
                                    <th> Site </th>
                                    <th> Device </th>                                    
                                    <th> Start </th>
                                    <th> Stop </th>
                                    <th> Severity </th>
                                    <th> Alarm </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
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

function getSeveritySelected()
{
    jumlah = $("input[name='severity']:checked").length;
    pilihan = "_";
    $("input[name='severity']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    if(jumlah != 0) 
    {
        $.ajax({
            url: base_url+'reporting/get_alarm_list/'+pilihan,
            dataType: 'json',
            cache: false,
            success: function(msg){ 
                $('#alarm_block').empty();
                for(i=0;i<msg.rows.length;i++) $('#alarm_block').append('<label><input type="checkbox" name="alarm" value="'+msg.rows[i].id+'"/> '+msg.rows[i].alarm_name+'</label>'); 
            }
        });
    }
    else $("#alarm_block").html('');
}

function get_alarm_log_url()
{
    url  = base_url+"api/alarmlog/getlist";
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
    $("input[name='severity']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;
    
    pilihan = "_";
    $("input[name='alarm']:checked").each(function(i){ pilihan += $(this).val() + "_"; });
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    url += '/'+pilihan;
    
    url += '/'+$('#from').val().trim();
    url += '/'+$('#to').val().trim();
    
    return url;
}

function show_alarm_log(doc)
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
                if(doc == 'xls') window.open(get_alarm_log_url()+'/'+doc);
                else 
                {
                    $.ajax({
                        url: get_alarm_log_url()+'/'+doc,
                        dataType: 'json',
                        cache: false,
                        success: function(msg){
                            var table = $('#alarm_log_table').DataTable();
                            table.clear().draw();
                            //table.getDataTable().fnClearTable();
                            for(i=0;i<msg.data.length;i++)
                            {
                                table.row.add([msg.data[i].regional,
                                    msg.data[i].site,
                                    msg.data[i].label,
                                    msg.data[i].ddtime,
                                    msg.data[i].ddtime_end,
                                    msg.data[i].severity,
                                    msg.data[i].alarm_name
                                ]).draw();
                            }
                        }
                    });
                    $('#result').removeClass('hide');
                }
            }
        }
    }
}

$(document).ready(function(){ 
    $('#alarm_log_table').dataTable();
});
</script>
<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>