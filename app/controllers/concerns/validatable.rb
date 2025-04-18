module Validatable
  extend ActiveSupport::Concern

  included do
    validates_presence_of :first_name, :last_name # , :avatar_url
    validates :first_name, :last_name, length: { minimum: 2, maximum: 24 }
    validates :avatar_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
    # validates_uniqueness_of :avatar_url, case_sensitive: false

    enum status: { default: 0, active: 1, inactive: 2 }, _default: 'default', _prefix: true
    validates :status, presence: true, inclusion: { in: statuses.keys }
  end
end
