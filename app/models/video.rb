class Video < ApplicationRecord
  # STATUS = { pending: 0, processing: 1, processed: 2, failed: 3, completed }.freeze
  STATUS = { pending: 0, uploading: 1, failed: 2, completed: 3 }.freeze
  enum status: STATUS, _default: 'pending', _prefix: true

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :mime_type, presence: true

  validates :status, presence: true, inclusion: { in: statuses.keys }
end
