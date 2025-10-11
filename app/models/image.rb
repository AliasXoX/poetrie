class Image < ApplicationRecord
  mount_uploader :image_file, ImageFileUploader

  validates :image_file, presence: true
  validates :title, presence: true
end
