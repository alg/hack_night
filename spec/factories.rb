Factory.define :message do |f|
  f.body        { Faker::Lorem.sentence }
end

Factory.define :user do |f|
  f.name        { Faker::Name.name }
  f.nickname    { Faker::Internet.user_name }
end

Factory.define :project do |f|
  f.association :originator, :factory => :user
  f.name        { Faker::Lorem.words(3) }
end

Factory.define :link do |f|
  f.label       { Faker::Lorem.words(3) }
  f.url         { "http://#{Faker::Internet.domain_name}/" }
end

Factory.define :event do |f|
  f.when     Time.now
  f.address     "Solovieva 4, office 83"
  f.phone       { Faker::PhoneNumber.phone_number }
end
