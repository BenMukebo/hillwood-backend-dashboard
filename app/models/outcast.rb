class Outcast < ApplicationRecord
  # has_and_belongs_to_many :movies # , dependent: :destroy
  has_many :outcast_associations, dependent: :destroy
  has_many :movies, through: :outcast_associations, source: :media_association, source_type: 'Movie'
  has_many :series, through: :outcast_associations, source: :media_association, source_type: 'Serie'

  validates_presence_of :first_name, :last_name # , :avatar_url
  validates :first_name, :last_name, length: { minimum: 3, maximum: 50 }
  validates :avatar_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  # validates_uniqueness_of :avatar_url, case_sensitive: false

  enum status: { default: 0, active: 1, inactive: 2 }, _default: 'default', _prefix: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[avatar_url created_at date_of_birth first_name id last_name personal_details status updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movies outcast_associations series]
  end
end
