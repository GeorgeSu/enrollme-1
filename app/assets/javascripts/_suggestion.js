Suggestion = {
    setup: function() {
        $('#prev,#next').click(function (e) {
            e.preventDefault()
            if (this.id == 'prev') {
                Suggestion.getPrev();
            }
            else if (this.id == 'next') {
                Suggestion.getNext();
            }
        })
    },

    getNext: function() {
        $.ajax({type: 'GET',
            url: "next_rec",
            timeout: 5000,
            success: Suggestion.showDialog,
            error: function(jqXHR, textStatus, errorThrown) { alert(jqXHR.textStatus); }
        });
        return(false);
    },

    getPrev: function() {
        $.ajax({type: 'GET',
            url: "prev_rec",
            timeout: 5000,
            success: Suggestion.showDialog,
            error: function(jqXHR, textStatus, errorThrown) { alert(jqXHR.textStatus); }
        });
        return(false);
    },

    showDialog: function(data) {
        $('.item').
        html(data);
        $('#input-3').rating({displayOnly: true});
        return(true);  // resume default link action
    }
}
$(Suggestion.setup);


$(document).ready(function(){
    $('.carousel').carousel({
      interval: false
    })
    $('#input-3').rating({displayOnly: true, step: 0.5});
  });
