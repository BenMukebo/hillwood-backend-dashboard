class MovieOutcast < ApplicationRecord
  validates_presence_of :first_name, :last_name, :avatar_url
  validates :first_name, :last_name, length: { minimum: 3, maximum: 50 }
  validates :avatar_url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates_uniqueness_of :avatar_url, case_sensitive: false

  enum status: { default: 0, active: 1, inactive: 2 }, _default: 'default', _prefix: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
