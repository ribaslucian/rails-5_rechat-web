var CONTACT_ID = 0;

// 3
function connect(origin_user_id) {

    var last_side = null;
    var current_side = null;

    App.chat = App.cable.subscriptions.create({
        channel: "ChatChannel",
        user_id: origin_user_id,
    }, {
        connected: function () {
        },
        disconnected: function () {
        },
        received: function (data) {
            // quando chegar notifica se o usuario nao estiver na conversa
            var pathname = window.location.pathname;
            var contact_id = pathname.split('/');
            contact_id = contact_id[contact_id.length - 1];
            var flash = true;

            // verificar se o usuario esta no chat
            if (pathname.substring(0, 20) == '/voluntary/voluntary') {

                // verificar se a mensagm eh do chat em questao
                if (contact_id == data['message_record']['contact_id']) {

//                    $('.ws-behavior-messages').append(data['message_html']);
//                    $('.dropdown').dropdown();

                    var an_app = angular_app();
                    var an_scope = angular.element('[ng-controller="GlobalController"]').scope();
                    
//                    l(an_app);
//                    l(an_scope);

                    var compiledHtml = an_app.$compile(data['message_html'])(an_scope);
                    $('.ws-behavior-messages').append(compiledHtml);
                    an_scope.$apply();
                    
//                    angular
//                        .element(document.getElementById('messages'))
//                        .append(an_app.$compile(data['message_html'])(an_scope));

                    capture_interaction_start();
                    order();
                    scroll();
                    flash = false;
                }
            }

            if (flash) {
                $.toast({
                    text: 'Nova mensagem: ' + data['message_record']['content'],
                    position: 'top-center',
                    hideAfter: 5000,
                    loaderBg: '#777',
                    bgColor: '#31708f',
                    textColor: 'white',
                });
            }

            loaded();
        },
        // 2
        speak: function (message) {
            loading();

            this.perform('speak', {
                origin_user_id: origin_user_id,
                destiny_user_id: 0,
                content: message,
                contact_id: CONTACT_ID,
            });
        }
    });

}

// 1
$(document).on('keypress', '.behavior-input-type-message', function (event) {
    if (event.keyCode === 13) {
        App.chat.speak($('.behavior-input-type-message').val());
        $('.behavior-input-type-message').val('');

        // seguranca para nao repetir envio
        return event.preventDefault();
    }
});

$(document).ready(function () {
    $('.behavior-button-send-message').click(function (e) {
        App.chat.speak($('.behavior-input-type-message').val());
        $('.behavior-input-type-message').val('');

        // seguranca para nao repetir envio
        return e.preventDefault();
    });
});