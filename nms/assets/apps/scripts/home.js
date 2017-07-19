function loadPage(url, content){ $('#'+content).load(url); }
function logout() { $.messager.confirm('Question', 'Do you want to logout ?', function(r){ if (r) window.location.href = base_url+'login/logout'; });}

function dateFormater(date)
{                
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+'-'+(m<10?'0'+m:m)+'-'+(d<10?'0'+d:d);                                
}

function change_password() { $('#form_update_pass').form('clear'); $('#win_update_pass').window('open'); }
function tutup_pass() { $('#win_update_pass').window('close'); }

function simpan_pass()
{
    pass_lama = $('#pass_lama').val();
    pass_baru = $('#pass_baru').val();
    konf_baru = $('#konf_pass_baru').val();
    
    if(pass_lama == '') {
        $.messager.alert('Exception','Old password is required !','error');
        return false;
    }
    if(pass_baru == '') {
        $.messager.alert('Exception','New password is required !','error');
        return false;
    }
    if(konf_baru == '') {
        $.messager.alert('Exception','New password again !','error');
        return false;
    }
    if(pass_baru != konf_baru) {
        $.messager.alert('Exception','New password is not the same !','error');
        return false;        
    }
    
    $.messager.confirm('Question', 'Do you want to change your password ?', function(r){
        if (r){
            //alert($("#form_update_pass").serialize());
            $.ajax({  
                type: "post",  
                url: base_url+'login/setpwd',  
                data: $("#form_update_pass").serialize(),  
                success: function(data){                                
                    obj = $.parseJSON(data);
                    if(obj.success) {
                        $.messager.alert('Success', obj.msg,'info');
                        $('#form_update_pass').form('clear');
                        $('#win_update_pass').window('close');                
                    } else $.messager.alert('Exception', obj.msg,'error');
                }  
            });
        }
    });
}


function getDeviceTypeSelected()
{
    deviceTypeCount = $("input[name='device_type']:checked").length;
    deviceType = "_";
    $("input[name='device_type']:checked").each(function(i){
         deviceType += $(this).val() + ".";
    });
    if(deviceType.length > 1) deviceType = deviceType.substring(1, deviceType.length - 1);
      
    node_type   = '_';
    node_id     = '_';
    
    siteCount = $("input[name='site']:checked").length;
    if(siteCount > 0) {
        node_type   = 'site';
        $("input[name='site']:checked").each(function(i){
            node_id += $(this).val() + ".";
        });
        if(node_id.length > 1) node_id = node_id.substring(1, node_id.length - 1);
        //alert('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType);
        loadPage('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType, 'block_device');
        return;
    }
    
    areaCount = $("input[name='area']:checked").length;
    if(areaCount > 0) {
        node_type   = 'area';
        $("input[name='area']:checked").each(function(i){
            node_id += $(this).val() + ".";
        });
        if(node_id.length > 1) node_id = node_id.substring(1, node_id.length - 1);
        //alert('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType);    
        loadPage('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType, 'block_device');
        return;
    }
    
    regionCount = $("input[name='region']:checked").length;
    if(regionCount > 0) {
        node_type   = 'region';
        $("input[name='region']:checked").each(function(i){
            node_id += $(this).val() + ".";
        });
        if(node_id.length > 1) node_id = node_id.substring(1, node_id.length - 1);
        //alert('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType);   
        loadPage('reporting/loadNode/'+node_type+'/'+node_id+'/'+deviceType, 'block_device'); 
        return;
    }
}

var intervalProgress;

function request_get(load_url)
{
    var result_html = '';
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
                $.messager.alert('Exception', 'Page Not Found !','error');
            }
        },
        complete: function(jqXHR, textStatus ) {
            NProgress.done();
            clearInterval(intervalProgress);
        }
    })
    .done(function(data) {
        NProgress.done();
        //$( "#"+load_to).html(data);
        result_html = data;
    });
    
    return result_html;
}

function addTab(title, url)
{
    if ($('#maint').tabs('exists', title)){
        $('#maint').tabs('select', title);
        var tab = $('#maint').tabs('getSelected');
        tab.panel('refresh', url);
    } else {
        //var content = request_get(url);
        $('#maint').tabs('add',{
            title:title,
            //content:content,
            closable:true
        });
        $('#maint').tabs('select', title);
        var tab = $('#maint').tabs('getSelected');
        tab.panel('refresh', url);
    }
}

var pre_node = '';
var pre_tab  = '';
var contextmenuDir;
var site_id      = new Array();
var site_name    = new Array();
var site_xpos    = new Array();
var site_ypos    = new Array();
var site_icon    = base_url+'assets/images/radio-green.png';
var site_dtime   = new Array();
var site_alarm   = new Array();
var site_severity= new Array();
var markers = {};
var contextmenuDir;
var cevent;
var map;
var timeId;
var dashTimeId;
var diagramTimeId;
var i=0;
var infoWindow = new google.maps.InfoWindow();
var tropen = false;

