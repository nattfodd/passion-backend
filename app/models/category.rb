# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :vertical
  has_many :courses, dependent: :destroy
end
