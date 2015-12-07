# spec/factories/donuts.rb
require 'faker' # gin up random data

FactoryGirl.define do
  factory :donut do

    name { Faker::Commerce.product_name }

    trait :with_adcopy do
      ad_copy { Faker::Lorem.paragraph(3) }
    end

  end
end
