class WelcomeController < ApplicationController
  def index
    @poems_count = Poem.count
    @images_count = Image.count
  end
end
