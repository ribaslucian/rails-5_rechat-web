Acronym.seeds


Interaction.create!({
    name: 'Bot de Boas-Vindas',
    messages_attributes: [
      {
        type_acronym_id: 1,
        type_content_acronym_id: 50,
        content: 'Olá, seja bem-vindo(a) ao Rechat!',
      }, {
        type_acronym_id: 1,
        type_content_acronym_id: 51,
        content: 'data:image/png;base64,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',
      }, {
        type_acronym_id: 1,
        type_content_acronym_id: 50,
        content: 'Nós vamos lhe manter atualizado(a) sobre diversos assuntos.',
      }, {
        type_acronym_id: 2,
        type_content_acronym_id: 50,
        content: 'Fique atento(a)!',
      }, {
        type_acronym_id: 5,
      }
    ]
  })


#Interaction.create!({
#    name: 'Bot Bom',
#    messages_attributes: [
#      {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Olá!',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Tudo bem ?',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Assim, estou assim também.',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 51,
#        content: 'https://ogimg.infoglobo.com.br/in/24406017-58e-d36/FT1086A/652/x87828951_Sorocaba-SP-11-04-2020Hidroxicloroquina-e-COVID-19Foto-conceitual-do-medicamentoHidr.jpg.pagespeed.ic.WPMG6WucNM.jpg',
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 50,
#        content: 'Você sabia disso ? Com os serviços de saúde colapsando por causa do grande número de casos de Covid-19, uma medicação eficiente para tratar a doença seria um caminho não só para desafogar os leitos de UTI como também para salvar vidas. É por isso que estudos com medicamentos que já existem estão sendo realizados por todo mundo.',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Interessante né. Se souber de algo mais lhe conto.',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Até logo!',
#      },  
#    ]
#  })
#
#
#Interaction.create!({
#    name: 'Bot Neutro',
#    messages_attributes: [
#      {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 01',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 02',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 03 [alvo]',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 04 [alvo]',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 05',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 06',
#      },  {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Mensagem 07',
#      },  
#    ]
#  })
#
#
#Interaction.create!({
#    name: 'Bot Ruim',
#    messages_attributes: [
#      {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Eu não gosto de você',
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 50,
#        content: 'E estou com muita raiva',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 51,
#        content: 'https://s2.glbimg.com/kMBhrrNz-6Fy2jGdkDEsKWzZhXY=/512x320/smart/e.glbimg.com/og/ed/f/original/2016/01/20/diarioweb_filme_divertidamente_raiva.jpg',
#      }, {
#        type_acronym_id: 2,
#        type_content_acronym_id: 50,
#        content: 'Estou muito triste.',
#      }, {
#        type_acronym_id: 5,
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Não quero mais conversar.',
#      }, {
#        type_acronym_id: 1,
#        type_content_acronym_id: 50,
#        content: 'Adeus',
#      },  
#    ]
#  })


User.create({
    name: 'ppgca',
    type_acronym_id: 200,
  })

User.create({
  name: 'lucian',
  type_acronym_id: 201,
})
