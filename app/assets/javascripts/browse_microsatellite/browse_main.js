BrowseMain = (function($) {
	return {
		initEvent : function() {
			$('#family').on('change', function() {
				BrowseMain.loadSpecies($(this).val());
			});
			
			$('#search').on('click', function(e) {
				e.preventDefault();
				$("#overlay").show();
				window.location.href = "/markers_list?species_id="+ $('#species').val();
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
		}
	};

})(jQuery);

$(function(){
	$(".chzn-select").chosen();
	BrowseMain.initEvent();
});