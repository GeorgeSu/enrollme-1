$(document).ready(function() {
  
  function searchUsers(search, search_cell) {
        $('#individuals tbody tr').each(function(){
            $current_row = $(this)
            
            var current_search_cell;
            
            $(this).find('td:nth-child(' + search_cell + ')').each(function() {
                current_search_cell = $(this)
            });
            
            
            $current_row.show().filter(function() {
                //console.log($(current_search_cell).find('a').text())
                var current_search_text = $(current_search_cell).find('a').text().replace(/\s+/g, ' ');
                return !(search.test(current_search_text));
            }).hide();
        });
    }
    
        $('#user_search').keyup(function() {
        var search = '^(?=.*\\b' + $.trim($(this).val()).split(/\s+/).join('\\b)(?=.*\\b') + ').*$';
        var reg = RegExp(search, 'i');
        searchUsers(reg, 1)
    });
    
})