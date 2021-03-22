module ApplicationHelper
  
  def self.random_color
    [
      '6194fd',
      'd4746d',
      '72b2a4',
      '7c5dd2',
      'c693a3',
      'c36e70',
      '805ba5',
      '96d96a',
      '9181ec',
      'bbba0e',
      'de6901',
      'bb4e85',
      '9fb5c1',
      '036be9',
      '4e6e86',
      'adc69a',
      'ce7a93'
    ].sample
end
  
end



# Author Shiva Bhusal
# Aug 2016
# in config/initializers/modify_rails_form_builder.rb
# This will add a new method in the `f` object available in Rails forms
class ActionView::Helpers::FormBuilder
def error_message_for(field_name)
  if self.object.errors[field_name].present?
    # model_name              = self.object.class.name.downcase
    #id_of_element           = "error_#{model_name}_#{field_name}"
    #target_elem_id          = "#{model_name}_#{field_name}"
    #class_name              = 'signup-error alert alert-danger'
    #error_declaration_class = 'has-signup-error'
      
    #      "<div class='ui pointing label large orange custom-input-error' style='position: relative; top: -13px; text-align: center !important;'>\
    "<div class='ui label large orange custom-input-error' style='position: relative; text-align: center !important;'>\
        #{self.object.errors[field_name].first}
      </div>".html_safe

    #      "<div id=\"#{id_of_element}\" for=\"#{target_elem_id}\" class=\"#{class_name}\">"\
    #        "#{self.object.errors[field_name].join(', ')}"\
    #        "</div>"\
    #        .html_safe
  end
rescue
  nil
end
end
