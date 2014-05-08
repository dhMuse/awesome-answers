$(document).ready(function(){
	$(".answers").on('click', ".answerkiller", function(){
		$(this).parents('.well').fadeOut('slow');
	});
});