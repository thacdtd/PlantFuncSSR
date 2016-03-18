class BrowseMicrosatelliteController < ApplicationController
  def index
    @families = Family.where(:del_flag => 1).order('name ASC')
    @species = Species.where(:family_id => @families.first.id).order('name ASC')
  end
end
