# frozen_string_literal: true

FactoryBot.define do
  factory :vertical do
    name { FFaker::Lorem.unique.sentence }
  end
end
