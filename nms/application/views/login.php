<?php $this->load->view('header'); ?>

<body class="login">
<!-- BEGIN LOGO -->
<div class="logo">
    <a href=""><img src="<?php echo base_url() ?>/assets/img/mmp-login.png"  /> </a>
</div>
<!-- END LOGO -->

<!-- BEGIN LOGIN -->
<div class="content">
    <!-- BEGIN LOGIN FORM -->
    <form class="login-form" method="post" id="form_login">
        <div class="form-title text-center">
            <span class="form-title">Welcome.</span>
        </div>
        <div class="alert alert-danger display-hide">
            <button class="close" data-close="alert"></button>
            <span> Enter username and password. </span>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">Username</label>
            <input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" name="username" id="username" /> </div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">Password</label>
            <input class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password" name="password" id="password" /> </div>
        <div class="form-actions">
            <!--<button type="submit" class="btn red btn-block uppercase">Login</button>-->
            <a href="#" class="btn red btn-block uppercase" onclick="login()">Login</a>
        </div>
        <div class="form-actions">
            <div class="pull-left">
                <label class="rememberme check">
                    <input type="checkbox" name="remember" value="1" />Remember me </label>
            </div>
            <div class="pull-right forget-password-block">
                <a href="javascript:;" id="forget-password" class="forget-password">Forgot Password?</a>
            </div>
        </div>
    </form>
    <!-- END LOGIN FORM -->
    
    <div class="modal fade" id="frmDlg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">                    
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">                        
                        <h4 class="modal-title" id="dlg_title"></h4>
                    </div>
                    <div class="modal-body" id="dlg_body"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                                        
                    </div>
                </div>
            </div>
    </div>
        
</div>
<!-- END LOGIN -->

<script src="<?php echo base_url();?>assets/apps/scripts/login.js" type="text/javascript"></script>

<?php $this->load->view('footer'); ?>