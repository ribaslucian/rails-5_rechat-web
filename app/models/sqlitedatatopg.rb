class Sqlitedatatopg < ApplicationRecord
  
#  self.abstract_class = true
#  self.table_name = 'messages'
#  connects_to database: { writing: :development, reading: :sqlite }
  
  def self.go
    
    sqlitedb = ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/development.sqlite3'
    )
    
    sql = "SELECT * from users LIMIT 5"
    result = sqlitedb.connection.execute(sql);
    
    return result
#    @result.each(:as => :hash) do |row| 
#       puts row
#    end
    
  end
  
end
