class NotesController < ApplicationController
  before_filter :authorize
  before_filter :set_groups, :except => [ :create, :update, :show ]

  def index
    if current_user.admin?
      @notes = Note.all
    else
      @notes = Note.any_of({ :group_ids.in => current_user.group_ids }, { :group_ids => [] })
    end
  end

  def grouped
    @group = allowed_groups.where(:name => params[:group]).first
    not_found unless @group
    @notes = Note.where(:group_ids.in => [@group.id])
    render :template => 'notes/index'
  end

  def new
    @note = Note.new
    @allowed_groups = allowed_groups
  end

  def create
    @note = Note.new(note_params)
    @allowed_groups = allowed_groups

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
    @allowed_groups = allowed_groups
  end

  def update
    @note = Note.find(params[:id])
    @allowed_groups = allowed_groups

    if @note.update_attributes(note_params)
      redirect_to @note, :notice => 'Note updated'
    else
      render :edit
    end
  end

  private

  def set_groups
    if current_user.admin?
      @groups = Group.all.where(:_id.in => Note.group_ids)
    else
      @groups = current_user.groups.where(:_id.in => Note.group_ids)
    end
  end

  def note_params
    params.require(:note).permit(
      :title,
      :body,
      :group_ids
    ).merge(
      :last_updated_by_ip => request.remote_ip,
      :current_user => current_user
    )
  end
end
