class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  normalize_blank_values
  
  def self.d v
    puts '----------->'
    puts v
  end
  
  def self.sql sql
    return ActiveRecord::Base.connection.execute sql
  end
  
  def self.select_except columns
    select(column_names - columns.map(&:to_s))
  end
  
  def self.sql_with_params sql, params
    st = ActiveRecord::Base.connection.raw_connection.prepare(sql)
    results = st.execute(params)
#    st.close
    
    return results
  end
end
