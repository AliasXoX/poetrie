class Poem < ApplicationRecord
  after_create :save_poem_to_file

  validates :title, presence: true

  attr_accessor :content

  def show_content
    return File.read(self.url) if File.exist?(self.url)
  end

  private

  def save_poem_to_file
    dir_path = Rails.root.join('public', 'uploads', "poem_#{id}")
    FileUtils.mkdir_p(dir_path) # Ensure directory exists
    filename = dir_path.join("#{title}.txt")
    File.open(filename, 'w') { |file| file.write(content) }
    update_column(:url, "public/uploads/poem_#{id}/#{title}.txt")
  end

end
