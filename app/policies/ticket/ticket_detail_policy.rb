
class TicketDetailPolicy < ApplicationPolicy

  

  def index? ; true; end 
  def show?    

    case @current_user.role.name.to_sym
      
      when :superadmin
        #All tickets
        return true
      when :admin
        #In your country
        return true if @current_user.location.subtree_ids.include? @record.location_id
      when :helpdesk
        #That are in your location and category
        return true if @current_user.location.subtree_ids.include? @record.location_id and @current_user.organisation.ticket_category.subtree_ids.include? @record.ticket_category_id
      when :operations
        #Your location and below
        return true if @current_user.location.subtree_ids.include? @record.location_id
      when :thirdparty
        #Your category
        return true if @current_user.organisation.ticket_category.subtree_ids.include? @record.ticket_category_id
    end

    return true if @current_user.tickets.include? @record

    false 
  end

  def create? 
    self.show? 
  end

  def update? 
    self.show? 
  end

  def destroy?

    case @current_user.role.name.to_sym
      
      when :superadmin
        #All tickets
        return true
      when :admin
        #In your country
        return true if @current_user.location.subtree_ids.include? @record.location_id
      when :helpdesk
        #That are in your location and category
        return true if @current_user.location.subtree_ids.include? @record.location_id and @current_user.organisation.ticket_category.subtree_ids.include? @record.ticket_category_id
      when :operations
        #Your location and below
        return false
      when :thirdparty
        #Your category
        return false
    end

    return true if @current_user.tickets.include? @record

    false end

  class Scope < Scope

    #is this needed or is it inherited from Applciation Policy
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve


    case @current_user.role.name.to_sym
      
      when :superadmin
        #All tickets
        scope
      when :admin, :operations
        #In your country
        scope.where("ticket_details.location_id IN (?) ", @current_user.location.subtree_ids)
      when :helpdesk
        #That are in your location and category
        scope.where("ticket_details.location_id IN (?) and ticket_details.ticket_category_id IN (?)", @current_user.location.subtree_ids, @current_user.organisation.ticket_category.subtree_ids)
      when :thirdparty
        scope.where("ticket_details.ticket_category_id IN (?)", @current_user.organisation.ticket_category.subtree_ids.include?)
    end
        
    end
  end
end
