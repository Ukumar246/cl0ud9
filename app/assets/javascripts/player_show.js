/**
 * Created by warefhaque on 11/14/16.
 */
     $(document).ready(function () {
       $(".nav-item a").on("click",function () {
         console.log("CLICKED THE NAV ITEM");
         $(".nav-item a").each(function (i,e) {
           $(e).removeClass('active');
         });
         $(this).addClass('active');
         return false;
       });
     });
