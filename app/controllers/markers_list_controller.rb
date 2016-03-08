class MarkersListController < ApplicationController
  def index
    @species = params[:species_id]
    @ssr_types = nil
    if @species != nil
      @species_name = Species.find(@species).name
      if params[:ssr_type] != nil
        @ssr_types = params[:ssr_type].split(',')
      end
      @go_anno = params[:go_anno]
      @inter_pro_anno = params[:inter_pro_anno]
      @no_of_repeat = params[:no_of_repeat]
      @motif_size = params[:motif_size]
      @fdm_annotation = params[:fdm_annotation]
      @Ssr = Ssr.get_SSR_by_species(@species, @ssr_types, @no_of_repeat, @go_anno,
                                    @inter_pro_anno, @motif_size, @fdm_annotation)
    else
      @Ssr = Ssr.all
    end
  end

  def ajax_change_primer
    @primers = Ssr.find(params[:ssr_id])
    render :json => @primers
  end

  def ajax_change_annotation
    @anno_list = Array.new
    @anno = Annotation.where(:name => params[:ssr]).first
    if @anno != nil
      @anno_list.push(@anno)
    end
    render :json => @anno_list
  end
end
