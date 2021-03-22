class CreateMessageInteractions < ActiveRecord::Migration[5.2]
  def change
    create_table :message_interactions do |t|
      
      t.belongs_to :user, foreign_key: true
      t.belongs_to :message, foreign_key: true
      
      # calcs
      t.decimal :time_focus, default: 0
      t.integer :count_views, default: 0
      t.boolean :favorited, default: false
      
      # se a mensagem for "alvo", sera armazenado a proxima acao
      # somente apos a na primeira visualizacao da mensagem
      t.integer :next_action_acronym_id, foreign_key: {to_table: :acronyms, name: 'rule_fk:messages_interactions.next_action'}, default: 50
      
      t.timestamps
    end
  end
end
