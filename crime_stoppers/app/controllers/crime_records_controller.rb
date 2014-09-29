class CrimeRecordsController < ApplicationController

  def index
    @crime_types = CrimeType.all	
  end

  def show
    @crime_type = CrimeType.find(params[:id])
    @crimes = CrimeRecord.where(:crime_type_id => @crime_type.id)
  end
  
  def import
    CrimeRecord.import(params[:file])
    redirect_to root_url, notice: "Records imported."
  end

end
