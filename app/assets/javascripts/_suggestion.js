$(document).ready(function(){
    $('.carousel').carousel({
      interval: false
    })
    $('#input-3').rating({displayOnly: true, step: 0.5});
  });

Suggestion = {
    setup: function() {
        $(document).on('click', '#next', Suggestion.getDialog)
    },

    getDialog: function() {
        $.ajax({type: 'GET',
            url: $(this).attr('href'),
            timeout: 5000,
            success: Suggestion.showDialog,
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
$(Suggestion.setup);