class Message < ApplicationRecord
  # 1
  after_create_commit { broadcast_if_raw_message }
  after_create :start_interaction
#   before_save :translate_and_calc_sentimental
  before_save :calc_sentimental
  
  belongs_to :interaction, optional: true
  belongs_to :contact, optional: true
  
  belongs_to :origin_user, class_name: 'User', foreign_key: :origin_user_id, optional: true
  belongs_to :destiny_user, class_name: 'User', foreign_key: :destiny_user_id, optional: true
  belongs_to :previous_message, class_name: 'User', foreign_key: :previous_message_id, optional: true
  
  has_many :message_share
  
  def start_interaction
    if self.destiny_user_id == 0
    
      # selecionar a ultima mensagem enviada de uma interacao
      last_message = Message.order('id DESC, interaction_ids DESC')
      .where("interaction_id IS NOT NULL AND destiny_user_id = #{self.origin_user_id}")
      .where(contact_id: self.contact_id)
      .limit(1)
      .first

      # verificar se existe uma mensagem de interacao ja iniciada
      if !last_message.nil?
        # antes precisamos ver se a ultima mensagm enviada é a ultima da interacao em questao
        last_message_interaction = Message
        .where(interaction_id: last_message.interaction_id)
        .where('origin_user_id IS NULL')
        .where('destiny_user_id IS NULL')
        .order(interaction_ids: :desc)
        .limit(1)
        .first()

        if (last_message_interaction.interaction_ids == last_message.interaction_ids)
          start_or_notify()
        else
          continue_interaction last_message, last_message_interaction
        end

      else
        start_or_notify()
      end      
    end
  end
  
  def continue_interaction last_message, last_message_interaction
    # obter a proxima mensagem a enviar
    next_message = Message
    .where(interaction_id: last_message.interaction_id)
    .where(interaction_ids: last_message.interaction_ids + 1)
    .where('origin_user_id IS NULL AND destiny_user_id IS NULL')
    .where(interaction_id: last_message.interaction_id)
    .first()
      
    # pegar a primeira parada para aguardar resposta
    message_wait = Message
    .order(:id)
    .limit(1)
    .where(type_acronym_id: 5)
    .where(interaction_id: last_message.interaction_id)
    .where("id > #{next_message.id}")
    .first()
      
    # buscar todas as mensagens da interacao ate aguarda a resposta
    if !message_wait.nil?
      messages = Message.order(:id)
      .where("id >= #{next_message.id} AND id < #{message_wait.id}")
      .where('origin_user_id IS NULL AND destiny_user_id IS NULL')
      .where(interaction_id: last_message.interaction_id)
    else
      messages = Message.order(:id)
      .where("id >= #{next_message.id}")
      .where('origin_user_id IS NULL AND destiny_user_id IS NULL')
      .where(interaction_id: last_message.interaction_id)
    end
      
    messages.each do |m|
      Message.create!({
          origin_user_id: 0,
          destiny_user_id: self.origin_user_id,
          content: m.content,
          interaction_id: m.interaction_id,
          interaction_ids: m.interaction_ids,
          type_acronym_id: m.type_acronym_id,
          type_content_acronym_id: m.type_content_acronym_id,
          contact_id: self.contact_id,
          reference_interaction_id: last_message.interaction_id
        })
      
