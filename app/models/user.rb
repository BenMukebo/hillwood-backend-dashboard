class User < ActiveRecord::Base
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :confirmable
  include DeviseTokenAuth::Concerns::User

  belongs_to :role

  after_initialize :set_default_role, if: :new_record?

  # add sign up validation
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 24 }, on: :update, unless: :admin? #, on: :create, unless: :admin?
  validates :email, presence: true
  # validates :avatar_url, presence: true, uniqueness: true, length: { within: 10..14 }
  validates :password_confirmation, presence: true, allow_blank: true
  validates :terms_of_service, acceptance: { accept: true }
  # validates :privacy_policy, presence: true, inclusion: { in: [true, false] }
  validates_inclusion_of :remember_me, in: [true, false], allow_blank: true
  validates_inclusion_of :welcome_email_send, in: [true, false]
  # validates_inclusion_of :email_confirmed, in: [true, false]

  AGE_GROUP = { infants: 0, children: 1, adolescents: 2, adults: 3, older: 4 }.freeze
  enum age_group: AGE_GROUP, _prefix: true
  # validates :age_group, :inclusion => {:in => AGE_GROUP}

  def admin?
    role.name == 'admin'
  end

  private

  def set_default_role
    self.role = Role.find_or_create_by(name: 'user') if role.nil?
  end

  def update_role(role_name)
    self.role = Role.find_or_create_by(name: role_name).save!
  end
end
