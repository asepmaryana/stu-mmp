<?php $this->load->view('header'); ?>
<!-- END HEAD -->

<script src="<?php echo base_url();?>assets/apps/scripts/datatables-ajax.js" type="text/javascript"></script>

<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-sidebar-fixed page-md">

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
                        <a href="<?php echo base_url() ?>home#">Realtime</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><?php echo $siteName;?></span>
                    </li>
                </ul>
            </div>
            <!-- END PAGE BAR -->
            
            <!-- BEGIN PAGE TITLE-->
            <h3 class="page-title hide"> Home
                <small>Network Topology</small>
            </h3>
            
            <br/>
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered" style="height: 350px;">
                        <div title="PLN" style="z-index: 10; position: absolute; padding: 0px 0 0 40px;" id="pln">PLN <?php echo $pln_status; ?></div>
                        
                        <div title="V(R)" style="z-index: 10; position: absolute; padding: 120px 0 0 0px;" id="vr">V(R): <?php echo $vr; ?></div>
                        <div title="V(S)" style="z-index: 10; position: absolute; padding: 140px 0 0 0px;" id="vs">V(S): <?php echo $vs; ?></div>
                        <div title="V(T)" style="z-index: 10; position: absolute; padding: 160px 0 0 0px;" id="vt">V(T): <?php echo $vt; ?></div>
                        
                        <div title="I(R)" style="z-index: 10; position: absolute; padding: 120px 0 0 80px;" id="ir">I(R): <?php echo $ir; ?></div>
                        <div title="I(S)" style="z-index: 10; position: absolute; padding: 140px 0 0 80px;" id="is">I(S): <?php echo $is; ?></div>
                        <div title="I(T)" style="z-index: 10; position: absolute; padding: 160px 0 0 80px;" id="it">I(T): <?php echo $it; ?></div>
                        
                        <div title="P(R)" style="z-index: 10; position: absolute; padding: 120px 0 0 160px;" id="pr">P(R): <?php echo $ir; ?></div>
                        <div title="P(S)" style="z-index: 10; position: absolute; padding: 140px 0 0 160px;" id="ps">P(S): <?php echo $is; ?></div>
                        <div title="P(T)" style="z-index: 10; position: absolute; padding: 160px 0 0 160px;" id="pt">P(T): <?php echo $it; ?></div>
                        
                        <div title="Temp" style="z-index: 10; position: absolute; padding: 280px 0 0 0px;" id="temp">Temp: <?php echo $temp; ?> <sup>o</sup>C</div>
                        <div title="Humi" style="z-index: 10; position: absolute; padding: 300px 0 0 0px;" id="humi">Humi: <?php echo $humi; ?> %</div>
                        
                        <div title="Door Status" style="z-index: 10; position: absolute; padding: 280px 0 0 160px;" id="dor"><?php echo $door_status; ?></div>
                        <div title="Batt Voltage" style="z-index: 10; position: absolute; padding: 280px 0 0 300px;" id="bv"><?php echo $batteryVoltage; ?> VDC</div>
                        
                        <table>
                            <tr>
                                <td><img src="<?php echo base_url().'assets/images/01A.png'; ?>" id="img_ac" /></td>
                                <td><img src="<?php echo base_url().'assets/images/02A.png'; ?>" id="img_rect" /></td>
                                <td><img src="<?php echo base_url().'assets/images/03A.png'; ?>" /></td>
                                <td><img src="<?php echo base_url().'assets/images/04A.png'; ?>" id="img_load" /></td>
                            </tr>
                            <tr>
                                <td><img src="<?php echo base_url().'assets/images/05A.png'; ?>" id="img_temp" /></td>
                                <td><img src="<?php echo base_url().'assets/images/06A.png'; ?>" id="img_door" /></td>
                                <td><img src="<?php echo base_url().'assets/images/07A.png'; ?>" id="img_batt" /></td>
                                <td></td>
                            </tr>
                        </table>
                    </div>
                    <!-- END PORTLET-->
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light portlet-fit portlet-datatable bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-settings font-dark"></i>
                                <span class="caption-subject font-dark sbold uppercase">Active Alarm</span>
                            </div>
                            <!--
                            <div class="actions">
                                <div class="btn-group">
                                    <a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown">
                                        <i class="fa fa-share"></i>
                                        <span class="hidden-xs"> Actions </span>
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li>
                                            <a href="javascript:;"> Export to Excel </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;"> Export to CSV </a>
                                        </li>
                                        <li>
                                            <a href="javascript:;"> Export to PDF </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            -->
                        </div>
                        
                        <div class="portlet-body">
                            <div class="table-container">                                
                                <!--
                                <div class="table-actions-wrapper">
                                    <span> </span>
                                    <select class="table-group-action-input form-control input-inline input-small input-sm">
                                        <option value="">Select...</option>
                                        <option value="Acknowledge">Acknowledge</option>
                                        <option value="Delete">Delete</option>
                                    </select>
                                    <button class="btn btn-sm green table-group-action-submit"><i class="fa fa-check"></i> Submit</button>
                                </div>
                                -->
                                <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_ajax_id">
                                    <thead>
                                        <tr role="row" class="heading">
                                            <th width="2%">
                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                    <input type="checkbox" class="group-checkable" data-set="#datatable_ajax_id .checkboxes" />
                                                    <span></span>
                                                </label>                                                
                                            </th>
                                            <th width="13%"> Regional </th>
                                            <th width="13%"> Site </th>
                                            <th width="12%"> Equipment </th>
                                            <th width="10%"> IP Address</th>
                                            <th width="10%"> Date Time </th>
                                            <th width="10%"> Severity </th>
                                            <th width="15%"> Alarm </th>
                                            <th width="10%"> Counter </th>
                                        </tr>
                                        <tr role="row" class="filter">
                                            <td> </td>
                                            <td>
                                                
                                            </td>
                                            <td>
                                                
                                            </td>
                                            <td>
                                                <select name="node_id" id="node_id" class="form-control form-filter">
                                                    <option value="">All</option>
                                                    <?php foreach($nodes as $s) print '<option value="'.$s->id.'">'.$s->name.'</option>'; ?>
                                                </select>
                                            </td>
                                            <td> </td>
                                            <td> </td>
                                            <td>
                                                <select name="severity_id" id="severity_id" class="form-control form-filter">
                                                    <option value="">All</option>
                                                    <?php foreach($severity as $s) print '<option value="'.$s->id.'">'.$s->name.'</option>'; ?>
                                                </select>
                                            </td>
                                            <td> </td>
                                            <td> </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
            </div>
            
        </div>
        <!-- END CONTENT BODY -->
        
    </div>
    <!-- END CONTENT -->
    
