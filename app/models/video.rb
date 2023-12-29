class Video < ApplicationRecord
  has_one :movie, foreign_key: 'video_link_id'
  has_one :movie, foreign_key: 'trailer_link_id'
  # has_one :trailer, class_name: 'Movie', foreign_key: 'trailer_link_id'
  # has_one :music

  # STATUS = { pending: 0, processing: 1, processed: 2, failed: 3, completed }.freeze
  STATUS = { pending: 0, uploading: 1, failed: 2, completed: 3 }.freeze
  enum status: STATUS, _default: 'pending', _prefix: true

  validates :url, presence: true, uniqueness: { case_sensitive: false },
                  format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id status updated_at url]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['movie']
  end
end
