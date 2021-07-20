FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "johndoe@gmail.com" }
    password {"qweasdzxc" }
    password_confirmation { "qweasdzxc" }
  end
end