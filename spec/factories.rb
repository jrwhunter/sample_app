FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :hill do
    sequence(:number)  { |n| "M#{n}" }
    sequence(:name)  { |n| "Munro_#{n}" }
    other_info "Introduced 1990"
    origin "White hill"
    chapter "08:06 The Cairngorms"
    height "1309"
    grid_ref "NN 989 989"
    map "http://www.bing.com/maps/?v=2&cp=57.069993~-3.669066&lvl=13&dir=0&sty=s&form=LMLTCC"
  end

end
