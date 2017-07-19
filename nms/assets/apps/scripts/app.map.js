var pre_node = '';
var pre_tab  = '';
var contextmenuDir;
var site_id      = new Array();
var site_name    = new Array();
var site_xpos    = new Array();
var site_ypos    = new Array();
var site_icon    = base_url+'assets/img/radio-green.png';
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
    google.maps.event.addListener(tanda, 'mouseover', function(event) {
        //map.setZoom(15);
        //map.setCenter(tanda.getPosition());
        var label = '<strong>'+name+'</strong><br/>';
        if(alarm_severity_id != null)
        {
            label   += 'Severity   : ' + alarm_severity + '<br/>';
            label   += 'Alarm Name : ' + alarm_name + '<br/>';
            label   += 'DateTime   : ' + sdtime + '<br/>';
            label   += 'Device Name: ' + node_name + '<br/>';
            label   += 'IP Address : ' + address + '<br/>';
        }
        label   += 'Latitude : ' + xpos + '<br/>' + 'Longitude: ' + ypos + '<br/>';
        infoWindow.setContent(label);
        infoWindow.open(map, tanda);
    });
    google.maps.event.addListener(tanda, 'mouseout', function(event) { infoWindow.close(); });
    google.maps.event.addListener(tanda, 'click', function(event){ window.location.href = base_url+'subnet/view/'+id; });
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
                if(msg.rows[i].alarm_severity_id == '1') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-red.png' });
                // major = blue
                else if(msg.rows[i].alarm_severity_id == '2') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-blue.png' });
                // minor = yelloy
                else if(msg.rows[i].alarm_severity_id == '3') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-yellow.png' });
                // warning = yellow
                else if(msg.rows[i].alarm_severity_id == '4') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-yellow.png' });
                // comm lost = grey
                else if(msg.rows[i].alarm_severity_id == '5') tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-grey.png' });
                // normal = green
                else tanda = new google.maps.Marker({position: point, map: map, icon: base_url+'assets/img/radio-green.png' });

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

function loadMap()
{
    var mapDiv  = document.getElementById('map');
    var mapOptions  = {
        center: new google.maps.LatLng(-6.2115, 106.8452),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(mapDiv, mapOptions);
    
    //google.maps.event.addListener(map, 'click', function(event){ });
    
    //google.maps.event.addListener(map, "rightclick", function(event){ 
    //    showContextMenu(event);        
    //});
    
    node_load(base_url+'api/subnet/all');
}