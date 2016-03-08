MarkersList = (function($) {
  return {
    initEvent : function() {
      $('#tbl_markers_list').DataTable({
	"dom": 'Bltip',
	buttons: [
		  'copyHtml5',
		  'excelHtml5',
		  'csvHtml5'
	],
	"bProcessing": true,
	"iDisplayLength": 50
      });

      $('#btn_search_marker').on('click', function() {
	$(".chzn-select").chosen();
	$('#modal_search_marker').modal('show');
      });

      $('#search').on('click', function(e) {
	e.preventDefault();
	var redirectlink = "/markers_list?species_id="+ $('#species_id').data("species_id");
	if ($('#type_of_repeat').val() != null) {
	  redirectlink += "&ssr_type=" + $('#type_of_repeat').val();
	};
	if ($('#motif_size').val() != "") {
	  redirectlink += "&motif_size=" + $('#motif_size').val();
	};
	if ($('#fdm_annotation').is(':checked')) {
	  redirectlink += "&fdm_annotation=1";
	};
	window.location.href = redirectlink;
      });

      $('#tbl_markers_list').on('click','.primer', function (event) {
	var $ssr_id = $(this).closest("tr").find("#ssr_id").data("ssr_id");
	var SSR = $(this).closest('tr').find('td:eq(1)').text();
	$('#SSR_ID').text(SSR);
	$.ajax({
	  url : 'markers_list/ajax_change_primer',
	  dataType : 'JSON',
	  data : {
	    'ssr_id' : $ssr_id
	  },
	  type : 'post',
	  async : false,
	  success : function(response) {
	    $('#Foward1').text("");
	    $('#Reverse1').text("");
	    $('#FP_Tm1').text("");
	    $('#FP_Size1').text("");
	    $('#RP_Tm1').text("");
	    $('#RP_Size1').text("");

	    $('#Foward2').text("");
	    $('#Reverse2').text("");
	    $('#FP_Tm2').text("");
	    $('#FP_Size2').text("");
	    $('#RP_Tm2').text("");
	    $('#RP_Size2').text("");

	    $('#Foward3').text("");
	    $('#Reverse3').text("");
	    $('#FP_Tm3').text("");
	    $('#FP_Size3').text("");
	    $('#RP_Tm3').text("");
	    $('#RP_Size3').text("");

	    if (response != null){
	      $('#Foward1').text(response.Forward1);
	      $('#Reverse1').text(response.Reverse1);
	      $('#FP_Tm1').text(response.FP_Tm1);
	      $('#FP_Size1').text(response.FP_Size1);
	      $('#RP_Tm1').text(response.RP_Tm1);
	      $('#RP_Size1').text(response.RP_Size1);

	      $('#Foward2').text(response.Forward2);
	      $('#Reverse2').text(response.Reverse2);
	      $('#FP_Tm2').text(response.FP_Tm2);
	      $('#FP_Size2').text(response.FP_Size2);
	      $('#RP_Tm2').text(response.RP_Tm2);
	      $('#RP_Size2').text(response.RP_Size2);

	      $('#Foward3').text(response.Forward3);
	      $('#Reverse3').text(response.Reverse3);
	      $('#FP_Tm3').text(response.FP_Tm3);
	      $('#FP_Size3').text(response.FP_Size3);
	      $('#RP_Tm3').text(response.RP_Tm3);
	      $('#RP_Size3').text(response.RP_Size3);
	    }

	    $('#modal_primer').modal('show');
	  }
	});
      });

      $('#tbl_markers_list').on('click','.annotation', function (event) {
	var $SSR = $(this).closest('tr').find('td:eq(1)').text();
	$.ajax({
	  url: 'markers_list/ajax_change_annotation',
	  dataType: 'JSON',
	  data: {
	    'ssr' : $SSR
	  },
	  type : 'post',
	  async : false,
	  success : function(response) {
	    $('#anno_id').text($SSR);
	    $('#go_term').text("");
	    $('#unit_prot').text("");
	    $('#inter_pro').text("");
	    if (response.length != 0) {
	      if (response[0] != null) {
		$('#mpgn').text(response[0].MPG_name);
		$('#mpgd').text(response[0].MPG_description);
                if (response[0].Goterm != null) {
                  var arr_goterm = response[0].Goterm.split(';');
		  $.each( arr_goterm, function( i, l ) {
		    $link_go_term = '<a target="_blank" href="http://www.ebi.ac.uk/QuickGO/GTerm?id=' + l + '">' + l + '</a>'
		    $('#go_term').append($link_go_term);
		    $('#go_term').append("<br>");
		  });
                }

                if (response[0].UnitProt != null) {
		  var arr_unitprot = response[0].UnitProt.split(';');
                  $.each( arr_unitprot, function( i, l ) {
		    $('#unit_prot').append(l);
		    $('#unit_prot').append("<br>");
		  });
                }

                if (response[0].InterPro != null) {
                  var arr_interpro = response[0].InterPro.split(';');
		  $.each( arr_interpro, function( i, l ) {
		    $link_inter_pro = '<a target="_blank" href="http://www.ebi.ac.uk/interpro/entry/' + l + '">' + l + '</a>'
		    $('#inter_pro').append($link_inter_pro);
		    $('#inter_pro').append("<br>");
		  });
                }
              }
	    };
	    $('#modal_annotation').modal('show');
	  }
	});
      });
    }
  };
})(jQuery);

$(function(){
  MarkersList.initEvent();
  $(".chzn-select").chosen({width: "300px"});
  $("#overlay").hide();
});
