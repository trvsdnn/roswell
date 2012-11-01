class SoftwareLicensesController < ApplicationController
  before_filter :authorize

  def index
    @licenses = SoftwareLicense.any_of({ :tags.in => current_user.allowed_tags }, { :tags => [] })
  end

  def tagged
    @licenses = SoftwareLicense.tagged_with(params[:tag])
    render :template => 'software_licenses/index'
  end

  def new
    @license = SoftwareLicense.new
  end

  def create
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

  private

  def software_license_params
    params.require(:software_license).permit(
      :title,
      :license_key,
      :licensed_to,
      :comments,
      :tag_list
    )
  end
end
