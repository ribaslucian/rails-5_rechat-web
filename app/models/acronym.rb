class Acronym < ApplicationRecord
  
  def self.seeds
    self.delete_all
    
    Acronym.create!([

      # 1..
      {id: 1, name: 'Mensagem de Controle', data_refer: 'messages.type'},
      {id: 2, name: 'Mensagem de Alvo', data_refer: 'messages.type'},
      {id: 3, name: 'Resposta de Controle', data_refer: 'messages.type'},
      {id: 4, name: 'Resposta Alvo', data_refer: 'messages.type'},
      {id: 5, name: '[Aguardar Resposta]', data_refer: 'messages.type'},
      {id: 6, name: 'Compartilhamento', data_refer: 'messages.type'},
      
      # 50...
      {id: 50, name: 'Textual', data_refer: 'messages.type_content'},
      {id: 51, name: 'Imagem', data_refer: 'messages.type_content'},
      # {id: 52, name: 'Vídeo', data_refer: 'messages.type_content'},
      # {id: 53, name: 'Áudio', data_refer: 'messages.type_content'},

      # 100... 
      {id: 100, name: 'Pergunta 01', data_refer: 'users.answer'},
      {id: 101, name: 'Pergunta 02', data_refer: 'users.answer'},
      {id: 102, name: 'Pergunta 03', data_refer: 'users.answer'},

      # 200... 
      {id: 200, name: 'Pesquisador', data_refer: 'users.type'},
      {id: 201, name: 'Voluntário', data_refer: 'users.type'},

      # 300... 
      {id: 300, name: 'Conversa', data_refer: 'interactions.type'},
      {id: 301, name: 'Questionário', data_refer: 'interactions.type'},

      # 400... 
      {id: 400, name: 'Diário', data_refer: 'interactions.schedule'},
      {id: 401, name: 'Semanal', data_refer: 'interactions.schedule'},

      # 500...
      {id: 500, name: 'Hóra do Dia', data_refer: 'interactions.number_schedule'},
      
      # 600...
      {id: 600, name: 'Familiar', data_refer: 'contacts.type'},
      {id: 601, name: 'Amizade', data_refer: 'contacts.type'},
      {id: 602, name: 'Profissional', data_refer: 'contacts.type'},
      {id: 603, name: 'Grupo', data_refer: 'contacts.type'},
      
      # 650...
      {id: 650, name: 'Iniciado', data_refer: 'interactions.status'},
      {id: 651, name: 'Concluído', data_refer: 'interactions.status'},
      {id: 652, name: 'Pausado', data_refer: 'interactions.status'},
      {id: 653, name: 'Reiniciado', data_refer: 'interactions.status'},
      {id: 654, name: 'Pendente', data_refer: 'interactions.status'},
    ])

  end
  
end
