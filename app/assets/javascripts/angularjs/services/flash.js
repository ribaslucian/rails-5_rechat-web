app.service('$flash', function (toastr) {

    /**
     * Lança uma mensagem de sucesso.
     *
     * @param {string} message
     * @param {string} title
     * @returns {void}
     */
    this.success = function(message, title) {
        toastr.success(message, title);
    }

    /**
     * Lança uma mensagem de informacao.
     *
     * @param {string} message
     * @param {string} title
     * @returns {void}
     */
    this.info = function(message, title) {
        toastr.info(message, title);
    }

    /**
     * Lança uma mensagem de atencao.
     *
     * @param {string} message
     * @param {string} title
     * @returns {void}
     */
    this.warning = function(message, title) {
        toastr.warning(message, title);
    }

    /**
     * Lança uma mensagem de error.
     *
     * @param {string} message
     * @param {string} title
     * @returns {void}
     */
    this.error = function(message, title) {
        toastr.error(message, title);
    }

    /**
     * Lanca um mensagem flash genérica [added]
     * baseando-se no arquivo de localizacao locales/flash.
     *
     * @returns {void}
     */
    this.added = function () {
        toastr[
                LOCALE_FLASH['added'][0]
        ](LOCALE_FLASH['added'][1]);
    }

    /**
     * Lanca um mensagem flash genérica [edited]
     * baseando-se no arquivo de localizacao locales/flash.
     *
     * @returns {void}
     */
    this.edited = function () {
        toastr[
                LOCALE_FLASH['edited'][0]
        ](LOCALE_FLASH['edited'][1]);
    }

    /**
     * Lanca um mensagem flash genérica [deleted]
     * baseando-se no arquivo de localizacao locales/flash.
     *
     * @returns {void}
     */
    this.deleted = function () {
        toastr[
                LOCALE_FLASH['deleted'][0]
        ](LOCALE_FLASH['deleted'][1]);
    }

    /**
     * Lanca um mensagem flash genérica [form_error]
     * baseando-se no arquivo de localizacao locales/flash.
     *
     * @returns {void}
     */
    this.formError = function () {
        toastr[
                LOCALE_FLASH['form_error'][0]
        ](LOCALE_FLASH['form_error'][1]);
    }

    /**
     * Lanca um mensagem flash genérica [form_error]
     * baseando-se no arquivo de localizacao locales/flash.
     *
     * @returns {void}
     */
    this.genericError = function () {
        toastr[
                LOCALE_FLASH['error'][0]
        ](LOCALE_FLASH['error'][2], LOCALE_FLASH['error'][1]);
    }

});
