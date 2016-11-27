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
//= require_tree .
//= require bootstrap-sprockets
//= require moment 
//= require fullcalendar




// $(document).on('change',function() {
  // $("#reservation_check_out_date").change(function() {
  //   var checkIn = $("#reservation_check_in_date").val();
  //   var checkOut = $("#reservation_check_out_date").val();
  //   var price = parseFloat($("#price").text().replace("RM", ""));
  //   if (checkOut > checkIn) {
  //     var numNights = (Date.parse(checkOut) - Date.parse(checkIn))/(1000*60*60*24);
  //     $("#num-nights").text(numNights);
  //     $("#reservation_total_cost").val((price*numNights).toFixed(2));
  //   }
  // });

  // $("#reservation_check_in_date").change(function() {
  //   var checkIn = $("#reservation_check_in_date").val();
  //   var checkOut = $("#reservation_check_out_date").val();
  //   var price = parseFloat($("#price").text().replace("RM", ""));
  //   if (checkOut > checkIn) {
  //     var numNights = (Date.parse(checkOut) - Date.parse(checkIn))/(1000*60*60*24);
  //     $("#num-nights").text(numNights);
  //     $("#reservation_total_cost").val((price*numNights).toFixed(2));
  //   }
  // });

  
// });

$(document).on("turbolinks:load", function() {
    $("#reservation_check_out_date").change(function() {
    var checkIn = $("#reservation_check_in_date").val();
    var checkOut = $("#reservation_check_out_date").val();
    var price = parseFloat($("#price").text().replace("RM", ""));
    if (checkOut > checkIn) {
      var numNights = (Date.parse(checkOut) - Date.parse(checkIn))/(1000*60*60*24);
      $("#num-nights").text(numNights);
      $("#reservation_total_cost").val((price*numNights).toFixed(2));
    }
  });

  $("#reservation_check_in_date").change(function() {
    var checkIn = $("#reservation_check_in_date").val();
    var checkOut = $("#reservation_check_out_date").val();
    var price = parseFloat($("#price").text().replace("RM", ""));
    if (checkOut > checkIn) {
      var numNights = (Date.parse(checkOut) - Date.parse(checkIn))/(1000*60*60*24);
      $("#num-nights").text(numNights);
      $("#reservation_total_cost").val((price*numNights).toFixed(2));
    }
  });

  $('#calendar').fullCalendar({
    events: window.location.pathname + '.json'
  });
});