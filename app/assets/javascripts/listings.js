$(document).ready(function() {
	Stripe.setPublishableKey("pk_test_uBxr1leBtJ52vOzNYKH458LL");


	$("#new-reservation-form").on("submit", function(e) {
		var form = $(this);

		form.find("#place-order").attr("disabled", "disabled");

		Stripe.card.createToken(form, stripeResponseHandler);

		return false;
	});

	function stripeResponseHandler(status, response) {
		var form = $("#new-reservation-form");

		if (response.error) {
			form.find(".payment-errors").text(response.error.message);
			form.find("#place-order").removeAttr("disabled");
		} else {
			var token = response.id;

			// Get checked rate
			$("#date-range-hidden").attr("value", $("input[name='reservation[rate_attributes][amount]']:checked").data("time-range"));

			// Add stripe token
			form.find("#stripeToken").attr("value", token);

			// Send
			form.get(0).submit();
		}
	}
});