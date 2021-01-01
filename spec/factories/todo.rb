# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    sequence(:content) { |n| "Test todo item content #{n}" }

    trait :completed do
      completed { true }
    end

    factory :completed_todo, traits: [:completed]
  end
end
