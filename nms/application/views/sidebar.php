<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
    <!-- BEGIN SIDEBAR -->

    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <ul class="page-sidebar-menu  page-header-fixed " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px">
            <li class="sidebar-toggler-wrapper hide">
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                <div class="sidebar-toggler"> </div>
                <!-- END SIDEBAR TOGGLER BUTTON -->
            </li>
            <li class="sidebar-search-wrapper">
                <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
                <form class="sidebar-search  sidebar-search-bordered" action="" method="post">
                    <a href="javascript:;" class="remove">
                        <i class="icon-close"></i>
                    </a>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search..."/>
                        <span class="input-group-btn">
                            <a href="javascript:;" class="btn submit">
                                <i class="icon-magnifier"></i>
                            </a>
                        </span>
                    </div>
                </form>
                <!-- END RESPONSIVE QUICK SEARCH FORM -->
            </li>
            <li class="nav-item start <?php if($this->uri->segment(1) == 'home') echo 'active'; ?>">
                <a href="<?php echo base_url() ?>home" class="nav-link nav-toggle">
                    <i class="icon-home"></i>
                    <span class="title">Home</span>
                    <span class="selected"></span>
                </a>
                <!--
                <ul class="sub-menu hide">
                    <li class="nav-item start ">
                        <a href="index.html" class="nav-link ">
                            <i class="icon-bar-chart"></i>
                            <span class="title">Dashboard 1</span>
                        </a>
                    </li>
                    <li class="nav-item start">
                        <a href="dashboard_2.html" class="nav-link ">
                            <i class="icon-bulb"></i>
                            <span class="title">Dashboard 2</span>
                            <span class="badge badge-success">1</span>
                        </a>
                    </li>
                    <li class="nav-item start ">
                        <a href="dashboard_3.html" class="nav-link ">
                            <i class="icon-graph"></i>
                            <span class="title">Dashboard 3</span>
                            <span class="badge badge-danger">5</span>
                        </a>
                    </li>
                </ul>
                 -->
            </li>
            <li class="nav-item start <?php if($this->uri->segment(1) == 'dashboard') echo 'active'; ?>">
                <a href="<?php echo base_url() ?>dashboard" class="nav-link">
                    <i class="fa fa-tachometer"></i>
                    <span class="title">Dashboard</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class="nav-item start <?php if($this->uri->segment(1) == 'reporting') echo 'active'; ?>">
                <a href="javascript:;" class="nav-link nav-toggle">
                    <i class="icon-bar-chart"></i>
                    <span class="title">Reporting</span>
                    <span class="selected"></span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub-menu">
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>reporting/alarmlog" class="nav-link ">
                            <i class="icon-bell"></i>
                            <span class="title">Fault</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>reporting/datalog" class="nav-link ">
                            <i class="fa fa-line-chart"></i>
                            <span class="title">Polling</span>                            
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item start">
                <a href="javascript:;" class="nav-link nav-toggle">
                    <i class="fa fa-cog"></i>
                    <span class="title">Management</span>
                    <span class="selected"></span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub-menu">
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>region" class="nav-link ">
                            <i class="icon-globe"></i>
                            <span class="title">Region</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>area" class="nav-link ">
                            <i class="fa fa-sitemap"></i>
                            <span class="title">Area</span>                            
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>site" class="nav-link ">
                            <i class="icon-pointer"></i>
                            <span class="title">Site</span>                            
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>node" class="nav-link ">
                            <i class="fa fa-desktop"></i>
                            <span class="title">Device</span>                            
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<?php echo base_url() ?>users" class="nav-link ">
                            <i class="fa fa-users"></i>
                            <span class="title">Account</span>                            
                        </a>
                    </li>
                </ul>
            </li>
            <li class="heading">
                <h3 class="uppercase">Site Topology</h3>
            </li>
            <?php echo load_menu(); ?>
        </ul>
        <!-- END SIDEBAR MENU -->
        <!-- END SIDEBAR MENU -->
    </div>
    <!-- END SIDEBAR -->
</div>
<!-- END SIDEBAR -->