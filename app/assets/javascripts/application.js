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
//= require bootstrap-sprockets
//= require turbolinks
//= require maj-text-counter
//= require jquery.tokeninput
//= require profiles
//= require jcrop.js
//= require jquery.jcrop.js
//= require select2
//= require select2_locale_fi
//= require_self
//= require rails.validations
//= require filterrific/filterrific-jquery

$( document ).ready(function() {
	
	$('#profile_description').majTextCounter({
		carLimit: 160,
		words: "Sanaa ",
		letters: " merkkiä",
		separator: "ja ",
		maximum: " Maksimimäärä : ",
	});
	
	$('#profile_image').on('change', function(event) {
	    var files = event.target.files;
	    var image = files[0]
	    var reader = new FileReader();
	    reader.onload = function(file) {
	      var img = new Image();
	      console.log(file);
	      img.src = file.target.result;
	      $('#profile_image_target').html(img);
	      $('#profile_image_exists').remove();
	    }
	    reader.readAsDataURL(image);
	    console.log(files);
	});
    
    
    $(".profilesSnapCodeScan").on("click", function () {  
        $(this).parent().find(".profilesSnapCode").slideToggle(function() {
	       $(this).addClass('animated bounceInDown').css('top', '0px');
        });
    });
    
	this.jcrop.init({ file_input_id: 'profile_image' });
	
	$( "#profile_location_id" ).select2({
	    theme: "classic"
	});
	

});