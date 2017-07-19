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
        
            <?php $this->load->view('map');?>
            
        </div>
        <!-- END CONTENT BODY -->
        
    </div>
    <!-- END CONTENT -->
    
</div>
<!-- END CONTAINER -->

<!--Load All javascipt-->
<?php $this->load->view('footer'); ?>