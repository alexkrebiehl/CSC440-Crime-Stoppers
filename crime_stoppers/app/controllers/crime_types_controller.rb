class CrimeTypesController < ApplicationController
  def edit
    @crime_type = CrimeType.find(params["id"])
  end

  def update
    @crime_type = CrimeType.find(params["id"])
    @crime_type.update_attributes!(crime_type_params)
    redirect_to root_url, notice: "Successfully updated the crime type"
  end

  def crime_type_params
    params.require(:crime_type).permit!
  end

end
