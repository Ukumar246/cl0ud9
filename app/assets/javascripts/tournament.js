$(document).ready(function() {
	$('#search_course').click(function() {
		$('#golf_search').toggle('show');
		$('#golf_enter').toggle(false);
	});
	
	$('#enter_course').click(function() {
		$('#golf_enter').toggle('slow');
		$('#golf_search').toggle(false);
	});
	
	$('#reg_date_button').click(function() {
		$('#reg_date').toggle('slow');
	});
	
	$('#host_button').click(function() {
		$('#add_host').toggle('slow');
	});
	
	$("#new_tournament").validate({
		debug: false,
		
		rules: {
			"tournament[name]": {required: true},
			"tournament[shortDesc]":{required:true},
			"tournament[tournamentDate]":{required:true},
			"tournament[numGuests]":{required:true}
			//"tournament[registerEnd]": { greaterThan: "tournament[registerStart]"}	
			
		},
		messages: {
		}		
	});
	
	$('#search_button').click(function() {
		$.ajax({
			url: '/tournaments/update_courses',
			data: { search_value: $('#search_value').val() },
			dataType: 'script'
		})
	});
	
	/*$('host_search').clock(function() {
		$.ajax({
			url: '/tournaments/update_hosts',
			data: { search_host_value: $('#search_host_value').val() },
			dataType: 'script'
		})
	});*/
});

