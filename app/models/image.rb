class Image < ApplicationRecord
  has_one_attached :image_file

  validates :title, presence: true
end
