class BrowseMicrosatelliteBySpeciesController < ApplicationController
  def index
    @alphabet = params[:browse_by_alphabet]
    if @alphabet != nil
      @Statistics = Statistic.get_statistics_by_species(@alphabet)
    else
      @Statistics = Statistic.all
    end
  end

  def safe_params
    params[:browse_microsatellite].permit(:browse_by_alphabet)
  end
end