</div>
<!-- END CONTAINER -->
<script type="text/javascript">
    function get_status_ac()
    {
        $.ajax({
            url: base_url+'subnet/get_status_ac/<?php echo $site->id?>',
            dataType: 'html',
            cache: false,
            success: function(msg){ $('#img_ac').attr('src', msg); }
        });
    }
    
    function get_status_rect()
    {
        $.ajax({
            url: base_url+'subnet/get_status_rect/<?php echo $site->id?>',
            dataType: 'html',
            cache: false,
            success: function(msg){ $('#img_rect').attr('src', msg); }
        });
    }
    
    function get_status_temp()
    {
        $.ajax({
            url: base_url+'subnet/get_status_temp/<?php echo $site->id?>',
            dataType: 'html',
            cache: false,
            success: function(msg){ $('#img_temp').attr('src', msg); }
        });
    }
    
    function get_status_door()
    {
        $.ajax({
            url: base_url+'subnet/get_status_door/<?php echo $site->id?>',
            dataType: 'html',
            cache: false,
            success: function(msg){ $('#img_door').attr('src', msg); }
        });
    }
    
    function get_status_batt()
    {
        $.ajax({
            url: base_url+'subnet/get_status_batt/<?php echo $site->id?>',
            dataType: 'html',
            cache: false,
            success: function(msg){ $('#img_batt').attr('src', msg); }
        });
    }
    
    function get_data()
    {
        $.ajax({
            url: base_url+'subnet/get_data/<?php echo $site->id?>',
            dataType: 'json',
            cache: false,
            success: function(msg){ 
                if(msg.success) {
                    $('#vr').val('V(R): ' + msg.data.vr);
                    $('#vs').val('V(S): ' + msg.data.vs);
                    $('#vt').val('V(T): ' + msg.data.vt);
                    $('#ir').val('I(R): ' + msg.data.ir);
                    $('#is').val('I(S): ' + msg.data.is);
                    $('#it').val('I(T): ' + msg.data.it);
                    $('#pr').val('P(R): ' + msg.data.pr);
                    $('#ps').val('P(S): ' + msg.data.ps);
                    $('#pt').val('P(T): ' + msg.data.pt);
                    
                    $('#temp').val('Temp: ' + msg.data.temp + ' <sup>o</sup>C');
                    $('#humi').val('Humi: ' + msg.data.humi + ' %');
                    $('#bv').val('I(T): ' + msg.data.it + ' VDC');
                    $('#dor').val('I(R): ' + msg.data.ir);
                }
                else show_msg_dlg('Exception', msg.msg);
            }
        });
    }
    
    function reload_site_diagram()
    {
        get_status_ac();
        get_status_rect();
        get_status_temp();
        get_status_door();
        get_status_batt();
        get_data();
    }
    
    reload_site_diagram();
    
    setInterval(function(){ reload_site_diagram(); }, 30 * 1000);
    
    function get_alarm_url()
    {
        url  = base_url+"api/alarm/getlist/<?php echo $site->region_id.'/'.$site->id?>";
        url += ($('#node_id').val() != '') ? '/'+$('#node_id').val() : '/_';
        url += ($('#severity_id').val() != '') ? '/'+$('#severity_id').val() : '/_';
        return url;
    }
            
    function reload_alarm_active()
    {
        var table = $('#datatable_ajax_id').dataTable();
        var setting = table.fnSettings();
        setting.ajax.url = get_alarm_url();
        table.fnDraw();
    }
            
    var TableDatatablesAjax=function(){
        var a=function(){$(".date-picker").datepicker({rtl:App.isRTL(),autoclose:!0})},
        e=function(){
            var a=new Datatable;
            a.init({
                src:$("#datatable_ajax_id"),
                onSuccess:function(a,e){},
                onError:function(a){},
                onDataLoad:function(a){},
                loadingMessage:"Loading...",
                dataTable:{
                    bStateSave:!0,
                    lengthMenu:[[10,20,50,100,150,-1],[10,20,50,100,150,"All"]],
                    pageLength:10,
                    ajax:{url:get_alarm_url()},
                    order:[[5,"desc"]]
                }
            }),                    
            a.getTableWrapper().on("click",".table-group-action-submit",function(e){e.preventDefault();var t=$(".table-group-action-input",a.getTableWrapper());""!=t.val()&&a.getSelectedRowsCount()>0?(a.setAjaxParam("customActionType","group_action"),a.setAjaxParam("customActionName",t.val()),a.setAjaxParam("id",a.getSelectedRows()),a.getDataTable().ajax.reload(),a.clearAjaxParams()):""==t.val()?App.alert({type:"danger",icon:"warning",message:"Please select an action",container:a.getTableWrapper(),place:"prepend"}):0===a.getSelectedRowsCount()&&App.alert({type:"danger",icon:"warning",message:"No record selected",container:a.getTableWrapper(),place:"prepend"})})
        };
        return {init:function(){a();e();}}
    }();
                        
    setInterval(function(){ reload_alarm_active(); }, 30 * 1000);
</script>
<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>