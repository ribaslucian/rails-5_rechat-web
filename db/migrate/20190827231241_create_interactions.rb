class CreateInteractions < ActiveRecord::Migration[5.2]
  def change
    create_table :interactions do |t|
      
      t.string :name, null: false, index: {unique: true}
      t.json :user_sends
      
      t.integer :status_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:interactions.status'}, null: false, default: 654
      t.integer :type_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:interactions.type'}, null: false, default: 300
      t.integer :schedule_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:interactions.schedule'}, null: false, default: 400
      t.integer :number_schedule, null: false, default: 13

      t.timestamps
    end
  end
end
