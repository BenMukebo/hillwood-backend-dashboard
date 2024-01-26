class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :trackable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # if using Devise::JWT add =>
  # self.skip_session_storage = [:http_auth, :params_auth]

  belongs_to :role
  has_many :movie_comments
  has_one :movie_like
  has_many :serie_comments
  has_one :serie_like

  after_initialize :set_default_role, if: :new_record?
  # after_save :update_posts_counter
  # after_create :recent_comments
  # to ensure that the welcome email is sent only on the initial confirmation and not on subsequent changes to the user record
  after_commit :send_welcome_email, if: -> { confirmed? && !welcome_email_send }
  # to sending the welcome email on any change to the confirmed_at attribute, including subsequent changes,
  # after_commit :send_welcome_email, if: :confirmed_at_previously_changed?

  # add sign up validation
  # , on: :update, unless: :admin? # , on: :create, unless: :admin?
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 24 }
  validates :password, presence: true, length: { minimum: 8 }, on: :create, allow_blank: false
  validates :password_confirmation, presence: true, allow_blank: true
  validates :phone_number, presence: true, uniqueness: true,
                           length: { minimum: 10, maximum: 13 }, on: :create, allow_blank: false
  validates_presence_of :age_group, on: :create
  validates :terms_of_service, acceptance: { accept: true }
  validates_inclusion_of :remember_me, in: [true, false], allow_blank: true
  validates_inclusion_of :welcome_email_send, in: [true, false]
  # validatables = %i[username email password password_confirmation terms_of_service privacy_policy remember_me welcome_email_send]
  # validates :validatables, presence: true

  AGE_GROUP = { infants: 0, children: 1, adolescents: 2, adults: 3, older: 4 }.freeze
  enum age_group: AGE_GROUP, _prefix: true
  VERIFY_STATUS = { unverified: 0, verified: 1, pending: 2 }.freeze
  enum verification_status: VERIFY_STATUS, _default: 'unverified', _prefix: true

  validates :age_group, inclusion: { in: age_groups.keys }
  validates :verification_status, presence: true, inclusion: { in: verification_statuses.keys }

  def admin?
    role.name == 'admin'
  end

  # def profile_avatar_url
  #   profile['avatar_url']
  # end

  # Override the as_json method to customize the token payload
  # def as_json(options = {})
  #   super(options).merge(
  #     user_id: id,
  #     email: email,
  #     username: username
  #     # Add any other custom claims you need
  #   )
  # end

  def self.ransackable_attributes(_auth_object = nil)
    %w[age_group allow_password_change confirmation_sent_at confirmation_token confirmed_at
       created_at current_sign_in_at current_sign_in_ip email encrypted_password id
       last_sign_in_at last_sign_in_ip location phone_number profile provider remember_created_at
       remember_me reset_password_sent_at reset_password_token role_id sign_in_count social_links
       terms_of_service tokens uid unconfirmed_email updated_at username verification_status
       welcome_email_send]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movie_comments movie_like role]
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
    update(welcome_email_send: true)
  end

  def set_default_role
    self.role = Role.find_or_create_by(name: 'user') if role.nil?
  end

  def update_role(role_name)
    self.role = Role.find_or_create_by(name: role_name).save!
  end
end
