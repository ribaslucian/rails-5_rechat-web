// criando diretiva que busca o cep e escreve seu endereco no escopo
app.directive('address', function ($http) {
    return {
        // propriedades da diretiva
        templateUrl: 'app/views/templates/address.html',
        scope: {
            zipcode: '@',
            number: '@'
        },
        link: function (scope, element, attrs) {
            var api_url = API_ZIPCODE_URL.replace(':raw_zipcode', only_numbers(attrs.zipcode));

            $http.get(api_url).then(function (data) {
                data = data.data;

                if (!('erro' in data)) {
                    scope.neighborhood = data.bairro;
                    scope.street = data.logradouro;
                    scope.city = data.localidade;
                    scope.state = data.uf;
                } else {
                    scope.error = true;
                }
            }, function (data) {
                scope.error = true;
            });
        }
    }
});