/**
 * Created by warefhaque on 11/14/16.
 */
 $(document).ready(function () {


     $(".nav-item a").on("click",function () {

     $('.card-block').hide();
     var nav_id  = $(this).attr('id');

     console.log("CLICKED THE NAV ITEM");
     $(".nav-item a").each(function (i,e) {
         $(e).removeClass('active');
     });
     $(this).addClass('active');

     var split_id = nav_id.split("-");
     var card_id = 'card-'+split_id[1];

     $('#'+card_id).show();
     console.log(card_id);
     return false;
   });
 });
