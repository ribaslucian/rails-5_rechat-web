class CreateViewMessages < ActiveRecord::Migration[5.2]
  def change

#    ### postgresql
#    execute "DROP VIEW IF EXISTS view_messages;
#      create view view_messages AS
#        select	
#          i1.name AS interaction_name,
#          reference_interaction.name AS reference_interaction_name,
#          user_origin.name AS origin_user_name,
#          user_destiny.name AS destiny_user_name,
#          contacts.name AS contact_name,
#          type_acronym.name AS type_name,
#          type_content_acronym.name AS type_content_name,
#          m.*
#
#        from messages as m
#
#        left join users 		as user_origin				on user_origin.id = m.origin_user_id
#        left join users 		as user_destiny 			on user_destiny.id = m.destiny_user_id
#        left join acronyms 		as type_acronym 			on type_acronym.id = m.type_acronym_id
#        left join interactions 	as i1	 					on i1.id = m.interaction_id
#        left join interactions 	as reference_interaction	on reference_interaction.id = m.reference_interaction_id
#        left join acronyms		as type_content_acronym		on type_content_acronym.id = m.type_content_acronym_id
#        left join contacts									on contacts.id = m.contact_id
#
#        ORDER BY m.created_at, m.id
    #"
    
    # sqlite
    execute "
      create view view_messages AS
        select	
          i1.name AS interaction_name,
          reference_interaction.name AS reference_interaction_name,
          user_origin.name AS origin_user_name,
          user_destiny.name AS destiny_user_name,
          contacts.name AS contact_name,
          type_acronym.name AS type_name,
          type_content_acronym.name AS type_content_name,
          m.*

        from messages as m

        left join users 		as user_origin				on user_origin.id = m.origin_user_id
        left join users 		as user_destiny 			on user_destiny.id = m.destiny_user_id
        left join acronyms 		as type_acronym 			on type_acronym.id = m.type_acronym_id
        left join interactions 	as i1	 					on i1.id = m.interaction_id
        left join interactions 	as reference_interaction	on reference_interaction.id = m.reference_interaction_id
        left join acronyms		as type_content_acronym		on type_content_acronym.id = m.type_content_acronym_id
        left join contacts									on contacts.id = m.contact_id

        ORDER BY m.created_at, m.id
    " 
  end
end
