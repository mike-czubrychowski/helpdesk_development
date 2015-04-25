module ApplicationHelper


	def link_if_you_can(permission, obj, htmlclass = nil)

        

		begin

			if htmlclass.nil? 
				link_text = obj.name
			else
				link_text = ''
			end 

			
			
			if can? permission, obj then


				case permission 
					when :read
						link_to link_text, obj, :class => htmlclass
					when :destroy
						link_to link_text, [:delete, obj], :class => htmlclass, :method => :delete, :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) }
					else
						link_to link_text, [permission, obj], :class => htmlclass
				end
			else
			    obj.name
			end
			
		rescue 
			nil
		end
		
	end

	def link_to_location_if_you_can(permission, obj)
		#refactor above

		link_to obj.category_id, obj.category.downcase.pluralize
		
	end

	


end