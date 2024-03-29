// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require dropzone
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require autonumeric
//= require owl.carousel
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require toastr
//= require typed
//= require underscore
//= require gmaps/google
//= require_tree .

$(document).ready(function() {
	$(".account-ctrl-modal-link").on("click", function(e) {
		e.preventDefault();

		var id = $(this).attr("href");
		var cleanId = id.replace("-modal-tab", "");

		$(".account-ctrl-modal-link").parent().removeClass("active");
		$(this).parent().addClass("active");

		$(".account-ctrl-modal-tab").removeClass("active");
		$(id).addClass("active");

		// if (cleanId === "#register") {
		// 	$(".account-ctrl-modal-title").html("Register");
		// } else {
		// 	$(".account-ctrl-modal-title").html("Login");
		// }
	});
});