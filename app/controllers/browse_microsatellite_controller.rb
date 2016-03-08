class BrowseMicrosatelliteController < ApplicationController
  def index
    @families = Family.all.order('name ASC')
    @species = Species.where(:family_id => @families.first.id).order('name ASC')
  end
end
