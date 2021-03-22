class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      
      t.belongs_to :user, foreign_key: true
      t.string :name, null: false
      t.integer :type_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:contacts.type'}, null: false
      t.integer :count_views, default: 0
      
      t.timestamps
    end
  end
end
