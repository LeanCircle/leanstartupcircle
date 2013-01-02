FactoryGirl.define do
  factory :twitter_hash, class:Hash do
    info          {{ 'name' => 'Fred Flintstone',
                     'image' => 'http://image.com/image.jpg',
                     'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                     'description' => 'This is who I am.',
                     'location' => 'New York, NY' }}
    uid           '12345'
    provider      'twitter'
    credentials   {{ 'token' => 'token',
                     'secret' => 'secret' }}
    extra         {{ 'user_hash' => {} }}

    initialize_with { attributes }
  end

  factory :meetup_hash, class:Hash do
    info          {{ 'name' => 'Fred Flintstone',
                     'image' => 'http://image.com/image.jpg',
                     'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                     'description' => 'This is who I am.',
                     'location' => 'New York, NY' }}
    uid           '12345'
    provider      'meetup'
    credentials   {{ 'token' => 'token',
                     'secret' => 'secret' }}
    extra         {{ 'user_hash' => {} }}

    initialize_with { attributes }
  end

  factory :linkedin_hash, class:Hash do
    info          {{ 'name' => 'Fred Flintstone',
                     'email' => 'fred@flintstone.com',
                     'image' => 'http://image.com/image.jpg',
                     'urls' => { 'public_profile' => 'http://homeurl.com/username' },
                     'description' => 'This is who I am.',
                     'location' => 'New York, NY' }}
    uid           '12345'
    provider      'linkedin'
    credentials   {{ 'token' => 'token',
                     'secret' => 'secret' }}
    extra         {{ 'user_hash' => {} }}

    initialize_with { attributes }
  end

end