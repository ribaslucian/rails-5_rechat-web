app.service('$error', function ($app) {

    /**
     * Set um error nas flash messages e redireciona
     * para a rota de paginacao da entidades atual.
     *
     * @returns {void}
     */
    this.returnPaginate = function () {
        this.error();
        $app.route.redirect('paginate');
    }

    /**
     * Set um error nas flash messages e redireciona
     * para a rota raiz do usuario atual.
     *
     * @returns {void}
     */
    this.returnUser = function () {
        this.error();
        $app.route.redirect('user');
    }

    /**
     * Set um error nas flash messages e redireciona
     * para a rota raiz do usuario atual.
     *
     * @returns {void}
     */
    this.error = function () {
        $app.flash.genericError();
    }

    this.api = function () {
//        $app.session.uncookie();
        // $app.flash.genericError();
        $app.flash.error('Error 1', 'Error 1');
//        $app.error.returnUser();
    }

});
