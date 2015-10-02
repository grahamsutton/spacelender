$(document).ready(function() {

	//======================================
	// Stripe Config
	//======================================

	Stripe.setPublishableKey("pk_test_clq5kjvbP5jlx43GycNL6sRG");

	$("#new-card-form").on("submit", function(e) {
		var form = $(this);

		form.find("#new-card-btn").attr("disabled", "disabled"); 

		Stripe.card.createToken({
			number: $(".card-number").val(),
			cvc: $(".card-cvc").val(),
			exp_month: $(".card-exp-month").val(),
			exp_year: $(".card-exp-year").val(),
			name: $(".card-name").val()
		}, stripeResponseHandler);

		return false;
	});

	function stripeResponseHandler(status, response) {
		var form = $("#new-card-form");

		if (response.error) {
			form.find(".payment-errors").text(response.error.message);
			form.find("#new-card-btn").removeAttr("disabled");
		} else {
			var token = response.id;

			console.log("Works here too");

			// Add stripe token
			//form.find("#stripeToken").attr("value", token);
      		form.append($("<input type='hidden' name='stripeToken' />").val(token));

			// Send
			form.get(0).submit();
		}
	}
});
