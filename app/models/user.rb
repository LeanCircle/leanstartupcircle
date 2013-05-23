class User < ActiveRecord::Base

  has_many :authentications
  has_many :groups

  extend FriendlyId
  friendly_id :name, use: :slugged

  #validates_presence_of :name
  validates_presence_of :email
  validates :email, :uniqueness => { :case_sensitive => false }
  after_validation :geocode, :reverse_geocode

  geocoded_by :zip_code
  reverse_geocoded_by :latitude, :longitude do |user,results|
    if geo = results.first
      user.city = geo.city
      user.province = geo.state_code
      user.country = geo.country
      user.zip_code = geo.postal_code
    end
  end

  acts_as_gmappable :validation => false,
                    :process_geocoding => false

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :recoverable,
         :rememberable,
         :trackable,
         :lockable,
         :confirmable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email,
  #                :zip_code,
  #                :phone,
  #                :password,
  #                :password_confirmation

  def image
    !main_image.blank? ? main_image : authentications.where("image IS NOT NULL").first.try(:image)
  end

  def description
    !main_description.blank? ? main_description : authentications.where("description IS NOT NULL").first.try(:description)
  end

  def url
    !main_url.blank? ? main_url : authentications.where("url IS NOT NULL").first.try(:url)
  end

  def first_name
    n = name || authentications.where("name IS NOT NULL").first.try(:name)
    n = "Anonymous" if n.blank?
    n.sub(/ .*/, '')
  end

  def identifier
    n = name || authentications.where("name IS NOT NULL").first.try(:name)
    n.blank? ? email : n
  end

  def email_header
    "\"#{name}\" <#{email}>"
  end

  def admin?
    role == 'admin' ? true : false
  end

  # Geocoding methods

  def address
    [city, province, country].compact.join(', ')
  end

  def gmaps4rails_address
    self.zip_code
  end

  # Omniauth + Devise methods

  # Given an omniauth hash, returns the user and the auth if there is one or creates one.
  def self.find_or_create_with_omniauth!(hash, user = nil)
    raise ArgumentError, "Hash is missing." if hash.blank?
    auth, groups = Authentication.find_or_create_with_omniauth!(hash, user)
    user ||= auth.try(:user)
    user ||= User.create_with_omniauth!(hash)
    user.authentications << auth if user.id
    groups.each do |g| 
      g.update_attributes(:authentication_id => auth.id) 
    end
    return user, auth
  end

  # Given an omniauth hash, creates a user and returns it.
  def self.create_with_omniauth!(hash)
    raise ArgumentError, "Hash is missing or malformed." if hash.blank? || hash.try(:info).try(:blank?)
    user = new(:name => hash.info.try(:name),
               :phone => hash.info.try(:phone),
               :email => hash.info.try(:email),
               :main_image => hash.info.try(:image),
               :main_url => (hash.info.try(:urls).try(:public_profile) || hash.info.try(:urls).try(:twitter)),
               :main_description => hash.info.try(:description))
    user.save
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && authentications.nil?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

end