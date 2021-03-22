app.service('$api', function ($app) {

    /**
     * $api.process
     */
    this.process = function (params, callable_success) {
        loading();
        l('$api process');
        

        $app.$http({
            url: API_URL,
            dataType: 'json',
            method: 'POST',
            data: {
                request: {
                  actions: params
                }
            }
        }).then(function (data) {
            l(data.data);
            callable_success(data.data);

            loaded();
        }, function (data) {
            l('process error');
            l(data);

            loaded();
            $app.flash.error('API Error 1', 'API Error 1');
            // $app.$entity.logout();
        });
    }

    /**
     * $api.sync
     */
    this.sync = function (params, callable_success) {
        loading();
        l('$api sync');

        $.ajax({
            url: API_URL,
            dataType: 'json',
            method: 'post',
            async: false,
            data: {
                action: 'zyMvMvYaSLAq8qZR',
                options: params
            },
            success: function (data) {
                l(data);
                callable_success(data);
            },
            error: function (data) {
                l('sync error');
                l(data);

                $app.flash.error('API Error 2', 'API Error 2');
                $app.$entity.nnVddJ5x7btqPizX();
            }
        });

        loaded();
    }

});
