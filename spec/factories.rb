require 'faker'

FactoryBot.define do
  factory :user do
    username Faker::Internet.email
    password "p@ssw0rd"
  end

  factory :video do
    youtube_url "https://www.youtube.com/watch?v=g1jun_V1o2E"
    title Faker::Name.name
    desc Faker::String.random
  end

  factory :token

  factory :vote
end