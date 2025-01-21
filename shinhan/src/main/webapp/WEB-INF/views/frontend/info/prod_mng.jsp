<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.co.passcombine.shinhan.util.*"%>
<%
// jsp properties
String thema = "purple"; //SessionUtil.getProperties("mes.thema");
String pageTitle = SessionUtil.getProperties("mes.company");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title> <%=pageTitle %> </title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
	<jsp:include page="/common/header_inc" flush="true"> 
		<jsp:param name="page_title" value="0" />
	</jsp:include>
	
	<style type="text/css">
		.ichk_label {
			font-weight: unset;
    		font-size: 12px; }
	</style>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script> -->
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1022" />
		<jsp:param name="selected_menu_cd" value="1040" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        P2 제품정보
        <small>주문관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 주문관리</a></li><li class="active">P2 제품정보</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
				<!-- Progress Bar 
				 	<div id="hiddenDivLoading" style="visibility:hidden">
					다중 코드 입력 창 iframe 
					    <iframe id="iframeLoading" frameborder="0" style="z-index:-1; position:absolute; visibility:hidden"></iframe>
 					        <div id='load_List'><img src='/img/loading.gif' /></div>
						
 					</div> -->
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_exdown" class="btn btn-primary btn-sm" onclick="excelFileDownload();">엑셀 다운로드
							</button>
						   	<button type="button" id="btn_update" class="btn btn-primary btn-sm" onclick="excelFormFileDownload();">양식 다운로드</button>
						   	<button type="button" id="btn_excel"class="btn btn-primary btn-sm" onclick="file_click_e();">엑셀 업로드
<!-- 								<img class="excel_btn_img" src="/res/images/common/excel.svg">엑셀 업로드 -->
							</button>
							<input type="file" id="ex_file_e" onchange="readExcel_e()" style="display: none;">
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="">조회</button>	 
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteP2Prod();">삭제</button>
						</div>
					</div>
					<div id="" class="box-body">
						<div class="row">
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>등록일자</label>
									 <input type="text" id="date_created" name="date_cteated" class="form-control input-sm" placeholder="" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="land" name="land" class="form-control input-sm" placeholder="사업장" -->
<!-- 										maxlength="3" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
									
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									<label>ITEM_NO</label> 
									<input type="combo" id="item_no" name="item_no" class="form-control input-sm" placeholder="item_no" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>
							<div class="col-sm-2">
								<div class="form-group">
									 <label>고객사</label> 
									 <input type="combo" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
								</div>
							</div>
							
							
							<div class="col-md-12">
								<div id="grid_list" style="width: 100%; height: 620px;"></div> 
							</div>
							
						</div>
					</div>
				</div>
			</section>
		</div>
	</section>
	
    <!-- /.content -->
  </div>


  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
