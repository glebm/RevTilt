# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:url) {|n| "http://www.yelp.com/biz/#{n}" }
  
  factory :organization do
    name "MyString"
    url
    url_type "MyString"
    homepage_url nil
    latitude 1.5
    longitude 1.5
    category_id 1
  end
end
