app.directive('messageWarning', function () {
    return {
        templateUrl: 'app/views/templates/messages/warning.html',
        transclude: true,
    }
});

app.directive('messageError', function () {
    return {
        templateUrl: 'app/views/templates/messages/error.html',
        transclude: true,
    }
});


app.directive('messageInfo', function () {
    return {
        templateUrl: 'app/views/templates/messages/info.html',
        transclude: true,
    }
});
