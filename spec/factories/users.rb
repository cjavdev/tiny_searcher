FactoryBot.define do
  factory :user do
    sequence(:external_id) {|x| "ext-#{ x }"}
  end
end
