
/*****chart******/
anychart.onDocumentReady(function() {
	
	var cg1 = $('#cg0').val();
	var cg2 = $('#cg1').val();
	var cg3 = $('#cg2').val();
	var cg4 = $('#cg3').val();
	var cg5 = $('#cg4').val();
	var cg6 = $('#cg5').val();
	var cg7 = $('#cg6').val();
	var cg8 = $('#cg7').val();
	var cg9 = $('#cg8').val();
	
	var cnt1 = $('#cnt0').val();
	var cnt2 = $('#cnt1').val();
	var cnt3 = $('#cnt2').val();
	var cnt4 = $('#cnt3').val();
	var cnt5 = $('#cnt4').val();
	var cnt6 = $('#cnt5').val();
	var cnt7 = $('#cnt6').val();
	var cnt8 = $('#cnt7').val();
	var cnt9 = $('#cnt8').val();
	
  anychart.theme('monochrome');
  anychart.color.lighten('#674637', 0.2);
  // create data set on our data
  chartData = {
    title:'*상위 9개의 카테고리만 노출됩니다',
    header: ['#', '보유권수'],
    rows: [
      [cg1, cnt1],
      [cg2, cnt2],
      [cg3, cnt3],
      [cg4, cnt4],
      [cg5, cnt5],
      [cg6, cnt6],
      [cg7, cnt7],
      [cg8, cnt8],
      [cg9, cnt9],
    ]
  };

  // create radar chart
  var chart = anychart.radar();
  var line = chart.line(chartData);
  line.stroke("2 #754f44");
  // set default series type
  chart.defaultSeriesType('line');

  // set chart data
  chart.data(chartData);

  // force chart to stack values by Y scale.
  chart.yScale().stackMode('value');

  // set yAxis settings
  var yAxis = chart.yAxis().stroke('#545f69');
  yAxis.enabled(false);
  chart.yAxis().ticks().stroke('#545f69');

  // set yAxis labels settings
  chart.yAxis().labels()
    .fontColor('#545f69')
    .format('{%Value}{scale:(1000000)|(M)}');

  // set chart legend settings
  chart.legend()
    .align('center')
    .position('center-bottom')
    .enabled(true);

  // set container id for the chart
  chart.container('container');
  // initiate chart drawing
  chart.draw();
});