# frozen_string_literal: true

class ListingPolicy < ApplicationPolicy
  def edit?
    record.user == user || admin_emails.include?(user.email)
  end

  def update?
    record.user == user || admin_emails.include?(user.email)
  end

  def destroy?
    record.user == user || admin_emails.include?(user.email)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
