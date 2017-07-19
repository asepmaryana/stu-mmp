<?php $this->load->view('header'); ?>
<!-- END HEAD -->
<script src="<?php echo base_url();?>assets/apps/scripts/datatables-ajax.js" type="text/javascript"></script>
<script src="<?php echo base_url();?>assets/apps/scripts/admin/region.js" type="text/javascript"></script>
        
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
                        <span>Management</span>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>Region</span>
                    </li>
                </ul>
            </div>
            <!-- END PAGE BAR -->
            
            <!-- BEGIN PAGE TITLE-->
            <h1 class="page-title"> Regions
                <!-- <small>Fault Summaries</small> -->
            </h1>
            
            <br/>
            <!-- END PAGE TITLE-->
            <!-- END PAGE HEADER-->
            
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <div class="caption"><i class="fa fa-bell"></i>Region</div>
                            <div class="actions">
                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="edit_region('')"><i class="icon-plus"></i> New </a>
                            </div>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <table class="table table-striped table-bordered table-hover" id="region_table">
                            <thead>
                                <tr>
                                    <th> Name </th>
                                    <th> Description </th>
                                    <th> Action </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="frmRegion" tabindex="-1" role="basic" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                            <h4 class="modal-title" id="frm_region_title">Add Region</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal" role="form" id="form_region" method="post">
                                <input type="hidden" name="id" id="id" value="" />
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Name </label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="Enter region name" name="name" id="name"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Description </label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="Enter description" name="description" id="description"/>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn green" onclick="save_region()">Save</button>
                            <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
                                        
        </div>
        <!-- END CONTENT BODY -->
        
    </div>
    <!-- END CONTENT -->
    
</div>
<!-- END CONTAINER -->

<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>