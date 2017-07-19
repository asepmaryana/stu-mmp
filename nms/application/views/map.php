            <!-- BEGIN PAGE HEADER-->
            <!-- BEGIN PAGE BAR -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <a href="<?php echo base_url() ?>home">Home</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>Map</span>
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
                    <div class="portlet light bordered chart" style="height: 500px;" id="map">
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
                                                <select name="region_id" id="region_id" class="form-control form-filter">
                                                    <option value="">All</option>
                                                    <?php foreach($region as $reg) print '<option value="'.$reg->id.'">'.$reg->name.'</option>'; ?>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="site_id" id="site_id" class="form-control form-filter">
                                                    <option value="">All</option>
                                                </select>
                                            </td>
                                            <td>
                                                <select name="node_id" id="node_id" class="form-control form-filter">
                                                    <option value="">All</option>
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
            
            <script type="text/javascript">
            google.maps.event.addDomListener(window, 'load', loadMap);
            timeId = setInterval(function(){ node_load(base_url+'api/subnet/all'); }, 30 * 1000);
            
            function get_alarm_url()
            {
                url  = base_url+"api/alarm/getlist";
                url += ($('#region_id').val() != '') ? '/'+$('#region_id').val() : '/_';
                url += ($('#site_id').val() != '') ? '/'+$('#site_id').val() : '/_';
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
            
            $(document).ready(function(){ 
                $('#region_id').change(function(){
                    //alert(this.value);
                    if(this.value != '')
                    {
                        $('#node_id').empty();
                        $('#node_id').append($('<option></option>').val('').html('All'));
                        $('#site_id').empty();
                        $('#site_id').append($('<option></option>').val('').html('All'));
                        $.ajax({
                            url: base_url+'api/subnet/get_by_region/'+this.value,
                            dataType: 'json',
                            cache: false,
                            success: function(msg){ for(i=0;i<msg.rows.length;i++) $('#site_id').append($('<option></option>').val(msg.rows[i].id).html(msg.rows[i].name));}
                        });
                        reload_alarm_active();
                    }
                });
                
                $('#site_id').change(function(){
                    if(this.value != '')
                    {
                        $('#node_id').empty();
                        $('#node_id').append($('<option></option>').val('').html('All'));
                        $.ajax({
                            url: base_url+'api/subnet/get_node/'+this.value,
                            dataType: 'json',
                            cache: false,
                            success: function(msg){ for(i=0;i<msg.rows.length;i++) $('#node_id').append($('<option></option>').val(msg.rows[i].id).html(msg.rows[i].name));}
                        });
                        reload_alarm_active();
                    }
                });
                
                $('#node_id').change(function(){ reload_alarm_active(); });
                $('#severity_id').change(function(){ reload_alarm_active(); });
            });
            </script>