# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
  	association :user, factory: :user
  	sequence(:title) {|n| "#{Faker::Company.bs} #{n}" }
  	description Faker::Lorem.sentence
  end
end
