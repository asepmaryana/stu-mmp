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
                        <span>Dashboard</span>
                    </li>
                </ul>
            </div>
            <!-- END PAGE BAR -->
            
            <!-- BEGIN PAGE TITLE-->
            <h1 class="page-title"> Dashboard
                <small>System Summaries</small>
            </h1>
            
            <br/>
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <a class="dashboard-stat dashboard-stat-v2 blue" href="#">
                        <div class="visual">
                            <i class="icon-globe"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="<?php echo $site_con; ?>"><?php echo $site_con; ?></span>
                            </div>
                            <div class="desc"> Site Connected </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <a class="dashboard-stat dashboard-stat-v2 green" href="#">
                        <div class="visual">
                            <i class="icon-link"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="<?php echo $device_con; ?>"><?php echo $device_con; ?></span>
                            </div>
                            <div class="desc"> Device Connected </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <a class="dashboard-stat dashboard-stat-v2 yellow" href="#">
                        <div class="visual">
                            <i class="fa fa-signal"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="<?php echo $device_up; ?>"><?php echo $device_up; ?></span>
                            </div>
                            <div class="desc"> Device Up </div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <a class="dashboard-stat dashboard-stat-v2 red" href="#">
                        <div class="visual">
                            <i class="fa fa-unlink"></i>
                        </div>
                        <div class="details">
                            <div class="number">
                                <span data-counter="counterup" data-value="<?php echo $device_down; ?>"><?php echo $device_down; ?></span>
                            </div>
                            <div class="desc"> Lost Contact </div>
                        </div>
                    </a>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart font-dark hide"></i>
                                <span class="caption-subject font-dark bold uppercase">Alarm By Severity</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="chart_alarm_severity" class="chart"> </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-6 col-sm-6">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart font-dark hide"></i>
                                <span class="caption-subject font-dark bold uppercase">Inventory By Device</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="chart_inv_device" class="chart"> </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-12 col-sm-12">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart font-dark hide"></i>
                                <span class="caption-subject font-dark bold uppercase">Rectifier Availability</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="chart_rect_av" class="chart"> </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                
                <div class="col-md-12 col-sm-12">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart font-dark hide"></i>
                                <span class="caption-subject font-dark bold uppercase">Energy Consumption</span>                                
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="chart_power_usage" class="chart"> </div>
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
function severityDetail(label, severity_id)
{
    alert(label);
}
function deviceDetail(subnet_id, device_id)
{
    
}
$(document).ready(function(){ 
    AmCharts.makeChart("chart_alarm_severity",
    {
        theme:"light",
        type:"serial",
        startDuration:2,
        fontFamily:"Open Sans",
        color:"#888",
        //dataProvider:[{country:"USA",visits:4025,color:"#FF0F00"},{country:"China",visits:1882,color:"#FF6600"},{country:"Japan",visits:1809,color:"#FF9E01"},{country:"Germany",visits:1322,color:"#FCD202"},{country:"UK",visits:1122,color:"#F8FF01"},{country:"France",visits:1114,color:"#B0DE09"},{country:"India",visits:984,color:"#04D215"},{country:"Spain",visits:711,color:"#0D8ECF"},{country:"Netherlands",visits:665,color:"#0D52D1"},{country:"Russia",visits:580,color:"#2A0CD0"},{country:"South Korea",visits:443,color:"#8A0CCF"},{country:"Canada",visits:441,color:"#CD0D74"},{country:"Brazil",visits:395,color:"#754DEB"},{country:"Italy",visits:386,color:"#DDDDDD"},{country:"Australia",visits:384,color:"#999999"},{country:"Taiwan",visits:338,color:"#333333"},{country:"Poland",visits:328,color:"#000000"}],
        dataProvider: <?php echo json_encode($severity);?>,
        valueAxes:[{title:"Count",position:"left",axisAlpha:0,gridAlpha:0}],
        graphs:[{balloonText:"[[label]]: <b>[[value]]</b>",colorField:"color",fillAlphas:.85,lineAlpha:.1,type:"column",topRadius:1,valueField:"value",urlField:"link"}],
        depth3D:20,
        angle:15,
        chartCursor:{categoryBalloonEnabled:!1,cursorAlpha:0,zoomable:!1},
        categoryField:"label",
        categoryAxis:{gridPosition:"start",axisAlpha:0,gridAlpha:0},
        exportConfig:{menuTop:"20px",menuRight:"20px",menuItems:[{icon:"/lib/3/images/export.png",format:"png"}]}
    },0);
    
    AmCharts.makeChart("chart_inv_device",
    {
        theme:"light",
        type:"serial",
        startDuration:2,
        fontFamily:"Open Sans",
        color:"#888",
        dataProvider: <?php echo json_encode($inv);?>,
        valueAxes:[{title:"Count",position:"left",axisAlpha:0,gridAlpha:0}],
        graphs:[{balloonText:"[[name]]: <b>[[total]]</b>",colorField:"color",fillAlphas:.85,lineAlpha:.1,type:"column",topRadius:1,valueField:"total",urlField:"link"}],
        depth3D:20,
        angle:15,
        chartCursor:{categoryBalloonEnabled:!1,cursorAlpha:0,zoomable:!1},
        categoryField:"name",
        categoryAxis:{gridPosition:"start",axisAlpha:0,gridAlpha:0},
        exportConfig:{menuTop:"20px",menuRight:"20px",menuItems:[{icon:"/lib/3/images/export.png",format:"png"}]}
    },0);
    
    AmCharts.makeChart("chart_rect_av",
    {
        theme:"light",
        type:"serial",
        startDuration:1,
        fontFamily:"Open Sans",
        color:"#888",
        dataProvider: <?php echo json_encode($av);?>,
        valueAxes:[{title:"Availability (%)",position:"left",axisAlpha:0,gridAlpha:0}],
        graphs:[
            {balloonText:"[[category]]: <b>[[value]]</b>",fillColors:"#ADD981",fillAlphas:1,lineAlpha:0,type:"column",fontSize:8,valueField:'<?php echo $lastmonth;?>',title:'<?php echo $lastmonth;?>', urlField:"preurl"},
            {balloonText:"[[category]]: <b>[[value]]</b>",fillColors:"#81ACD9",fillAlphas:1,lineAlpha:0,type:"column",fontSize:8,valueField:'<?php echo $thismonth;?>',title:'<?php echo $thismonth;?>', urlField:"cururl"}
        ],
        depth3D:20,
        angle:30,
        chartCursor:{categoryBalloonEnabled:!1,cursorAlpha:0,zoomable:!1},
        categoryField:"region",
        categoryAxis:{labelRotation:0,dashLength:5,labelRotation:20,fontSize:8,gridPosition:"start",axisAlpha:0,gridAlpha:0},
        exportConfig:{menuTop:"20px",menuRight:"20px",menuItems:[{icon:"/lib/3/images/export.png",format:"png"}]},
        legend: {color:'#000000'}
    },0);
    
    AmCharts.makeChart("chart_power_usage",
    {
        theme:"light",
        type:"serial",
        startDuration:1,
        fontFamily:"Open Sans",
        color:"#888",
        dataProvider: <?php echo json_encode($kwh);?>,
        valueAxes:[{title:"Total (kWh)",position:"left",axisAlpha:0,gridAlpha:0}],
        graphs:[
            {balloonText:"[[category]]: <b>[[value]]</b>",fillColors:"#ADD981",fillAlphas:1,lineAlpha:0,type:"column",fontSize:8,valueField:'<?php echo $lastmonth;?>',title:'<?php echo $lastmonth;?>', urlField:"preurl"},
            {balloonText:"[[category]]: <b>[[value]]</b>",fillColors:"#81ACD9",fillAlphas:1,lineAlpha:0,type:"column",fontSize:8,valueField:'<?php echo $thismonth;?>',title:'<?php echo $thismonth;?>', urlField:"cururl"}
        ],
        depth3D:20,
        angle:30,
        chartCursor:{categoryBalloonEnabled:!1,cursorAlpha:0,zoomable:!1},
        categoryField:"region",
        categoryAxis:{labelRotation:0,dashLength:5,labelRotation:20,fontSize:8,gridPosition:"start",axisAlpha:0,gridAlpha:0},
        exportConfig:{menuTop:"20px",menuRight:"20px",menuItems:[{icon:"/lib/3/images/export.png",format:"png"}]},
        legend: {color:'#000000'}
    },0);
});
</script>
<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>