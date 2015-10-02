$(document).ready(function() {
	$(".messages-tab-link").on("click", function(e) {
		e.preventDefault();

		var id = $(this).attr("href");

		$(".messages-tab-link").parent().removeClass("active");
		$(this).parent().removeClass("active");

		$(".messages-tab-link").removeClass("active");
		$(this).removeClass("active");

		$(".messages-tab").removeClass("active");
		$(id).addClass("active");
	});

	$(".messages-tab.active table tbody tr").on("click", "td:not(:first-child)", function() {
		$("#show-message-modal").modal('show');
		$(this).parent().addClass("message-read");
		$.ajax({
			type: "GET",
			url: $(this).parent().data("href")
		});
	});

	$(".select-all-messages").on("change", function() {
		if ($(this).is(":checked")) {
			$(".message-checkbox").prop("checked", true);
		} else { 
			$(".message-checkbox").prop("checked", false);
		}
	});
});