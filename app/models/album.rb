class Album < ApplicationRecord
  has_and_belongs_to_many :artists

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :photo_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  validates :release_date, presence: true
  validates :songs_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum status: { unpublished: 0, published: 1, banned: 2 }, _default: 'unpublished', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }
end
