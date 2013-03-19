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

function parseUrl( url ) {
    var a = document.createElement('a');
    a.href = url;
    return a;
};

function getDomain( url ) {
    hostname = parseUrl(link).hostname
    splitHostname = hostname.split('.');
    if (splitHostname.length > 2) {
        domain = splitHostname[1] // Most likely the domain
    } else {
        domain = splitHostname[0]
    };
    return domain;
};

function trackLinks() {
    // Setup outbound link tracking and push events to GA based on link attribute linkTracking
    $('a').each(function () {
        link = $(this).attr('href');
        linkTracking = $(this).attr('linkTracking');
        if (linkTracking) {
            category = linkTracking.toLowerCase()
            action = getDomain(link);
            label = link;
            $(this).attr('target', '_blank').attr('onClick', '_gaq.push(["_link", "' + link + '"]);' +
                                                             'recordOutboundLink(this, "' + category + '", "' + action + '", "' + label + '"); return false;');
        };
    });
};

$(document).ready(function() {

    // Show any notifications
    $('.notice, .alert, .success, .info').delay(400).slideDown(300);
    $('.close').live('click', function() {
        $(this).parent().slideUp(300)
    });

    // Set menu items to active when you're on that page.
    var url = window.location;
    $('ul.nav a[href="'+ url +'"]').parents('.dropdown').addClass('active');

    // Will also work for relative and absolute hrefs
    $('ul.nav a').filter(function() {
        return this.href == url;
    }).parents('.dropdown').addClass('active');

    trackLinks();
});