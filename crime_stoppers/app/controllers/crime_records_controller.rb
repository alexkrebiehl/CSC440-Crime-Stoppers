class CrimeRecordsController < ApplicationController

  def index
    @crime_types = CrimeType.all	
  end

  def show
    @crime_type = CrimeType.find(params[:id])
    @crimes = CrimeRecord.where(:crime_type_id => @crime_type.id)
  end
  
  def import
    path = '/home/ec2-user/csc440/csc440/crime_stoppers/public/cpd.zip'
    File.write(path, open( 'http://www.opendatacincy.org/static/cincinnati/cpd.zip' ).read, {mode: 'wb'})
    `sudo unzip -o /home/ec2-user/csc440/csc440/crime_stoppers/public/cpd.zip -d /home/ec2-user/`
    Dir.glob('/home/ec2-user/cpd/*.csv').each do |file|
        debugger
      CrimeRecord.import(file)
    end
    redirect_to root_url, notice: "Records imported."
  end

end
