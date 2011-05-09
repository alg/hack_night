Factory.define :user do |f|
  f.name      { Faker::Name.name }
  f.nickname  { Faker::Internet.user_name }
end