$(document).ready(function() {
	$(".view-more-link").on("click", function(e) {
		e.preventDefault();
		$(this).parent().parent().find(".view-more").slideToggle();
	});
});