function getCanvasXY(currentLatLng)
{
    var scale = Math.pow(2, map.getZoom());
    var nw = new google.maps.LatLng(
        map.getBounds().getNorthEast().lat(),
        map.getBounds().getSouthWest().lng()
    );
    var worldCoordinateNW = map.getProjection().fromLatLngToPoint(nw);
    var worldCoordinate = map.getProjection().fromLatLngToPoint(currentLatLng);
    var currentLatLngOffset = new google.maps.Point(
        Math.floor((worldCoordinate.x - worldCoordinateNW.x) * scale),
        Math.floor((worldCoordinate.y - worldCoordinateNW.y) * scale)
    );
    return currentLatLngOffset;
}

function setMenuXY(currentLatLng)
{
    var mapWidth = $('#map').width();
    var mapHeight = $('#map').height();
    var menuWidth = $('.contextmenu').width();
    var menuHeight = $('.contextmenu').height();
    var clickedPosition = getCanvasXY(currentLatLng);
    var x = clickedPosition.x + 50;
    var y = clickedPosition.y - 200;
    
    if((mapWidth - x ) < menuWidth) x = x - menuWidth;
    if((mapHeight - y ) < menuHeight) y = y - menuHeight;
    
    $('.contextmenu').css('left', x);
    $('.contextmenu').css('top', y);
};

function showContextMenu(latLng, subnet_id, content)
{
    tropen = true;
    var projection;
    var min_val = 0;
    var max_val = 0;
    projection = map.getProjection();
    $('.contextmenu').remove();
    contextmenuDir = document.createElement("div");
    contextmenuDir.className    = 'contextmenu';
    contextmenuDir.innerHTML    = content;
    $(map.getDiv()).append(contextmenuDir);
    setMenuXY(latLng);
    contextmenuDir.style.visibility = "visible";
    $('#btnclose').click(function(){ $('.contextmenu').remove(); tropen = false; });
    $('#btncancel').click(function(){ $('.contextmenu').remove(); tropen = false; });
}

function node_create(tanda, id, name, xpos, ypos, alarm_severity_id, alarm_severity, alarm_name, sdtime, node_name, address)
{
    google.maps.event.addListener(tanda, 'click', function(event){  });
    google.maps.event.addListener(tanda, 'mouseover', function(event) {
        //map.setZoom(15);
        //map.setCenter(tanda.getPosition());
        var label = '<strong>'+name+'</strong><br/>';
        if(alarm_severity_id != null)
        {
            label   += 'Severity   : ' + alarm_severity + '<br/>';
            label   += 'Alarm Name : ' + alarm_name + '<br/>';
            label   += 'Date/Time  : ' + sdtime + '<br/>';
            label   += 'Device Name: ' + node_name + '<br/>';
            label   += 'IP Address : ' + address + '<br/>';
        }
        label   += 'Latitude : ' + xpos + '<br/>' + 'Longitude: ' + ypos + '<br/>';
        infoWindow.setContent(label);
        infoWindow.open(map, tanda);
    });
    google.maps.event.addListener(tanda, 'mouseout', function(event) { infoWindow.close(); });
    google.maps.event.addListener(tanda, 'click', function(event){ addTab(name, base_url+'subnet/view/'+id); });
    /*
    google.maps.event.addListener(tanda, 'mouseover', function(event) {
        //map.setZoom(15);
        //map.setCenter(tanda.getPosition());
        var label = '<strong>'+name+'</strong><br/>' + 
            'Latitude : ' + xpos + '<br/>' + 
            'Longitude: ' + ypos + '<br/>' + 
            'Speed : ' + speed + ' knot<br/>' + 
            'Last Updated : ' + last_updated;
        infoWindow.setContent(label);
        infoWindow.open(map, tanda);
    });
    google.maps.event.addListener(tanda, 'mouseout', function(event) { infoWindow.close(); });
    //google.maps.event.addListener(tanda, 'rightclick', function(event) {
    //    showContextMenu(event, id[index]);
    //});
    */
}

function node_load(url)
{
    $.ajax({
        url: url,
        dataType: 'json',
        cache: false,
        success: function(msg){
            for(i=0;i<msg.rows.length;i++)
            {
                //alert(msg.rows[i].name);
                var point = new google.maps.LatLng(
                    parseFloat(msg.rows[i].xpos),
                    parseFloat(msg.rows[i].ypos)
                );
                
                // critical = red
                if(msg.rows[i].alarm_severity_id == '1') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-red.png' });
                // major = blue
                else if(msg.rows[i].alarm_severity_id == '2') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-blue.png' });
                // minor = yelloy
                else if(msg.rows[i].alarm_severity_id == '3') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-yellow.png' });
                // warning = yellow
                else if(msg.rows[i].alarm_severity_id == '4') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-yellow.png' });
                // comm lost = grey
                else if(msg.rows[i].alarm_severity_id == '5') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-grey.png' });
                // normal = green
                else tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'images/radio-green.png' });

                // remove marker previous
                if( markers[msg.rows[i].id] != null ) {
                    node = markers[msg.rows[i].id];
                    node.setMap(null);
                }

                // register marker to array markers
                markers[msg.rows[i].id] = tanda;
                node_create(tanda, msg.rows[i].id, msg.rows[i].name, msg.rows[i].xpos, msg.rows[i].ypos, msg.rows[i].alarm_severity_id, msg.rows[i].alarm_severity, msg.rows[i].alarm_name, msg.rows[i].sdtime, msg.rows[i].node_name, msg.rows[i].address);
            }
        }
    });
}