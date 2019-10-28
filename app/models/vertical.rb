# frozen_string_literal: true

class Vertical < ApplicationRecord
  has_many :categories, dependent: :destroy
end
