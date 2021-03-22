app.service('$entity', function ($app) {


    /**
     * Edita os dados da entidade :name
     * > $entity.edit(card_full, {status_acronym_id: 50053}, 'card')
     *
     * $entity.edit
     */
    this.wDQXs76gG9GaUAb2 = function (record, values, name, remove) {
        loading();

        var options = {};
        options[name] = {
            find: record.id,
            update_attributes: values
        };

        $app.$api.process(options, function (data) {
            if (data.error == false) {
                if (remove)
                    delete record;
                else
                    Object.assign(record, values);
            } else
                $app.flash.warning('Não foi possível completar o pedido, tente novamente mais tarde.');
        });
    }



    this._entity_edit = function () {
        //        loading();
        var entity = $app.data.entity;

        // preparando dados para edicao na API
        delete entity.$$hashKey;
        delete entity.balances;
        delete entity.cards;
        $.each(entity, function (field, value) {
            if (type(value) == 'object' || type(value) == 'array') {
                entity[field + '_attributes'] = value;
                delete entity[field];
            }
        });

        $app.$api.process({entity: {
                find: entity.id,
                update_attributes: entity
            }}, function (data) {
            if (data.error == false) {
                // preparando dados para apresentacao dos dados editados
                $.each(entity, function (field, value) {
                    if (field.indexOf('_attributes') != -1) {
                        entity[field.slice(0, -11)] = value;
                        delete entity[field];
                    }
                });

                $app.flash.success('Sucesso, dados editados!');
            } else
                $app.flash.warning('Não foi possível completar o pedido, tente novamente mais tarde.');
        });

    }


    /**
     * entity.edit
     */
    this.dh982y3kjd98f7 = function () {
        loading();
        var password_old = $('#password_old').val();

        if (password_old != '' && password_old != undefined) {
            var password_confirm = $('#password_new_confirm').val();

            if (password_confirm != '' && password_confirm != undefined) {

                return $app.$api.process({"Public::Entity": {password_check: {
                            entity_id: $app.$entity.id(),
                            password_sha1: sha1(password_old),
                            password_md5: md5(password_old)
                        }}}, function (data) {
                    if (data.error != false)
                        return $app.flash.warning('Senha atual não confere.');

                    $app.data.entity.user = {
                        id: data.user_id,
                        password_raw: '',
                        password_sha1: sha1(password_confirm),
                        password_md5: md5(password_confirm)
                    }

                    $app.$entity._entity_edit();
                });
            } else
                return $app.flash.warning('Para alterar a senha preencha corretamente os campos.');
        }

        $app.$entity._entity_edit();
    }

    /**
     * $entity.rescind employee
     */
    this.qg6ZCau1GyodMGJy = function (i) {
        loading();

        $app.$api.process({contract: {
                find_by: {
                    contracted_entity_id: $app.data.contracteds[(i = $app.data.contracteds.indexOf(i))].id,
                    contractor_entity_id: $app.$entity.id(),
                },
                'destroy!': ''
            }}, function (data) {
            if (data.error == false) {
                $app.flash.success('Funcionário desligado com sucesso.');
                $app.data.contracteds.splice(i, 1);
            } else
                $app.flash.warning('Não foi possível completar o pedido, tente novamente mais tarde.');
        });
    }


    //

    /**
     * $entity.protocol
     */
    this.pqgppVfOVUa7Ccm5 = function (protocol, form) {
        loading();

        protocol.requested_entity_id = 'b6417740-afb3-42db-bef0-ec0c0e9086ad';
        protocol.requester_entity_id = this.id();

        $app.$api.process({protocol: {'create!': protocol}}, function (data) {
            if (data.error == false) {
                $app.flash.success('Seu protocolo foi enviado com sucesso, aguarde nosso retorno.');
                $app.route.go('/online');
            }
        });
    }

    /**
     * $entity.release_recharge
     */
    this.NLjiWO50dnPlOwSY = function (recharge) {
        loading();

        // formatar recargas BRL para floats
        for (var i = 0; i < object_length(recharge.recharges); i++)
            recharge.recharges[i].value = brl_to_float(recharge.recharges[i].value);

        $app.$api.process({
            pending_transfer: {release_recharges: recharge}
        }, function (data) {
            if (data.error == 'message')
                $app.flash.warning(data.message);
            else if (data.error == 'error') {
                $app.flash.warning('Ops! Tente novamente mais tarde.');
                return $app.route.go('/online');
            }

            if (data.error == false) {
                $app.flash.success('Sucesso! Confira suas recargas no seu extrato.');
                return $app.route.go('/online');
            }
        });
    }

    /**
     * $entity.add_file_employees
     */
    this.t0me9jj7m5u4IsC5 = function () {
        loading();

        $app.$api.process({
            upload: {
                create: {
                    entity_id: $app.$entity.id(),
                    processed: false,
                    json: JSON.stringify($app.data.employees_add)
                }
            }
        }, function (data) {
            if (data.error == false) {
                $app.data.uploads_employees = [data.results];

                $('input[type=file]').val(null);
                $('.modal').modal().modal('close');
                $app.flash.success('Sucesso! Aguarde enquanto verificamos seu arquivo.');
            }
        });
    }




    /**
     * Busca o IP do cliente em API online e efetua o login na API.
     *
     * $entity.login()
     */
    this.hwO37TzeEQ1PLaIf = function () {
        loading();

        $.ajax({
            url: 'https://api.ipify.org/?format=json',
            success: function (ip) {
                var info = request_info();
                $app.data.credentials['connections.ipv4_public'] = ip.ip;
                $app.data.credentials['connections.os'] = info.os;
                $app.data.credentials['connections.browser'] = info.browser;
                $app.data.credentials['user.password_sha1'] = sha1($app.data.credentials['user.password']);
                $app.data.credentials['user.password_md5'] = $.md5($app.data.credentials['user.password']);

                $app.$api.process({"Public::Entity": {login: $app.data.credentials}}, function (data) {
                    $app.data.credentials['user.password'] = ''; // deletamos o password

                    if (data.error != false) {
                        $app.flash.warning('Credencial não encontrada.');
                        return loaded();
                    }

                    var entity = data.results;
                    entity.credentials = $app.data.credentials;
                    entity.contractors_array = [];

                    for (var i = 0; i < entity.contractors.length; i++)
                        entity.contractors_array[i] = entity.contractors[i].type_acronym_id;


                    if ($.inArray(75002, entity.contractors_array) != -1 && MOBILE == true) {
                        $app.flash.warning('Acesso para contratantes apenas na área Web.');
                        return loaded();
                    }

                    $app.data[entity.id] = entity;
                    $app.$cookies.put(COOKIE_USER_TOKEN_KEY, entity.id, {expires: get_user_time_to_expire(), path: null});
                    loaded();

                    return $app.route.redirect('user');
                });
            },
            error: function () {
                $app.flash.warning('Tente novamente em alguns minutos.');
                loaded();
            }
        });
    }

    /**
     * Atualiza os dados da entidade baseado
     * no cookie e informacoes do dispositivo.
     *
     * $entity.refresh()
     */
    this.nbLp4DDrFMYYmKb4 = function () {
        loading();

        // verificamos se esta conectado no browser
        var id = this.id();
        if (!id)
            return $app.data.reset(), loaded();

        // verificamos se os dados do usuario ja estao carregados
        if ($app.data[id])
            return loaded();

        var credentials = {}, info = request_info(true);
        credentials['id'] = id;
        credentials['ipv4_public'] = info.ipv4_public;
        credentials['os'] = info.os;
        credentials['browser'] = info.browser;

        $app.$api.process({"Public::Entity": {connected: credentials}}, function (data) {
            if (data.error != false) {
                $app.flash.warning('Você não está conectado.');
                $app.$entity.nnVddJ5x7btqPizX();
            } else {
                var entity = data.results;
                entity.contractors_array = [];
                for (var i = 0; i < entity.contractors.length; i++)
                    entity.contractors_array[i] = entity.contractors[i].type_acronym_id;

                $app.data[entity.id] = entity;
            }
        });
    }

    /**
     * $entity.logout()
     */
    this.nnVddJ5x7btqPizX = function () {
        loading();
        var credentials = {}, info = request_info(true);
        credentials['id'] = this.id();
        credentials['ipv4_public'] = info.ipv4_public;
        credentials['os'] = info.os;
        credentials['browser'] = info.browser;

        $app.$api.process({"Public::Entity": {logout: credentials}}, function () {
            return;
        });

        $app.data.reset();
        $app.$cookies.remove(COOKIE_USER_TOKEN_KEY, {path: null});
        $app.$cookies.remove(PSAD2H378DF, {path: null});
        //        $app.data.credentials['identifications.namse'] = '100001';
        $app.route.redirect('user');
    };


    /**
     * Obtem o cookie de login.
     *
     * $entity.id()
     */
    this.id = function () {
        var token = $app.$cookies.get(COOKIE_USER_TOKEN_KEY);
        return !token ? false : token;
    }


    /**
     * Obtem o caminho do menu do usuario.
     * $entity.menu
     */
    this.bBmiBUhqRIYYkrz3 = function () {
        //        if (mobile())
        //            return 'app/views/templates/menus/mobile/' + this.XXR8bgnbbubSbfUE() + '.html'

        return 'app/views/templates/menus/' + this.XXR8bgnbbubSbfUE() + '.html'
    }


    /**
     * Verifica o status de conexao da entidade entre 'online' e 'offline'.
     * $entity.status
     */
    this.XXR8bgnbbubSbfUE = function () {
        return this.id() ? 'online' : 'offline';
    }

    /**
     * $entity.online?
     */
    this.a2b15d78e54 = function () {
        return this.XXR8bgnbbubSbfUE() == 'online' ? true : false;
    }


    /**
     * Obtem os dados carregados da entidade conectada.
     * $entity.me
     */
    this.km2MhFiHBr0YJkrX = function () {
        return $app.data[this.id()];
    }

    /**
     * $entity.fisic_employee_add
     */
    this.dn198sd81sd = function () {
        $app.data.entity.contractor_id = this.id();

        $app.$api.process({Entity: {employee_add: $app.data.entity}}, function (data) {
            if (data.error == false) {
                $app.data['contracteds'].push(data.results);
                $app.flash.success('Registro criado com sucesso.');
                $('.modal').modal().modal('close');
            } else
                $app.flash.warning('Não foi possível completar o pedido, tente novamente mais tarde.');
        });
    }



    /**
     * Carrega dados referentes a entidade.
     *
     * $entity.load(id, 'profile', {
     *      params: {entity: {include: ['identifications', 'emails', 'addresses', 'phones'], find: id}},
     *      reload: true,
     *      temp: 'entity',
     * })
     * > $app.data[id][profile], $data.entity, $api.paramns
     *
     * $entity.load(id, 'cards')
     * > $app.data[id][cards], $data.cards, $api.cards
     *
     * $entity.load
     */
    this.load = function (data_key, options) {
        loading();

        var id = 'ws';

        // necessario recarregamento ?
        if (options.$reload == true) {
            delete options.$reload;
            if ($app.data[id] && $app.data[id][data_key])
                delete $app.data[id][data_key];
        }

        // ja foi carregado ?
        if (this.isLoaded(id, data_key)) {
            loaded();
            return $app.data[options.temp] = $app.data[id][data_key];
        }

        if (options.$success) {
            var success = options.$success;
            delete options.$success;
            return $app.$api.process(options, success(response));
        }

        conclude = false;
        if (options.$conclude) {
            var conclude = options.$conclude;
            delete options.$success;
        }

        $app.$api.process(options, function (response) {
            if (response.error != true)
                $app.data[id][data_key] = response.results;
            else
                $app.flash.error('API Error', 'API Error')
            
            if (conclude)
                conclude();

            l($app.data)
        });
    }


    /**
     * Verifica se algum dado de entidade já foi carregado.
     *
     * $entity.isLoaded
     */
    this.isLoaded = function (id, name) {
        if (!id)
            return;

        if (!$app.data[id])
            $app.data[id] = {};

        if (!$app.data[id][name]) {
            $app.data[id][name] = {};
            return false;
        }

        return true;
    }

});
