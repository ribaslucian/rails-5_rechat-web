// criando filtro de mascara generica {{string | mask: '99.99'}}
app.filter('mask', ['MaskService', function (MaskService) {
    return function (text, mask) {
        var maskService = MaskService.create();
        maskService.generateRegex({mask: mask});
        return maskService.getViewValue(text).withDivisors();
    };
}]);