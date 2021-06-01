class Sqlitedatatopg < ApplicationRecord
  
  #  self.abstract_class = true
  #  self.table_name = 'messages'
  #  connects_to database: { writing: :development, reading: :sqlite }
  
  def self.migrate_acronyms_to_pg
    
    return Acronym.all
    
    sqlitedb = ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/development.sqlite3'
    )
    
    result = sqlitedb.connection.execute("SELECT * FROM acronyms");
    
    
    result.each do |row| 
      Acronym.create! row
    end
    
    return result
  end
  
end
