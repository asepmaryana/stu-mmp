function login()
{
    user = $('#username').val().trim();
    pass = $('#password').val().trim();
    
    if(user == '') {
        show_msg_dlg('Exception', 'Username is required !');
        setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
    }
    else if(pass == '') {
        show_msg_dlg('Exception', 'Password is required !');
        setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
    }
    else {
        $.post(base_url+'api/login/authenticate', $("#form_login").serialize(),function(result){
            if (result.success){
                show_msg_dlg('Success', result.msg);
                setTimeout(function(){ 
                    $('#frmDlg').modal('toggle');
                    window.location.href = base_url + 'home'; 
                }, 2000);
            } else {
                show_msg_dlg('Exception', result.msg);
                setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
            }
        },'json');
    }
}

$(document).ready(function(){
    $('#username').keypress(function(e){ if(e.which == 13) login(); });
    $('#password').keypress(function(e){ if(e.which == 13) login(); });
});