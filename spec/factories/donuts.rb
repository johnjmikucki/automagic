# spec/factories/donuts.rb
require 'faker' # gin up random data

FactoryGirl.define do
  factory :donut do |f|
    f.name { Faker::Commerce.product_name }
    f.ad_copy { Faker::Lorem.paragraph(3) }
  end
end
