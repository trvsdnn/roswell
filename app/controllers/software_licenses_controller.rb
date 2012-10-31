class SoftwareLicensesController < ApplicationController
  before_filter :authorize

  def index
    @licenses = SoftwareLicense.all
  end

  def new
    @license = SoftwareLicense.new
  end

  def create
    @license = SoftwareLicense.new(software_license_params)

    if @license.save
      redirect_to @license, :notice => 'Note created'
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
      :license_to,
      :comments,
      :tag_list
    )
  end
end
