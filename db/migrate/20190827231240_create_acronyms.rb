class CreateAcronyms < ActiveRecord::Migration[5.2]
  def change
    create_table :acronyms do |t|
      
      t.string  :name, null: false, unique: true
      t.text    :description
      t.string  :data_refer, limit: 64, null: false

      t.timestamps
    end
  end
end
