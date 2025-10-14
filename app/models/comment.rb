class Comment < ApplicationRecord
  belongs_to :poem

  validates :start_position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :end_position, presence: true
  validates :content, presence: true, length: { maximum: 100000 }
end
