connection = ActiveRecord::Base.connection
class << connection
  alias :original_exec :execute
  def execute(sql, *name)
    # try to log sql command but ignore any errors that occur in this block
    # we log before executing, in case the execution raises an error
    begin
        File.open(Rails.root.join("/log/sql.txt"), 'a'){|f| f.puts Time.now.to_s+": "+sql}
    rescue Exception => e
      ;
    end
    # execute original statement
    original_exec(sql, *name)
  end
end