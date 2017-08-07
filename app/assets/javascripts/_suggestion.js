suggestion = {
    setup: function() {
        $(document).on('click', '#next', Request.getDialog)
    },

    getDialog: function() {
        $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: Request.showDialog,
            error: function(jqXHR, textStatus, errorThrown) { alert(jqXHR.textStatus); }
        });
        return(false);
    },

    showDialog: function(data) {
        $('#suggestion').
        html(data);

        return(false);  // prevent default link action
    },

}
$(Request.setup);