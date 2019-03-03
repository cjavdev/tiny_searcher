FactoryBot.define do
  factory :tag do
    sequence(:name) {|x| "tag-#{ x }"}
  end
end
