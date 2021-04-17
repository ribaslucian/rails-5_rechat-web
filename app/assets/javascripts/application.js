// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require functions
//= require activestorage
//
//= require angularjs/min
//= require angularjs/init/application
//= require angularjs/init/toastr
//= require angularjs/vendor/toastr/angular-toastr.tpls.min
//
//= require angularjs/services/basic
//= require angularjs/services/api
//= require angularjs/services/basic
//= require angularjs/services/entity
//= require angularjs/services/error
//= require angularjs/services/flash
//= require angularjs/directives/ng-confirm-click
//
//= require angularjs/controllers/global
// 
//= require_tree .
//
//= require cocoon
//= require semantic-ui

$(document).ready(function () {

    $('.dropdown').dropdown();
    certer_content_visible();
    $('.ws-loading-global').fadeOut();

    $('.checkbox').checkbox();

    if (typeof Android !== 'undefined') {
        Android.setUserId(getUserId());
    }

    if (getUserId() != 0) {
        if (typeof Android !== 'undefined') {
//            Android.login($('#rechat_session_cookie').attr('value'));
        }
    }
});

$(window).on('beforeunload', function () {
    $('.ws-loading-global').fadeIn();
});

function certer_content_visible() {
    var content_visible = $('#main-container').height();
    var body = $('body').height();

    if (content_visible < body) {
        $('#content-center').addClass('ws-center-absolute-y')
    }
}

function webview_logout() {
    return;
    if (typeof Android !== 'undefined') {
        Android.logout();
    }
}
