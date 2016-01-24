// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tether
//= require bootstrap-sprockets
//= require jcrop
//= require select2
//= require select2_locale_fi
//= require rails.validations
//= require filterrific/filterrific-jquery
//= require maj-text-counter
//= require sharer.min
//= require jquery.prettySocial.min
//= require fancySelect
//= require_tree .

$(function() {
	$('#profile_description').majTextCounter({
		carLimit: 160,
		words: "Sanaa ",
		letters: " merkkiä",
		separator: "ja ",
		maximum: " Maksimimäärä : ",
	});
	$(".profilesTagsAll").on("click", function () {  
        $(this).parent().toggleClass('active');
    });
    $(".profilesSnapCodeScan").on("click", function () {  
        $(this).parent().find(".profilesSnapCode").slideToggle(function() {
	       $(this).addClass('animated bounceInDown').css('top', '0px');
        });
    });
    $( "#profile_location_id" ).select2({
	    theme: "classic"
	});

	//$('.collapse').collapse()
	
	autoPlayYouTubeModal();

	//FUNCTION TO GET AND AUTO PLAY YOUTUBE VIDEO FROM DATATAG
	function autoPlayYouTubeModal() {
	  var trigger = $("body").find('[data-toggle="modal"]');
	  trigger.click(function () {
	      var theModal = $(this).data("target"),
	          videoSRC = $(this).attr("data-theVideo"),
	          videoSRCauto = videoSRC + "?autoplay=1";
	      $(theModal + ' iframe').attr('src', videoSRCauto);
	      $(theModal + ' button.close').click(function () {
	          $(theModal + ' iframe').attr('src', videoSRC);
	      });
	      $('.modal').click(function () {
	          $(theModal + ' iframe').attr('src', videoSRC);
	      });
	  });
	}
	
	$('.prettySocial').prettySocial();
	
	$('#filterrific_sorted_by, #filterrific_with_location_id').fancySelect();
	
});