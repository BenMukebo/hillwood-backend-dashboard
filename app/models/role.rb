class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception

  NAME = { user: 0, super_admin: 2, subscriber: 3, admin: 4 }.freeze
  enum name: NAME, _prefix: true

  validates :name, presence: true, uniqueness: { case_sensitive: false }, inclusion: { in: names.keys }
end
