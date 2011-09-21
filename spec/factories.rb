FactoryGirl.define do

  factory :user do
    name { Forgery(:name).first_name }
    email { Forgery(:internet).email_address }
    role :user
    password 'please'

    factory :admin do
      role :admin
    end

    factory :coordinator do
      role :coordinator
    end
  end

  factory :character do
    sequence(:number)
    name { Forgery(:name).full_name }
    born { rand(50) + 1870 }
    country { Forgery(:address).country }
    assignment { Forgery(:name).company_name }
    specialisation  { Forgery(:name).job_title }
    user

    factory :orphaned_character do
      user nil
    end

  end

  factory :mission do
    sequence(:number)
    name { Forgery(:lorem_ipsum).title }
    description { Forgery(:lorem_ipsum).sentence }
    location { "#{Forgery(:address).city}, #{Forgery(:address).country}" }
    date { "#{Forgery(:date).day}. #{Forgery(:date).month(numerical: true)}. 1939" }

    factory :attended_mission do
      attendances { FactoryGirl.build_list(:attendance, 3) }
    end
  end

  factory :mission_attendance, aliases: [:attendance] do
    mission
    character
    
    factory :report do
      report { Forgery(:lorem_ipsum).paragraph }
    end
  end


end