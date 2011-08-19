require 'factory_girl'


FactoryGirl.define do

  factory :character do
    name Forgery(:name).full_name
    sequence(:number)
    born { rand(50) + 1870 }
    country Forgery(:address).country
    assignment Forgery(:name).company_name
    specialisation  Forgery(:name).job_title

  end

  factory :user do
    name { Forgery(:name).first_name }
    email { Forgery(:internet).email_address }
    role 'user'
    password 'please'
  end


end