/**
 * Created by warefhaque on 11/14/16.
 */
 $(document).ready(function () {
     $('#no-data').hide();
     var firstTab = $('.nav-item a').first();
     firstTab.addClass('active');
     var id = firstTab.attr('id');
     console.log('id: '+id);
     if (id==undefined){
        $('.card').hide();
        $('#no-data').show();
     }
     switchTabs(id);

     $(".nav-item a").on("click",function () {
         switchTabs($(this).attr('id'));
         return false;
   });

     function switchTabs(nav_id){
         $('.card-block').hide()
         $(".nav-item a").each(function (i,e) {
             $(e).removeClass('active');
         });
         var tab = $("#"+nav_id);
         tab.addClass('active');

         var split_id = !!nav_id ? nav_id.split("-"):"";
         var card_id = 'card-'+split_id[1];

         $('#'+card_id).show();
     }
 });
