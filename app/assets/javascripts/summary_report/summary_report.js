SummaryReport = (function($) {
	return {
		initEvent : function() {
			var arr_data = $("#chart-value").data("charts_value");
			$('#stat_chart_container').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false,
		            type: 'pie'
		        },
		        title: {
		            text: ''
		        },
		        credits : {
					enabled : false
				},
		        tooltip: {
		            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
		        series: [{
		            name: "Brands",
		            colorByPoint: true,
		            data: [{
		                name: "Mono",
		                y: arr_data[0]
		            }, {
		                name: "Di",
		                y: arr_data[1],
		                sliced: true,
		                selected: true
		            }, {
		                name: "Tri",
		                y: arr_data[2]
		            }, {
		                name: "Tetra",
		                y: arr_data[3]
		            }, {
		                name: "Penta",
		                y: arr_data[4]
		            }, {
		                name: "Hexa",
		                y: arr_data[5]
		            }, {
		                name: "Complex",
		                y: arr_data[6]
		            }, {
		                name: "Compound",
		                y: arr_data[7]
		            }]
		        }]
		    });
		}
	};

})(jQuery);

$(function(){
	SummaryReport.initEvent();
});