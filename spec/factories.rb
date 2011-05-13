Factory.define :message do |f|
  f.body      { Faker::Lorem.sentence }
end

Factory.define :user do |f|
  f.name      { Faker::Name.name }
  f.nickname  { Faker::Internet.user_name }
end

Factory.define :project do |f|
  f.name      { Faker::Lorem.words(3) }
end