</div>
<!-- ./wrapper -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<script type="text/javascript">
	comboValue_nm = new Array;
	comboValue_item_no = new Array;
	comboValue_land = new Array;
	
	$(function($) {
	 	fnLoadCommonOption(); 	 
	 	fnLoadCustomerGrid();
	})
	
	function fnLoadCommonOption() {
		console.log('fnLoadCommonOption()');
		
		$('#date_created').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYYMMDD', // inputbox 에 '2011/04/29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
		    startDate: moment().subtract(2, 'months').format('YYYYMMDD'),
		    endDate: getTodayDate()
		});
	}
	
	function fnLoadCustomerGrid(){
	// 	 console.log(page_url);
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
			columnGroups : [
			
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:2,caption:"자재크기"},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true},
			{ span:1,master:true}
           
           ],
	        show: {
	        	selectColumn: true,
				lineNumbers : false,
	            footer: true
	        },
	        multiSelect: true,
	        columns: [                
				{ field:'dataseq', caption:'Data관리번호', size:'4%', style:'text-align:center', sortable : true}, 
				{ field:'prod_gubun', caption:'제품구분', size:'8%', style:'text-align:center', sortable : true}, 
				{ field:'step', caption:'Step', size:'4%', style:'text-align:center', sortable : true}, 
				{ field:'after_process', caption:'후공정', size:'4%', style:'text-align:center', sortable : true}, 
				{ field:'stack', caption:'STACK', size:'4%', style:'text-align:center', sortable : true},
				{ field:'customer_nm', caption:'고객사', size:'6%', style:'text-align:center', sortable : true}, 
				{ field:'prod_div', caption:'제품군', size:'6%', style:'text-align:center', sortable : true}, 
				{ field:'layer', caption:'Layer', size:'6%', style:'text-align:center', sortable : true},
				{ field:'model', caption:'model', size:'13%', style:'text-align:center', sortable : true},
				{ field:'item_no', caption:'Item No', size:'10%', style:'text-align:center', sortable : true},
				{ field:'lengh', caption:'합*연', size:'6%', style:'text-align:center', sortable : true},
				{ field:'s_pi', caption:'최소파이', size:'6%', style:'text-align:center', sortable : true},
				{ field:'item_nm', caption:'자재명', size:'10%', style:'text-align:center', sortable : true},
				{ field:'item_size_l', caption:'자재크기(L)', size:'6%', style:'text-align:center', sortable : true},
				{ field:'item_size_r', caption:'자재크기(R)', size:'6%', style:'text-align:center', sortable : true},
				{ field:'item_size_thin', caption:'자재두깨', size:'8%', style:'text-align:center', sortable : true},
				{ field:'hole', caption:'HOLE수', size:'8%', style:'text-align:center', sortable : true},
				{ field:'x_axis', caption:'X', size:'8%', style:'text-align:center', sortable : true},
				{ field:'y_axis', caption:'Y', size:'8%', style:'text-align:center', sortable : true},
				{ field:'date_created', caption:'등록일자', size:'8%', style:'text-align:center', sortable : true, name:'excel_no'},
				{ field:'creator', caption:'등록자', size:'8%', style:'text-align:center', sortable : true, name:'excel_no'}
				], 
// 			sortData: [{field: 'customer_code', direction: 'ASC'}],
			records: [],	//
			onReload: function(event) {
				//loadList();
			},
			onClick: function (event) {}
		});
		loadList();
	}
	
	function loadList() {
		var page_url = "/frontend/production/selectP2Prod";
		var postData = "date_created=" + encodeURIComponent($("#date_created").val())
			 + "&item_no=" + encodeURIComponent($("#item_no").val())
			 + "&customer_nm=" + encodeURIComponent($("#customer_nm").val());
		
	
		w2ui['grid_list'].lock('loading...', true);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : postData, 
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200 && (data.rows).length>0 ) {
					rowArr = data.rows;

					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						comboValue_item_no.push(row.item_no ? row.item_no+'' : '');
						comboValue_nm.push(row.customer_nm ? row.customer_nm+'' : '');
					});
					
					// set record
					w2ui['grid_list'].records = rowArr;
					
// 					if (startValue_combo != "") {
// 						console.log(":>");
		                // specifying an onOpen handler instead is equivalent to specifying an onBeforeOpen handler, which would make this code execute too early and hence not deliver.
// 						$("#customer_code").w2field().refresh();		                
// 						$("#customer_code").w2field().clear();
//  						//$("#customer_code").w2field().w2render('field');
// 						$("#customer_code").w2field().set({ id:'Status Update', text:'Status Update' });	// force change

