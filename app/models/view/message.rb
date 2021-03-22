class View::Message < ApplicationRecord
  self.inheritance_column = true
  self.table_name = 'view_messages'
  paginates_per 15
end
