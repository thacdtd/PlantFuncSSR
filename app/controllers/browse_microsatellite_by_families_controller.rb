class BrowseMicrosatelliteByFamiliesController < ApplicationController
  def index
    @alphabet = params[:browse_by_alphabet]
    if @alphabet != nil
      @Statistics = Statistic.get_statistics_by_families(@alphabet)
    else
      @Statistics = Statistic.all
    end
  end
end
