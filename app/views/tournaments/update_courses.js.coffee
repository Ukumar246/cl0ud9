$("#golf_course_select").empty();
$("#golf_course_select").append("<%= escape_javascript(render(:partial => @golf_course)) %>");