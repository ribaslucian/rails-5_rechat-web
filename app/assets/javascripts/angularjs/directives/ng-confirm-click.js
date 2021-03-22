// directives/ng-confirm-click.js
app.directive('ngConfirmClick', [
        function() {
            return {
                link: function (scope, element, attr) {
                    var msg = attr.ngConfirmClick || 'Tem certeza?';
                    var clickAction = attr.confirmedClick;
                    element.bind('click', function (event) {
                        if (window.confirm(msg)) {
                            scope.$eval(clickAction)
                        }
                    });
                }
            };
    }])
