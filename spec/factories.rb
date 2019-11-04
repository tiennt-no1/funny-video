require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.email }
    password { "p@ssw0rd" }
  end

  factory :video do
    youtube_url { "https://www.youtube.com/watch?v=TEEstkKUsGk".gsub("\u0000", '') }
    title { Faker::Name.name }
    desc { Faker::String.random(100) }
  end

  factory :token
  factory :vote
end