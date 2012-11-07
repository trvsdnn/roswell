class SoftwareLicensesController < ApplicationController
  before_filter :authorize

  def index
    if current_user.admin
      @licenses = SoftwareLicense.all
    elsif current_user.allowed_tags.nil?
      @licenses = SoftwareLicense.where(:tags => [] )
    else
      @licenses = SoftwareLicense.any_of({ :tags.in => current_user.allowed_tags }, { :tags => [] })
    end
  end

  def tagged
    @tag = params[:tag]
    @licenses = SoftwareLicense.tagged_with(@tag)
    render :template => 'software_licenses/index'
  end

  def new
    @license = SoftwareLicense.new
  end

  def create
    puts software_license_params.inspect
    @license = SoftwareLicense.new(software_license_params)

    if @license.save
      redirect_to @license, :notice => 'License added'
    else
      render :new
    end
  end

  def show
    @license = SoftwareLicense.find(params[:id])
  end

  def edit
    @license = SoftwareLicense.find(params[:id])
  end

  def update
    @license = SoftwareLicense.find(params[:id])

    if @license.update_attributes(software_license_params)
      redirect_to @license, :notice => 'License updated'
    else
      render :edit
    end
  end

  private

  def software_license_params
    params.require(:software_license).permit(
      :title,
      :license_key,
      :licensed_to,
      :comments,
      :tag_list
    ).merge(
      :updated_by_ip => request.remote_ip,
    )
  end
end
