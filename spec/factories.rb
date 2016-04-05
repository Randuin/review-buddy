FactoryGirl.define do
  factory :repo do
    github_id 1
    url "MyString"
  end

  factory :pull_request do
    title { generate(:title) }
    url { generate(:url) }
    repo { generate(:repo) }
    owner { generate(:owner) }
    number { generate(:github_id) }
    merged { false }
    reviewed { false }
    closed { false }
    users { build_list(:user, 2) }
  end
  
  factory :user do
    email { generate(:email) }
    github_username { 'xuorig' }
    password { 'password' }
    github_access_token { 'an_access_token' }
    
    factory :user_with_prs do
      after(:build) do |user|
        user.pull_requests << build(:pull_request, reviewed: true)
        user.pull_requests << build(:pull_request)
      end
    end
  end

  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:title) { |n| "Title #{n}" }
  sequence(:url) { |n| "http://github.com/xuorig/review-buddy/#{n}" }
  sequence(:github_id) { |n| n }
  sequence(:repo) { |n| "repo#{n}" }
  sequence(:owner) { |n| n }
end
