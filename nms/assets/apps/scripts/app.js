function show_msg_dlg(title, msg)
{
    $('#dlg_title').html(title);
    $('#dlg_body').html(msg);
    $('#frmDlg').modal('show');
}

function request_post(url, data, callback)
{
    $.post(url, data, function(result){
        if (result.success){
            show_dlg_msg('Success', result.msg);
            setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
            if(typeof callback === "function") callback();
        } else {
            show_dlg_msg('Exception', result.msg);
            setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
        }
    },'json');
}

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
            404: function(){ show_dlg_msg('Exception', 'Page Not Found !'); }
        },
        complete: function(jqXHR, textStatus ) {
            NProgress.done();
            clearInterval(intervalProgress);
        },
        error: function( jqXHR, textStatus, errorThrown ) {
            show_dlg_msg(textStatus, jqXHR.responseText);
        }
    })
    .done(function(data) {
        NProgress.done();
        $( "#"+load_to).html(data);
    });
}