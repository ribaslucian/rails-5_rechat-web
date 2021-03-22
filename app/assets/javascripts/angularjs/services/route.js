app.service('$$route', function ($app, $location, $routeParams, $route) {

    /**
     * Obtem-se a rota raiz do usuario atual.
     * /#!/:hierarchy
     * 
     * @returns {string}
     */
    this.user = function () {
        return '#!/' + $app.$entity.XXR8bgnbbubSbfUE();
    }

    /**
     * Obtem-se a rota raiz do usuario e controller atual.
     * /#!/:hierarchy/:controller
     * 
     * @returns {string}
     */
    this.controller = function () {
        var route = $location.path().split('/');
        return this.user() + '/' + route[2];
    }

    /**
     * Obtem-se a rota de paginacao do usuario atual 
     * referente ao controller atual.
     * 
     * @returns {string}
     */
    this.paginate = function () {
        return this.controller() + '/paginate';
    }

    /**
     * Obtem-se a rota de add do usuario atual 
     * referente ao controller atual.
     * 
     * @returns {string}
     */
    this.add = function () {
        return this.controller() + '/add';
    }

    /**
     * Obtem-se a rota de edit do usuario atual 
     * referente ao controller atual.
     * 
     * @returns {string}
     */
    this.edit = function (id) {
        return this.controller() + '/edit/' + id;
    }

    /**
     * Obtem-se a rota de edit do usuario atual 
     * referente ao controller atual.
     * 
     * @returns {string}
     */
    this.remove = function (id) {
        return this.controller() + '/remove/' + id;
    }

    /**
     * Obtem-se a rota para uma determinada ação.
     * 
     * @param {string} name
     * @returns {string}
     */
    this.action = function (action) {
        return this.controller() + action;
    }

    /**
     * Redirectiona para a rota referente ao parametro {name},
     * que corresponde ao nome de um dos metodos desse servico.
     * 
     * @param {string} name
     * @returns {void}
     */
    this.redirect = function (name) {
        var route = (this[name]()).replace('#!', '');
        $location.url(route);
    }

    /**
     * Redirectiona para a rota referente ao parametro {route}.
     * 
     * @param {string} route
     * @returns {void}
     */
    this.go = function (route) {
        route = route.replace('#!', '');
        
        return $location.url(route);
    }
    
    /**
     * Obtem-se os parametros da URL.
     * 
     * @returns {object}
     */
    this.params = function() {
        return $routeParams;
    }
    
    /**
     * Atualiza a pagina.
     * 
     * @returns {void}
     */
    this.reload = function() {
        $route.reload();
    }

});