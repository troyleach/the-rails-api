FactoryBot.define do
  factory :link do
    display_text { 'Anything' }
    url { 'http://anywhere.com' }
  end
end

# FactoryBot.define do
#   factory :link do
#     trait :active do
#       display_text { 'Anything' }
#       url { 'http://anywhere.com' }
#     end

#     trait :deleted do
#       active { false }
#     end
#   end
# end
