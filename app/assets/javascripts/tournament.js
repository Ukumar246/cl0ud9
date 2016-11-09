$(document).ready(function() {
	$('#search_course').click(function() {
		$('#golf_search').toggle('show');
		$('#golf_enter').toggle(false);
	});
	
	$('#enter_course').click(function() {
		$('#golf_enter').toggle('slow');
		$('#golf_search').toggle(false);
	
	});
	
	$("#new_tournament").validate({
		debug: false,
		
		rules: {
			"tournament[name]": {required: true},
			"tournament[shortDesc]":{required:true},
			"tournament[tournamentDate]":{required:true}
			
			
		},
		messages: {
			"tournament[name]": "Enter a name for the tournament",
			"tournament[shortDesc]": "Enter a description for the tournament"
		}		
	});
	
	$('#search_button').click(function() {
		$.ajax({
			url: '/tournaments/update_courses',
			data: { search_value: $('#search_value').val() },
			dataType: 'script'
		})
		
	});
});

