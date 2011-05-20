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

Factory.define :event do |f|
  f.date     Date.today
  f.time     Time.now
  f.address  'Solovieva 4, office 83'
  f.phone    555-555-555
end
