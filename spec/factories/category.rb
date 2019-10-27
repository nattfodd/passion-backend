# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    vertical
    name { FFaker::Lorem.unique.sentence }
    state { 'active' }
  end
end
