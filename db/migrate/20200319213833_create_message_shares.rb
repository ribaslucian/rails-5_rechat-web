class CreateMessageShares < ActiveRecord::Migration[5.2]
  def change
    create_table :message_shares do |t|
      
      t.belongs_to :user, foreign_key: true
      t.belongs_to :contact, foreign_key: true
      t.belongs_to :interaction
      
      t.integer :interaction_message_id
      t.integer :propagation_message_id
      
      t.timestamps
    end
  end
end
