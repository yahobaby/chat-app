# メッセージの値

FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    # afterメソッドを用いて、生成するダミーデータに画像を添付 220901
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    # io: File.openで設定したパスのファイル（public/images/test_image.png）を、test_image.pngというファイル名で保存 220901
    end
  end
end