class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      
      t.string :entity_name
      t.string :name, null: false, index: {unique: true}
      t.string :password, null: false, default: '123'
      t.integer :type_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:users.type'}, null: false
      t.boolean :chat_connected, default: false
      
      t.timestamps
    end
  end
end
