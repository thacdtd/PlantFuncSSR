Welcome = (function($) {
	return {
		initEvent : function() {
			$('#family').on('change', function() {
				Welcome.loadSpecies($(this).val());
			});
			
			$('#search').on('click', function(e) {
				e.preventDefault();
				$("#overlay").show();
				var redirectlink = "/markers_list?species_id="+ $('#species').val();
				
				if ($('#type_of_repeat').val() != null){
					redirectlink += "&ssr_type=" + $('#type_of_repeat').val();
				};
				if ($('#go_anno').val() != ""){
					redirectlink += "&go_anno=" + $('#go_anno').val();
				};
				if ($('#inter_pro_anno').val() != ""){
					redirectlink += "&inter_pro_anno=" + $('#inter_pro_anno').val();
				};
				if ($('#no_of_repeat').val() != ""){
					redirectlink += "&no_of_repeat=" + $('#no_of_repeat').val();
				};
				$("#overlay").show();
				window.location.href = redirectlink;
			});
		},

		loadSpecies : function(family_id) {
			var url = '/welcome/change_family?family_id=' + family_id;
			$.ajax({
				url : url,
				dataType : 'html',
				type : 'GET',
				success : function(response) {
					$('#species_cbo').html(response);
					$(".chzn-select").chosen();
				}
			});
		},
		
		loadGO : function(species_id) {
			var url = '/welcome/change_species?species_id=' + species_id;
			$.ajax({
				url : url,
				dataType : 'html',
				type : 'GET',
				success : function(response) {
					$('#goterm_cbo').html(response);
					$(".chzn-select").chosen();
				}
			});
		}
		
	};

})(jQuery);

$(function(){
	$(".chzn-select").chosen();
	$("#overlay").hide();
	Welcome.initEvent();
	
});