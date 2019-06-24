class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def myindex?

  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def tagged?
    true
  end
end
