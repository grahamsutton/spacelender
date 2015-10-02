$(document).ready(function() {

	//======================================
	// Stripe Config
	//======================================

	Stripe.setPublishableKey("pk_test_clq5kjvbP5jlx43GycNL6sRG");

	$("#new-card-form").on("submit", function(e) {
		var form = $(this);

		console.log("this launched");

		form.find("#payment-pay-btn").attr("disabled", "disabled"); 

		Stripe.card.createToken({
			number: $(".payment-card-number").val(),
			cvc: $(".payment-cvc").val(),
			exp_month: $(".payment-exp-month").val(),
			exp_year: $(".payment-exp-year").val(),
			name: $(".payment-name").val()
		}, stripeResponseHandler);

		return false;
	});

	function stripeResponseHandler(status, response) {
		var form = $("#new-card-form");

		if (response.error) {
			form.find(".payment-errors").text(response.error.message);
			form.find("#payment-pay-btn").removeAttr("disabled");
		} else {
			var token = response.id;

			console.log("Works here too");

			// Add stripe token
			//form.find("#stripeToken").attr("value", token);
      		form.append($("<input type='hidden' name='stripeToken' />").val(token));
      		form.append($("<input type='hidden' name='card_last4' />").val($(".payment-card-number").val().slice(-4)));

			// Send
			form.get(0).submit();
		}
	}


	$(".payment-choice-tab-link").on("click", function(e) {
		e.preventDefault();

		var id = $(this).attr("href");

		$(".payment-choice-tab-link").removeClass("active");
		$(this).addClass("active");

		$(".payment-choice-tab-link").parent().removeClass("active");
		$(this).parent().addClass("active");

		$(".payment-choice-tab").removeClass("active");
		$(id).addClass("active");
	});
});
