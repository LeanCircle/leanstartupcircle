// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


Notifications = {
  show_any : function() {
    $('.notice, .alert, .success, .info').delay(400).slideDown(300);
  },
  handle_close : function() {
    $('.close').live('click', function() {
        $(this).parent().slideUp(300)
    });
  }
}

$(document).ready(function() {
    $(function () {
        Notifications.show_any();
    });
    $(function () {
        Notifications.handle_close();
    });

    // Will only work if string in href matches with location
    var url = window.location;
    $('ul.nav a[href="'+ url +'"]').parents('.dropdown').addClass('active');

    // Will also work for relative and absolute hrefs
    $('ul.nav a').filter(function() {
        return this.href == url;
    }).parents('.dropdown').addClass('active');
});

