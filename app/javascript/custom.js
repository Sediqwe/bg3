$(document).on('turbo:load', function() {

    $('#upload_lang').show();
  



    $('td[id^="line_"]').on('click', function() {
      var id = $(this).attr("id").replace("line_", "");
      var translateId = '#translate_' + id;
    
      // Először ellenőrizzük, hogy a translate elem látható-e
      if ($(translateId).is(":visible")) {
        // Ha látható, akkor elrejtjük
       
      } else {
        // Ha nem látható, akkor elrejtjük minden translate elemet és megjelenítjük a kiválasztottat
     
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
    $("#megjelolt").on("click", '[id^="remover_"]', function() {
      $(this).hide();
    });
    $("#query").on("input", function() {
      var query = $(this).val();
      if (query.length > 4) {
        $.ajax({
          url: "/search",
          method: "GET",
          data: { query: query },
          dataType: "json",
          success: function(data) {
            $("#results").empty();
            data.forEach(function(item) {
              var id = item.id;
              var button = $("<button>")
                .attr("id", item.id)
                .text(item.content)
                .addClass("btn btn-primary")
                .click(function() {
                  $.ajax({
                    url: "/imagelineadd",
                    method: "GET",
                    data: { line_id: item.id },
                    success: function(data) {
                      var adatok = $("#megjelolt").html();
                      var uj_link =
                        '<a class="btn btn-secondary mt-3" id="remover_' +
                        data +
                        '" rel="nofollow" data-method="delete" href="/imagelineremove?line=' +
                        data +
                        '">' +
                        item.content +
                        "</a>";
                      $("#megjelolt").html(adatok + "<br>" + uj_link);
                    },
                  });
                });
              $("#results").append(button);
            });
          },
        });
      }
    });
    
    $("#line_oldcontent").on("input", function() {
      var id = $(this).attr("data");
      
      var input_text1 = $("#line_content").html(); // Az első elem tartalma
      var input_text2 = $("#line_oldcontent").val(); // A második elem tartalma
    // Regex minta a < > jelek közötti tartalom kinyeréséhez
    var tag_pattern = /<.*?>(.*?)<\/.*?>/;
    alert(input_text2 + "\n" +   input_text1)
    // Kinyerjük a < > jelek közötti tartalmat az első szövegből
    var match1 = input_text1.match(tag_pattern);
    var content1 = match1 ? match1[1] : "";

    // Kinyerjük a < > jelek közötti tartalmat a második szövegből
    var match2 = input_text2.match(tag_pattern);
    var content2 = match2 ? match2[1] : "";

    // Ellenőrizzük, hogy a két tartalom egyezik-e
    if (content1 === content2) {
        $("#line_oldcontent").css("border", "1px solid green");

        console.log("A tartalmak egyeznek: " + content1);
    } else {
        $("#line_oldcontent").css("border", "1px solid red");
    }
    
  });
}); 