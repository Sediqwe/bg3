$(document).on('turbo:load', function() {

    $('#upload_lang').show();
    $('tr[id^="translate_"]').hide();



    $('td[id^="line_"]').on('click', function() {
      var id = $(this).attr("id").replace("line_", "");
      var translateId = '#translate_' + id;
    
      // Először ellenőrizzük, hogy a translate elem látható-e
      if ($(translateId).is(":visible")) {
        // Ha látható, akkor elrejtjük
        $(translateId).hide();
      } else {
        // Ha nem látható, akkor elrejtjük minden translate elemet és megjelenítjük a kiválasztottat
        $('tr[id^="translate_"]').hide();
        $(translateId).show().removeAttr("hidden");
      }
    });
    
    $('#upload_uploadtype').on('change', function(){
      
        var selectedValue = $(this).val();
        if (selectedValue > 1){
          $("#upload_lang").hide();
        }
        else{
          $("#upload_lang").show();
        }
        
    
    }); 
    
}); 