// 					}
					
					// Drop List
					$('#item_no').w2field('combo', { items: _.uniq(comboValue_item_no, false), match : 'contains' });
					$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm, false), match : 'contains' });
					/*
					// http://w2ui.com/web/docs/1.5/form/fields-enum ( Multi Select )
					$('#customer_nm').w2field('customer_nm', {
				        items: comboValue_nm,
				        openOnFocus: true,
				        max: 2 // max 값이 2이면 값을 두개만 입력 가능하다.
				    });
					*/
					
				} else {
					w2ui.grid_list.clear();
				}
				w2ui['grid_list'].refresh();
				w2ui['grid_list'].unlock();
			},complete: function () {
				document.getElementById("item_no").style.removeProperty("height");
				document.getElementById("customer_nm").style.removeProperty("height");
			}
		});
		
	}

	function deleteP2Prod() {
		console.log('deleteP2Prod()');
	
		var key = w2ui.grid_list.getSelection();
		if( key.length==0 ) {
			fnMessageModalAlert("알림", "삭제하고자 하는 항목을 1개 선택하여야 합니다."); // Notification
			return;
		} else {
 
			var get_data = w2ui.grid_list.get(key);
			
			fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
				if(result) {
					console.log("get_data = " + get_data);
					
					var strUrl = "/frontend/production/deleteP2Prod";
					var postData = "gridData="+encodeURIComponent(JSON.stringify(get_data));
					
					$.ajax({
						 url: strUrl,
						 type: "POST",
						 dataType : 'json', 
						 data : postData, 
						 async : false,
						 success:function(data, textStatus, jqXHR){
						 	if(data.status == "200") {
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
						 	}else{
						 		fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
						 	}
						 },
						 error: function(jqXHR, textStatus, errorThrown){
						    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
						 },
						 complete: function() {
						 }
					}); // ajax
					
				} // fnMessageModalConfirm
			});
		} // else
	}
	
	//엑셀 1024
	function excelFileDownload()
	{
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;
		var gridData = w2ui['grid_list'].records;
		
		var date = new Date();
		var year = date.getFullYear().toString();
		var month = date.getMonth() + 1;
			month = month < 10 ? '0' + month.toString() : month.toString();
		var day = date.getDate();
			day = day < 10 ? '0' + day.toString() : day.toString();

		var fileName = 'p2제품정보 관리_'+year+month+day+'.xlsx';
		var sheetTitle = 'p2제품정보 관리';
		var sheetName = 'p2제품정보 관리';
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			for(var i=0; i<gridCols.length; i++){
	 			if(!gridCols[i].hidden){
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width==undefined?"10":(gridCols[i].width).replace('px','')) + ",";
	 			}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length -1);
			param_col_id = param_col_id.substr(0, param_col_id.length -1);
			param_col_align = param_col_align.substr(0, param_col_align.length -1);
			param_col_width = param_col_width.substr(0, param_col_width.length -1);
		}


		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
		
		$.ajax({
		  url:export_url,
		  data:export_data,
		  type:'POST',
		  dataType: 'json',
		  success: function( data ) {
		  	if(data.status == 200) {
		  		var file_path = data.file_path;
		  		var file_name = data.file_name;
		  		var protocol = jQuery(location).attr('protocol');
	  			var host = jQuery(location).attr('host');
	  			var link_url = "/file/attach_download";
	  			link_url += "?file_path="+encodeURIComponent(file_path);
	  			link_url += "&file_name="+encodeURIComponent(file_name);
	  			
	  			$(location).attr('href', link_url);
		  	}
		  },
			complete: function () {}
		});
	}
	
	function excelFormFileDownload() {
		console.log("excelFileDownload()");
		var gridCols = w2ui['grid_list'].columns;

		var gridData = [];

		var fileName = 'test_mng(form).xlsx';
		var sheetTitle = '테스트 관리(양식)';
		var sheetName = '테스트 관리(양식)';

		var param_col_name = "", param_col_id = "", param_col_align = "", param_col_width = "";

		var is_rownum = true;

		if (gridCols != null && gridCols.length > 0) {
			for (var i = 0; i < gridCols.length; i++) {
				if (!gridCols[i].hidden && gridCols[i].name != 'excel_no') {
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width == undefined ? "11": (gridCols[i].width).replace('px', ''))+ ",";
				}
			}
//	 		param_col_name = param_col_name.substr(0, param_col_name.length - 5);
//	 		param_col_id = param_col_id.substr(0, param_col_id.length - 5);
//	 		param_col_align = param_col_align.substr(0,param_col_align.length - 5);
//	 		param_col_width = param_col_width.substr(0,param_col_width.length - 5);
		}

		var export_url = "/export/export_client_jqgrid";
		var export_data = "file_name="+ encodeURIComponent(encodeURIComponent(fileName));
			export_data += "&sheet_title=" + encodeURIComponent(sheetTitle);
			export_data += "&sheet_name=" + encodeURIComponent(sheetName);
			export_data += "&header_col_names="+ encodeURIComponent(param_col_name);
			export_data += "&header_col_ids=" + encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+ encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+ encodeURIComponent(param_col_width);
			export_data += "&cmd=" + encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+ encodeURIComponent(JSON.stringify(gridData));

		$.ajax({
			url : export_url,
			data : export_data,
			type : 'POST',
			dataType : 'json',
			success : function(data) {
				if (data.status == 200) {
					var file_path = data.file_path;
					var file_name = data.file_name;
					var protocol = jQuery(location).attr('protocol');
					var host = jQuery(location).attr('host');
					var link_url = "/file/attach_download";
					link_url += "?file_path=" + encodeURIComponent(file_path);
					link_url += "&file_name=" + encodeURIComponent(file_name);

					$(location).attr('href', link_url);
				}
			},
			complete : function() {
			}
		});
	}
	
	function file_click_e(){
		$('#ex_file_e').click(); 
	}

	function readExcel_e() {
		
	    let input = event.target;
	    let reader = new FileReader();
	    var rst_arr = [];

	    reader.onload = function() {

	        let data = reader.result;
	        let workBook = XLSX.read(data, {
	            type: 'binary'
	        });

	        workBook.SheetNames.forEach(function(sheetName) {

	            console.log('SheetName: ' + sheetName);

	            let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
//		            console.log(JSON.stringify(rows));
//		            console.log(rows.length);
	            for (var i = 1; i < rows.length; i++) {

//		                try {
						var obj = {};
	                    var row = JSON.stringify(rows[i]);
	                    console.log(JSON.stringify(row));
	                    var jsonObj = JSON.parse(row);
	                    console.log('jsonObj : ',jsonObj);
	                    
// 	                    y_axis
	                    obj['dataseq'] = jsonObj[Object.keys(jsonObj)[0]];
	                    obj['prod_gubun'] = jsonObj.__EMPTY;
	                    obj['step'] = jsonObj.__EMPTY_1;
	                    obj['after_process'] = jsonObj.__EMPTY_2;
	                    obj['stack'] = jsonObj.__EMPTY_3;
	                    obj['customer_nm'] = jsonObj.__EMPTY_4;
	                    obj['prod_div'] = jsonObj.__EMPTY_5;
	                    obj['layer'] = jsonObj.__EMPTY_6;
	                    obj['model'] = jsonObj.__EMPTY_7;
	                    obj['item_no'] = jsonObj.__EMPTY_8;
	                    obj['lengh'] = jsonObj.__EMPTY_9;
	                    obj['s_pi'] = jsonObj.__EMPTY_10;
	                    obj['item_nm'] = jsonObj.__EMPTY_11;
	                    obj['item_size_l'] = jsonObj.__EMPTY_12;
	                    obj['item_size_r'] = jsonObj.__EMPTY_13;
	                    obj['item_size_thin'] = jsonObj.__EMPTY_14;
	                    obj['hole'] = jsonObj.__EMPTY_15;
	                    obj['x_axis'] = jsonObj.__EMPTY_16;
	                    obj['y_axis'] = jsonObj.__EMPTY_17;
	                    
	                    rst_arr.push(obj);

	            }//for문끝
		        saveProd_excel_e(rst_arr);
	            
	        })
	    };

	    reader.readAsBinaryString(input.files[0]);

	}

	function saveProd_excel_e(gridData){
		console.log('saveProd_excel_e() : ',gridData);

		var keys = Object.keys(gridData[0]);
		
		for(var i = 0; i < gridData.length; i++){
			for(var a = 0; a < keys.length; a++){
				if(gridData[i][keys[a]] == undefined){
					gridData[i][keys[a]] = '';
				}
			}
		}
		
		var strUrl = "/frontend/production/excelUploadP2Prod";
		
		var postData = "gridData="+ encodeURIComponent(JSON.stringify(gridData));
		
		$.ajax({
		    url : strUrl,
		    type : "POST", 
		    dataType : 'json', 
		    data : postData, 
		    async: false,
		    success:function(data, textStatus, jqXHR){
		    	console.log(data);
		    	if(data.status == "200" && data.cnt == 0) {
			    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다.");
			    	loadList();
		    	}
		    	else if(data.status == "200" && data.cnt > 0) {
			    	fnMessageModalAlert("결과", "중복되는 데이터 " + data.cnt + "개를 제외한 나머지가 정상적으로 처리되었습니다.");
			    	loadList();
		    	}else{
		    		fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
		    	}
		    },
		    error: function(jqXHR, textStatus, errorThrown){
			    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	// Notification(MES)
		    		event.stopPropagation();
		    },
		    complete: function() {
		    	$('#ex_file_e').val('');
		    }
		});		
	}
</script>

</body>
</html>