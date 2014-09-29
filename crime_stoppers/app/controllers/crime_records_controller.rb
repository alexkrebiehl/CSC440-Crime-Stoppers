class CrimeRecordsController < ApplicationController
  def import
    CrimeRecord.import(params[:file])
    redirect_to root_url, notice: "Records imported."
  end
end
