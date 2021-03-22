/**
 * Insere o rodape da pagina.
 */
app.directive('pageFooter', function () {
    return {
        replace: true,
        templateUrl: function () {
            return 'app/views/templates/footer.html';
        }
    }
});

/**
 * Insere os campos dentro de um formulario sem efetuar a quebra de escopo.
 * Utilizar a tag <form-fields view="hierarchy/controller" />
 */
app.directive('formFields', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/' + attrs.view + '/partial/form_fields.html';
        }
    }
});

/**
 * Inclui a paginacao. Semelhante a diretiva {formFields}.
 */
app.directive('paginate', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/' + attrs.view + '/partial/paginate.html';
        }
    }
});

app.directive('partial', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/' + attrs.view + '.html';
        }
    }
});

/**
 * Inclui os modals de visualizacao. Semelhante a diretiva {formFields}.
 */
app.directive('modalsShow', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/' + attrs.view + '/partial/modals_show.html';
        }
    }
});

/**
 * Inclui os modals de visualizacao. Semelhante a diretiva {formFields}.
 */
app.directive('modalShow', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/' + attrs.view + '/partial/modal_show.html';
        }
    }
});

/**
 * Inclui um template. Semelhante a diretiva {formFields}.
 */
app.directive('template', function () {
    return {
        replace: true,
        templateUrl: function (element, attrs) {
            return 'app/views/templates/' + attrs.view + '.html';
        }
    }
});