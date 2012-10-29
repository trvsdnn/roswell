class SoftwareLicensesController < ApplicationController
  def new
    @license = SoftwareLicense.new
  end

  def create
    @license = SoftwareLicense.new(software_license_params)

    if @license.save
      redirect @license, :notice => 'Note created'
    else
      render :new
    end
  end

  def show
    @license = SoftwareLicense.find(params[:id])
  end

  private

  def software_license_params
    params.permit(:software_license)
  end
end
