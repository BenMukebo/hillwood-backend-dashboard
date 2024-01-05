class Season < ApplicationRecord
  belongs_to :serie
  belongs_to :video_link, class_name: 'Video', optional: true # , foreign_key: :video_link_id

  validates :title, presence: true, length: { minimum: 3, maximum: 60 }
  validates :description, length: { minimum: 12, maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description episods_counter id image_url serie_id status title updated_at video_link_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[serie video_link]
  end
end
