class ProductPolicy < ApplicationPolicy
  
	def index?
		user.admin?
	end

	def new?
		user.admin?
	end

	def create?
		new?
	end

	def edit?
		user.admin? || (record.id == user.id)
	end

	def show?
		true
	end

	def update?
		edit?
	end

	def destroy?
		user.admin?
	end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
