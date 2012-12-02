user = User.find_or_create_by_name_and_role(:name => "Tristan Kromer",
                                            :email => "tristan@leanstartupcircle.com",
                                            :role => "admin",
                                            :confirmed_at => Time.now,
                                            :confirmation_sent_at => Time.now,
                                            :zip_code => "94110")
user.authentications << Authentication.find_or_create_by_uid_and_provider(:provider => "meetup",
                                                                          :uid => "10786373",
                                                                          :token => "de7f8e88aa93e092f5d68701213ac02e",
                                                                          :url => "http://www.meetup.com/members/10786373")
user.authentications << Authentication.find_or_create_by_uid_and_provider(:provider => "linkedin",
                                                                          :uid => "_EIeQesQRo",
                                                                          :token => "505fedf9-c75a-4d24-9136-7b361e60e525",
                                                                          :secret => "5138fc08-66b6-4d5d-a329-fe2c1f64dc52",
                                                                          :image => "http://m3.licdn.com/mpr/mprx/0_yrLwHB6Ti7tGyxgoYqqqHqn0iu52pMpoOtAqHzLxpolpijIEr9zbQvllDTL1xYj6g1FvFtUuMPTL",
                                                                          :url => "http://www.linkedin.com/in/tristankromer")