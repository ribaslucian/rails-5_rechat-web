class Interaction < ApplicationRecord
  has_many :messages, -> { where('origin_user_id IS NULL AND destiny_user_id IS NULL') }, dependent: :destroy

  #  before_save :set_message_ids, :set_last_message_as_wait
  before_create :set_message_ids
  before_update :set_message_ids
  
  after_create :set_last_message_as_wait
  after_update :set_last_message_as_wait

  belongs_to :type, -> { select :name }, class_name: 'Acronym', foreign_key: :type_acronym_id, optional: true
  
  accepts_nested_attributes_for :messages, allow_destroy: true  
  
  def set_message_ids
    i = 1
    self.messages.each do |m|
      if (m.type_acronym_id != 5)
        m.interaction_ids = i
        i = i + 1
      end
    end
  end
  
  def set_last_message_as_wait
    if self.messages.last.type_acronym_id != 5 # || self.messages.last._destroy == "1"
      self.messages.push Message.new({
          type_acronym_id: 5
        })

#      @interaction = Interaction.find self.id
#      
#      i = 1
#      @interaction.messages.each do |m|
#        if (m.type_acronym_id != 5)
#          m.interaction_ids = i
#          i = i + 1
#        end
#      end
#      
#      @interaction.save!
    end
  end
  
  def self.save_times params
    
    if params["scroll_count"] > 0 || params["has_scroll"] == false
      
      # salvar o tempo de foco de todas as mensagens
      params['times'].each do |id, time|
        message = Message.find(id)
        message.time_focus = message.time_focus + time;
        message.count_views = message.count_views + 1;
        message.chat_open = true
        message.save!
      end
    else
      
      # salvar o tempo de foco apenas da ultima
      id = params['times'].keys.last
      message = Message.find(id)
      message.time_focus = message.time_focus + params['times'][id];
      message.count_views = message.count_views + 1;
      message.chat_open = true
      message.save!
    end
    
    params
  end
  
  
  def self.send_welcome interaction_id, user_id
    i = Interaction.find(interaction_id)
    
    first_message = i.messages.order(:id).first
    
    # pegar a primeira parada para aguardar resposta
    message_wait = Message
    .select(:id)
    .order(:id)
    .limit(1)
    .where(type_acronym_id: 5)
    .where(interaction_id: i.id)
    .where("id > #{first_message.id}")
    .first()
    
    
    # buscar todoas as mensagens da interacao ate aguarda a resposta
    messages = Message.order(:id)
    .where("id >= #{first_message.id} AND id < #{message_wait.id}")
    .where('origin_user_id IS NULL AND destiny_user_id IS NULL')
    .where(interaction_id: i.id)
    
    u = User.find(user_id)
    offset = rand(u.contacts.count)

    messages.each do |m|
      Message.create!({
          origin_user_id: 0,
          destiny_user_id: u.id,
          content: m.content,
          interaction_id: i.id,
          interaction_ids: m.interaction_ids,
          # interaction_message_id: message.id,
          type_acronym_id: m.type_acronym_id,
          type_content_acronym_id: m.type_content_acronym_id,
          contact_id: Contact.where(user_id: u.id).offset(offset).first.id
        })
    end
  end
  
  
end
