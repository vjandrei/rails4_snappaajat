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
//= require_tree .
//= require maj-text-counter
//= require jquery.tokeninput
//= require profiles
//= require jquery.jcrop
//= require papercrop


// Detect file input support
var isFileInputSupported = (function () {
  // Handle devices which falsely report support
  if (navigator.userAgent.match(/(Android (1.0|1.1|1.5|1.6|2.0|2.1))|(Windows Phone (OS 7|8.0))|(XBLWP)|(ZuneWP)|(w(eb)?OSBrowser)|(webOS)|(Kindle\/(1.0|2.0|2.5|3.0))/)) {
    return false;
  }
  // Create test element
  var el = document.createElement("input");
  el.type = "file";
  return !el.disabled;
})();

// Add 'fileinput' class to html element if supported
if (isFileInputSupported) {
  document.documentElement.className += " fileinput";
}

$( document ).ready(function() {
	
	$('#profile_description').majTextCounter({
		carLimit: 160,
		words: "",
		letters: "kirjainta",
		separator: "",
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

});