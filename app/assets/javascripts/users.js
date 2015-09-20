$(document).ready(function() {
	//Client-side validation for Sign Up form
	$("#new_user").validate({
		rules: {
			"user[first_name]": {
				required: true
			},
			"user[last_name]": {
				required: true
			},
			"user[email]": {
				required: true,
				email: true
			},
			"user[email_confirmation]": {
				required: true,
				email: true,
				equalTo: "#user_email"
			},
			"user[password]": {
				required: true,
				minlength: 8,
				maxlength: 20
			},
			"user[password_confirmation]": {
				required: true,
				equalTo: "#user_password"
			}
		},

		// Validation Messages
		messages: {
			"user[first_name]": {
				required: "We need your First Name!"
			},
			"user[last_name]": {
				required: "We also need your Last Name!"
			},
			"user[email]": {
				required: "Don't forget your email! We use it to send you requests, confirmations, reservations, etc.",
				email: "Make sure your email follows this format: johndoe@example.com"
			},
			"user[email_confirmation]": {
				required: "Please provide your email again so we know you got it right!",
				email: "Make sure your email follows this format: johndoe@example.com",
				equalTo: "Your email and email confirmation don't match!"
			},
			"user[password]": {
				required: "You're going to need a password.",
				minlength: "C'mon! You gotta get at least 8 characters in there!",
				maxlength: "Whoa, slow down! That's a little much to remember. Try something a little more concise."
			},
			"user[password_confirmation]": {
				required: "Just type in your password again so we can make sure you got it right!",
				equalTo: "Your password and password confirmation don't match!"
			}
		},

		//Create error messages on keyup and focusout
        onkeyup: function(element) {
        	this.element(element);

        	if ($(element).hasClass("error")) {
        		$(element).addClass("has-error")
        	} else {
        		$(element).next(".glyphicon.error").removeClass("active");
        	}
        },
        onfocusout: function(element) { this.element(element); },


        //Form submit handler
        submitHandler: function(form) {
            form.submit();
        }
	});


	// Such WOW
    var wow = new WOW(
      {
        boxClass:     'wow',      // default
        animateClass: 'animated', // default
        offset:       0,          // default
        mobile:       true,       // default
        live:         true        // default
      }
    );
    wow.init();

    // Gmaps AutoComplete for Search Bar
    // jQuery(function() {
    //   var completer;
    
    //   completer = new GmapsCompleter({
    //     inputField: '#city',
    //     errorField: '#gmaps-error'
    //   });
    
    //   completer.autoCompleteInit({
    //     country: "us"
    //   });
    // });
});