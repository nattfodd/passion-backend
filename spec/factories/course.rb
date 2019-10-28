# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    category
    name { FFaker::Lorem.unique.sentence }
    author { FFaker::Name.name }
  end
end
