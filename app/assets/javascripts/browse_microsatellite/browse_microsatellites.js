BrowseMicrosatellite = (function($) {
	return {
		initEvent : function() {
			$('#example').DataTable({
					"dom": 'Bltip',
			        buttons: [
			            'copyHtml5',
			            'excelHtml5',
			            'csvHtml5'
			        ]
			});
			$('#tbl_browse_by_families').DataTable({
					"dom": 'Bltip',
			        buttons: [
			            'copyHtml5',
			            'excelHtml5',
			            'csvHtml5'
			        ]
			});
		}
	};

})(jQuery);

$(function(){
	BrowseMicrosatellite.initEvent();
});