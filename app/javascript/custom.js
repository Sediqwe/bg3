$(document).on('turbo:load', function() {
    $('#upload_lang').show();
    $('tr[id^="translate_"]').hide();
    $('td[id^="line_"]').on('click', function(){
      var id = $(this).attr("id").replace("line_","");

      $('#translate_' + id).show();
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