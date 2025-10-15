class PoemsController < ApplicationController
  def index
    @poems = Poem.all
  end

  def new
    @poem = Poem.new
  end

  def create
    @poem = Poem.new(poem_params)
    if @poem.save
      redirect_to @poem, notice: "Poem was successfully created."
    else
      render :new
    end
  end

  def show
    @poem = Poem.find(params[:id])
    @comments_starting_positions = @poem.comments.pluck(:start_position)
    @comments_ending_positions = @poem.comments.pluck(:end_position)
    @comment = @poem.comments.new
  end

  private

  def poem_params
    params.require(:poem).permit(:content, :title)
  end
end
