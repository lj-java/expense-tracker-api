FactoryBot.define do
  factory :expense do
    name { "Coffee" }
    amount { 100 }
    date { Date.today }
  end
end
