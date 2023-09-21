# frozen_string_literal: true

class PagyNavComponent < ApplicationComponent
  include Pagy::Frontend

  def initialize(pagy:)
    @pagy = pagy
  end

  def render?
    @pagy.present? && @pagy.pages > 1
  end
end
