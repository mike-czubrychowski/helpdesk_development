module ApplicationHelper


	def link_if_you_can(permission, obj, htmlclass = nil)        

		begin

			if obj.class.name.include? ':' then
				
				pundit_obj = obj.class.name.tr(':','').to_sym
				
			else
				pundit_obj = obj
			end
			
			if htmlclass.nil? 

				if Location.categories.include? obj.class.name and obj.class.name != 'Storelocation'
					link_text = obj.friendly_name
				else
					link_text = obj.name
				end
			

			else
				link_text = ''
			end

		
			case permission.to_sym
				when :create
					if Pundit.policy(current_user, pundit_obj).create? then 
						
						return link_to link_text, [:create, obj], :class => htmlclass 
					end
				when :read, :show
					
					if Pundit.policy(current_user, pundit_obj).show? then 
						
						return link_to link_text, pundit_obj, :class => htmlclass 
					end
				when :update, :edit
					if Pundit.policy(current_user, pundit_obj).update? then
					
						return link_to link_text, [:edit, obj], :class => htmlclass 
					end
				when :destroy
					if Pundit.policy(current_user, pundit_obj).destroy? then 
						
						return link_to link_text, [:delete, obj], :class => htmlclass, :method => :delete, :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) } 
					end
			end

			# if it hasn't returned anything then
			obj.name if link_text != ''


			# if can? permission, obj then


			# 	case permission 
			# 		when :read
			# 			link_to link_text, obj, :class => htmlclass
			# 		when :destroy
			# 			link_to link_text, [:delete, obj], :class => htmlclass, :method => :delete, :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) }
			# 		else
			# 			link_to link_text, [permission, obj], :class => htmlclass
			# 	end
			# else
			#     obj.name if link_text != ''
			# end
			
		rescue 
		 	nil
		end
		
	end

	def link_to_location_type_if_you_can(permission, obj)
		#refactor above

		link_to obj.category_id, obj.category.downcase.pluralize
		
	end

	
	


end
