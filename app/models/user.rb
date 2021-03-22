class User < ApplicationRecord
  has_many :contacts, dependent: :destroy
  
  before_create :add_defaults_contacts
  before_update :at_least_one_contact
  after_create :send_welcome
  
  accepts_nested_attributes_for :contacts, allow_destroy: true
  
  def add_defaults_contacts
    if self.contacts.size == 0 && self.type_acronym_id == 201
      self.contacts = [
        Contact.new({
          name: "Pai",
          type_acronym_id: 600,
        }),
        Contact.new({
          name: "Mãe",
          type_acronym_id: 600,
        }),
        Contact.new({
          name: "Amigo",
          type_acronym_id: 601,
        }),
        Contact.new({
          name: "Chefe",
          type_acronym_id: 602,
        }),
        Contact.new({
          name: "Grupo do Trabalho",
          type_acronym_id: 603,
        }),
      ]
    end
  end
  
  # garantir que usuario voluntario se tenha ao menos 1 contato cadastrado
  def at_least_one_contact
    if self.type_acronym_id == 201
      # comparar quantidade antes da edição e depois da edição
    end
  end
  
  def send_welcome
    if self.type_acronym_id == 201
      Interaction.send_welcome(1, self.id)
    end
  end
  
end
