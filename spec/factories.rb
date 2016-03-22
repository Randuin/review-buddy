FactoryGirl.define do
  factory :pull_request do
    title { generate(:title) }
    url { generate(:url) }
    github_id { generate(:github_id) }
    reviewed { false }
    closed { false }
    users { build_list(:user, 2) }
  end
  
  factory :user do
    email { generate(:email) }
    password { 'password' }
    
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
end
