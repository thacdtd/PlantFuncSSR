class WelcomeController < ApplicationController
  include ApplicationHelper
  def index
    @families = Family.all.order('name ASC')
    @species = Species.where(:family_id => @families.first.id).order('name ASC')
    # @go_terms = Goterm.all.order('Goterm ASC').limit(100)
    # @itpro = InterPro.all.order('InterPro ASC').limit(100)
  end

  def change_family
    @species = create_data_cbo(Species.where(:family_id => params[:family_id]).order('name ASC'), {:name=>"name",:id=>"id"})
    render :partial => "load_species", :locals => { :family_id => params[:family_id] }
  end

  def change_species
    @go_terms_cbo = []
    @annotations = Annotation.where(:species_id => params[:species_id])
    @annotations.each do |anno|
      go_term_annos = GotermAnnotation.where(:annotation_id => anno.id)
      go_term_annos.each do |go_anno|
        @go_terms_cbo << [Goterm.find(go_anno.goterm_id).GOterm, go_anno.goterm_id]
      end
    end
    render :partial => "load_GO", :locals => { :species_id => params[:species_id] }
  end

  def update
    redirect_to "markers_list"
  end
end
