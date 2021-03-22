class MessageShare < ApplicationRecord
  
  belongs_to :user, optional: true
  belongs_to :interaction, optional: true
  belongs_to :contact, optional: true
#  belongs_to :interaction_message
#  belongs_to :propagation_message

end