#      # verificar se a mensagem eh a ultima da interacao para setar seu status como concluida
#      if m.id == last_message_interaction.id
#        i = Interaction.select(:id, :status_acronym_id).find(m.interaction_id)
#        i.status_acronym_id = 651
#        i.save!
#      end
    end
      
    # atualizar a mensagem atual para informar a interacao em questao
    self.reference_interaction_id = last_message.interaction_id
    self.save!
  end
  
  def start_or_notify
    # iniciar uma interacao
    if self.content == 'start'

      i = Interaction.all.select(:id, :status_acronym_id).first()

      # pegar a primeira mensagem da interacao a enviar
      message = Message.order(id: :asc).find_by_interaction_id(i.id)
          
      # pegar a primeira parada para aguardar resposta
      message_wait = Message
      .select(:id)
      .order(:id)
      .limit(1)
      .where(type_acronym_id: 5)
      .where(interaction_id: message.interaction_id)
      .where("id > #{message.id}")
      .first()
      
      # buscar todas as mensagens da interacao ate aguarda a resposta
      messages = Message.order(:id)
      .where("id >= #{message.id} AND id < #{message_wait.id}")
      .where('origin_user_id IS NULL AND destiny_user_id IS NULL')
      .where(interaction_id: message.interaction_id)

      messages.each do |m|
        Message.create!({
            origin_user_id: 0,
            destiny_user_id: self.origin_user_id,
            content: m.content,
            interaction_id: i.id,
            interaction_ids: m.interaction_ids,
            # interaction_message_id: message.id,
            type_acronym_id: m.type_acronym_id,
            type_content_acronym_id: m.type_content_acronym_id,
            contact_id: self.contact_id,
            reference_interaction_id: message.interaction_id
          })
      end
      
      # atualizar a mensagem atual para informar a interacao em questao
      self.reference_interaction_id = message.interaction_id
      self.save!
      
      # mudar status da interacao para "iniciada"
      i.status_acronym_id = 650
      i.save!

    else
      # nenhuma interacao em vigor
      Message.create!({
          origin_user_id: 0,
          destiny_user_id: self.origin_user_id,
          content: 'Olá! Não posso responder no momento, assim que possível entro em contato.',
          contact_id: self.contact_id
        })
    end
  end

  def broadcast_if_raw_message
    if !self.origin_user_id.nil? && !self.destiny_user_id.nil? && self.type_acronym_id != 6
      ChatBroadcastJob.perform_later self
    end
  end

  def translate_and_calc_sentimental
    if self.type_acronym_id == 2 && self.type_content_acronym_id == 50
      self.content_en = %x(python scripts/translate.py "#{self.content}")
      
      analyzer = Sentimental.new
      analyzer.load_defaults
      self.sentimental_category = analyzer.sentiment self.content
      self.sentimental_score = analyzer.score self.content
    end
  end

  def calc_sentimental
    # ser texto e nao ser [aguardar resposta]
    if self.type_content_acronym_id == 50 && self.type_acronym_id != 5
      self.sentimental_score = %x(python scripts/polarity2.py "#{self.content}")
    end
    
    
    
    # atualizar resposta de controle para resposta alvo
    if self.destiny_user_id == 0
      previous_message = Message
      .select(:type_acronym_id)
      .where(contact_id: self.contact_id)
      .order(id: :desc)
      .limit(1)
      .first()
      
      if previous_message && previous_message.type_acronym_id == 2
        self.type_acronym_id = 4
      end
    end
  end
  
#  def check_target_response
#    # verificamos se eh uma mensagem enviado para o pesquisador
#    if self.destiny_user_id == 0
#      # obtemos a ultima mensagem de bot na conversa
#      last_message = Message.where(
#        destiny_user_id self.origin_user_id,
#        contact_id: self.contact_id
#      ).order(id: desc).limit(1).first
#      
#      # checar se mensagem eh alvo e atualizar tipo da resposta
#      if last_message && last_message.type_acronym_id == 50
#        self.type_acronym_id == 54
#      end
#    end
#  end

  def self.seed_test
    Message.create!({
        origin_user_id: 2,
        destiny_user_id: 1,
        content: "Gostaria de enfatizar que o acompanhamento das preferências de consumo assume importantes posições no estabelecimento dos métodos utilizados na avaliação de resultados.",
        contact_id: 1
      })
    
    Message.create!({
        origin_user_id: 2,
        destiny_user_id: 1,
        type_content_acronym_id: 51,
        content: "https://www.infoescola.com/wp-content/uploads/2019/10/paisagem-ouro-preto-1008049370.jpg",
        contact_id: 1
      })
  end
  
  def self.star params
    message = Message.find(params['id'])
    message.favorited = true
    return message.save!
  end
  
  def self.unstar params
    message = Message.find(params['id'])
    message.favorited = false
    return message.save!
  end
  
  def self.share params
    
    if !params['contacts_id'].nil?
      params['contacts_id'].each do |contact_id, value|
        #      puts "------------"
        #      puts "#{contact_id} -- #{value}"
      
        if value == true
          MessageShare.create!({
              contact_id: contact_id,
              user_id: params['user_id'],
              interaction_id: params['interaction_id'],
              interaction_message_id: params['interaction_message_id'],
              propagation_message_id: params['propagation_message_id'],
            })
          
          Message.create!({
              origin_user_id: params['user_id'],
              destiny_user_id: params['user_id'],
              contact_id: params['origin_contact_id'],
              type_acronym_id: 6,
              
#              interaction_message_id: params['interaction_message_id'],
#              propagation_message_id: params['propagation_message_id'],

              # passar nos parametros
              content: params['content'],
              destiny_contact_id: contact_id,
              interaction_id: params['interaction_id'],
              interaction_ids: params['interaction_ids'],
              type_content_acronym_id: params['type_content_acronym_id'],
              reference_interaction_id: params['reference_interaction_id'],
            })
        end
      end
    end
    
    return params
  end
  
  def self.get_notification params
    m = Message
    .where(destiny_user_id: params[:user_id])
    .where('interaction_id IS NOT NULL')
    .where('count_views = 0')
    .order('id desc')
    .limit(1)
    .first()
    
    return {
      title: 'Contato XYZ',
      content: 'Essa é a notificação',
      params: m
    }
  end
end
