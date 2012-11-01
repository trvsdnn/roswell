class NotesController < ApplicationController
  before_filter :authorize

  def index
    @notes = Note.any_of({ :tags.in => current_user.allowed_tags }, { :tags => [] })
  end

  def tagged
    @notes = Note.tagged_with(params[:tag])
    render :template => 'notes/index'
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to @note, :notice => 'Note created'
    else
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, :tag_list)
  end
end
