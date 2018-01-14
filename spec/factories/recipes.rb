FactoryBot.define do
  factory :recipe do
    title 'Bolo de Chocolate'
    difficulty 'Fácil'
    ingredients 'Farinha, ovo, manteiga, acucar, chocolate'
    cook_time 60
    add_attribute(:method) { 'Misturar tudo e assar' }
    cuisine
    'recipe-type'
  end
end