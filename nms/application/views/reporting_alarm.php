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
                        <a href="index.html">Home</a>
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
                <form role="form">
                <div class="col-md-2 col-sm-2">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet box blue">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-globe"></i>
                                <span class="caption-subject font-dark">Region</span>                                
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
                                <span class="caption-subject font-dark">Site</span>                                
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
                                <span class="caption-subject font-dark">Device</span>                                
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
                                <span class="caption-subject font-dark">Severity</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                                <div class="form-group">
                                    <div class="checkbox-list">
                                        <?php foreach($severity as $r): ?>
                                        <label><input type="checkbox" name="severity_id" value="<?php echo $r->id; ?>"/> <?php echo $r->name; ?></label>
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
                                <span class="caption-subject font-dark">Alarm Name</span>                                
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
                                <span class="caption-subject font-dark">Time Periode</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:150px" data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                </form>
                
            </div>
            
            <div class="row">
            </div>
            
        </div>
        <!-- END CONTENT BODY -->
        
    </div>
    <!-- END CONTENT -->
    
</div>
<!-- END CONTAINER -->

<script type="text/javascript">
function request_get(load_url, load_to)
{
    $.ajax({
        url: load_url,
        cache: false,
        method: 'GET',
        beforeSend: function(jqXHR, settings ) {
            NProgress.start();
            intervalProgress = setInterval(function() { NProgress.inc(); }, 1000);
        },        
        statusCode: {
            404: function(){
                $('#dlg_title').html('Error');
                $('#dlg_body').html('Page Not Found');
                $('#frmDlg').modal('show');
            }
        },
        complete: function(jqXHR, textStatus ) {
            NProgress.done();
            clearInterval(intervalProgress);
        },
        error: function( jqXHR, textStatus, errorThrown ) {
            $('#dlg_title').html(textStatus);
            $('#dlg_body').html(jqXHR.responseText);
            $('#frmDlg').modal('show');
        }
    })
    .done(function(data) {
        NProgress.done();
        $( "#"+load_to).html(data);
    });
}

function getRegionSelected()
{
    jumlah = $("input[name='region']:checked").length;
    pilihan = "_";
    $("input[name='region']:checked").each(function(i){ pilihan += $(this).val() + "_";});
    if(pilihan.length > 1) pilihan = pilihan.substring(1, pilihan.length - 1);
    if(jumlah != 0) request_get(base_url+'reporting/get_sites/'+pilihan, 'site_block');
    else $("#site_block").html('');
    $("#node_block").html('');
    $("#alarm_block").html('');
}
</script>
<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>