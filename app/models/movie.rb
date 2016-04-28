class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :image, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past

  mount_uploader :image, ImageUploader

  scope :by_titles, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :by_directors, -> (director) { where("director LIKE ?", "%#{director}%") }
#puts "** #{table_name}"
  #scope :blas -> (range) { where("runtime_in_minutes")}
  #scope :by_whatever, -> (column_name, director) { where("? LIKE ?", column_name, "%#{director}%") }

  #scope :from_stuff, -> (title) { where("? LIKE ?", table, "%#{thing}%") }

 # scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
 # scope :fresh, -> { where('age < ?', 25) }
  def review_average
    begin
      reviews.sum(:rating_out_of_ten) / reviews.size
    rescue ZeroDivisionError
      0.0
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
