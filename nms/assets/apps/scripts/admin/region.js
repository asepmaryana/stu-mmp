function edit_region(id)
{
    $('#form_region').resetForm();
    if(id != '') {
        $.get(base_url+'api/subnet/read/'+id, {}, function(result){
            if (result.success){
                var row = result.data;
                $('#id').val(row.id);
                $('#name').val(row.name);
                $('#description').val(row.description == 'null' ? '' : row.description);
                $('#frmRegion').modal('show');
            } else {
                show_dlg_msg('Exception', result.msg);
                setTimeout(function(){ $('#frmDlg').modal('toggle'); }, 2000);
            }
        },'json');
    }
    else $('#frmRegion').modal('show');
}

function save_region()
{
    data = $('#form_region').serialize();
    url  = ($('#id').val() == '') ? base_url+'api/subnet/add' : base_url+'api/subnet/update';
    $('#frmRegion').modal('hide');
    request_post(url, data, function(){ show_region(''); });
}

function delete_region(id)
{
    bootbox.confirm("Are you sure ?", function(o){ if(o) request_post(base_url+'api/subnet/delete/'+id); });
}

function show_region(doc)
{
    if(doc == 'xls') window.open(base_url+'api/subnet/get_region/'+doc);
    else 
    {
        $.ajax({
            url: base_url+'api/subnet/get_region/'+doc,
            dataType: 'json',
            cache: false,
            success: function(msg){
                var table = $('#region_table').DataTable();
                table.clear().draw();                            
                for(var i=0; i<msg.rows.length; i++)
                {
                    if(msg.rows[i].name == 'null') msg.rows[i].name = '';
                    if(msg.rows[i].description == 'null') msg.rows[i].description = '';
                    
                    table.row.add([
                        msg.rows[i].name, 
                        msg.rows[i].description, 
                        '<div class="btn-group"><button type="button" class="btn blue btn-outline" onclick="edit_region(\''+msg.rows[i].id+'\')"><i class="icon-pencil"></i> Edit</button> <button type="button" class="btn red btn-outline" onclick="delete_region(\''+msg.rows[i].id+'\')"><i class="icon-trash"></i> Delete</button></div>'
                    ]).draw();
                }
            }
        });
    }
}

$(document).ready(function(){ 
    $('#region_table').dataTable({"paging": false});
    show_region('');
});