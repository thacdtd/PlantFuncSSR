class SummaryReportController < ApplicationController
  def index
    @species = params[:species_id]
    if @species != nil
      @statistic = Statistic.where(:species_id => @species).first
      @stat_repeat_list = []
      stat = Ssr.where(:species_id => @species, :SSR_type => "p1").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "p2").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "p3").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "p4").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "p5").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "p6").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "c").length
      @stat_repeat_list.append(stat)
      stat = Ssr.where(:species_id => @species, :SSR_type => "c*").length
      @stat_repeat_list.append(stat)
      
      @array = []
      @sum_type = 0
      @stat_repeat_list.each do |stat_repeat|
        @sum_type += stat_repeat
        @array.append(stat_repeat*100/@sum_type)
      end
    end
    @species_name = Species.get_species_name(@species)
  end
end
