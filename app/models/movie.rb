class Movie < ApplicationRecord
  attr_accessor :MOVIE_ATTRS

  has_many :comments, dependent: :destroy
  has_many :show_times, dependent: :destroy
  belongs_to :category

  validates :title, presence: true
  validates :release_time, presence: true

  delegate :name, to: :category
  scope :sort_list, ->{order :release_time}

  MOVIE_ATTRS = %i(title description img_link
                   duration_min release_time language
                   director cast age_range category_id).freeze
end
