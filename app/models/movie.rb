class Movie < ApplicationRecord
  MOVIE_ATTRS = %i(title description rating image
                   duration_min release_time language
                   director cast age_range).freeze

  has_many :comments, dependent: :destroy
  has_many :show_times, dependent: :restrict_with_exception
  has_many :movie_categories, dependent: :destroy
  has_many :categories, through: :movie_categories

  accepts_nested_attributes_for :movie_categories

  has_one_attached :image

  validates :title, presence: true
  validates :release_time, presence: true
  validates :image, content_type: {in: Settings.image.format,
                                   message: I18n.t("valid_img_format")},
                    size: {less_than: Settings.digits.volume_img_max.megabytes,
                           message: I18n.t("valid_img_volume")}

  scope :sort_list, ->{order :release_time}

  scope :search, lambda {|search| search ? where("title LIKE ?", "%#{search}%") : all}

  def display_image
    image.variant resize_to_limit: Settings.digits.resize_limit
  end
end
