FactoryGirl.define do
  factory :omniauth_hash, class:Hash do
    info          {{ 'name' => 'Fred Flintstone',
                     'image' => 'http://image.com/image.jpg',
                     'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                     'email' => 'dpsk@email.ru',
                     'description' => 'This is who I am.',
                     'location' => 'New York, NY' }}
    uid           '12345'
    provider      'twitter'
    credentials   {{ 'token' => 'token',
                     'secret' => 'secret' }}
    extra         {{ 'user_hash' => {} }}

    initialize_with { attributes }
  end
end