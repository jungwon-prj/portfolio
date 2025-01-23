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
</head>

<body class="hold-transition skin-<%=thema%> sidebar-mini">
<div class="wrapper">
	<jsp:include page="/common/top_menu_inc" flush="true">
		<jsp:param name="fb_div" value="F" />
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
	<jsp:include page="/common/sidebar_menu_inc" flush="true">
		<jsp:param name="menu_div" value="F" />
		<jsp:param name="selected_menu_p_cd" value="1041" />
		<jsp:param name="selected_menu_cd" value="1042" />
	</jsp:include>

 <div class="content-wrapper">
    <section class="content-header">
      <h1>
        P2 생산일지
        <small>주문관리</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 주문관리</a></li><li class="active">P2 생산일지</li>
      </ol>
    </section>

  	<section class="content">
		<div class="row">
			<section class="col-lg-12">
				<div class="box box-success box-solid" style="min-height: 90px; border-color: #DB8EB5;">
					<!-- Progress Bar -->

					<div class="box-header with-border" style=" background-color: #DB8EB5;">
						<h3 class="box-title">조회조건</h3>
						<div class="box-tools pull-right">
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="modalOpen();">작업지시서</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertModalOpen();">등록</button>
							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="updateModalOpen();">수정</button>
<!-- 							<button type="button" id="btn_create" class="btn btn-primary btn-sm" onclick="insertProd();">작업지시생성</button> -->
					     	<button type="button" id="btn_delete" class="btn btn-danger btn-sm" onclick="deleteP2ProdLog();">삭제</button>
							<button type="button" id="btn_search_csr" onclick="loadList();" class="btn btn-warning btn-sm" onclick="loadList();">조회</button>	 
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
									 <input type="text" id="item_no" name="item_no" class="form-control input-sm" placeholder="item_no" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="item_no" name="item_no" class="form-control input-sm" placeholder="사업장" -->
<!-- 										maxlength="3" onkeypress="if(event.keyCode==13) {loadList(); return false;}" > -->
								</div>
							</div>
							
							<div class="col-sm-2">
								<div class="form-group">
									 <label>고객사</label> 
									 <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사" 
												onkeypress="if(event.keyCode==13) {loadList(); return false;}" >
<!-- 									 <input type="text" id="customer_nm" name="customer_nm" class="form-control input-sm" placeholder="고객사명" -->
<!-- 										maxlength="15" onkeypress="if(event.keyCode==13) {loadList(); return false;}"  > -->
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
  <!-- /.content-wrapper -->
	<div class="modal fade" id="modal_info" tabindex="-1" role="dialog" aria-labelledby="regModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header" style="border-bottom: 3px solid #DB8EB5; margin-left: 15px; margin-right: 15px;">
	                <h4 class="popup_title_ad" style="font-size: 21px; position: relative; right: 10px;">P2 제품정보 등록</h4>
	            </div>
	            <div class="modal-body">
	                <form id="frm_reg" name="frm_reg" class="form-horizontal">
	                    <div class="row">
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">입고일자</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_in_date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">출고일자</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_out_date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">Item No</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_item_no">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">STEP</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_step" onclick="auto_key(this.id);">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">담당자</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_pic">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">Lot No</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_lot_no">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">매수(PNL)</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_pnl_cnt">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">DATA</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_data_d">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">특이사항</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_special_note">
									</div>
								</div>
							</div>
							
		                    <div class="row">
								<div class="form-group">
									<label class="col-sm-3 control-label">알람이력확인</label>
									<div class="input-group col-sm-7" style="width:56%; padding-left:15px;">
										<input type="text" class="form-control pull-right input-sm" style="" id="m_alarm_history">
									</div>
								</div>
							</div>
							
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer">
	                <div class="col-md-12 text-center">
	                    <button type="button" id="p2_prod_save" onclick="" class="btn btn-success btn-sm">생성</button>
	                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>



<!-- modal_dcode -->

<!-- modal_end -->
  <jsp:include page="/common/footer_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
  
  <jsp:include page="/common/sidebar_rview_inc" flush="true">
		<jsp:param name="page_title" value="0" />
	</jsp:include>
		
</div>
<!-- ./wrapper -->
<jsp:include page="/WEB-INF/views/common/modal_work_order_sheet.jsp"/>
<script src="/res/plugins/jquery-printme.js"></script>
<script type="text/javascript" src="/res/plugins/qrcode.js"></script>
<script type="text/javascript" src="/res/plugins/qrcode.min.js"></script>

<script type="text/javascript">
	
	comboValue_nm = new Array;
	comboValue_item_no = new Array;
	
	$(function($) {
	 	fnLoadCommonOption();
	 	fnLoadCommonOption_m();
	 	fnLoadProdGrid();
	})
	
	function fnLoadCommonOption() {
		
		$('#date_created').daterangepicker({
			opens: 'right', 
			locale: {
				format: 'YYYYMMDD', // inputbox 에 '2011-04-29' 로표시
				monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNames: ['일', '월', '화', '수', '목', '금', '토'],
				dayNames : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
				dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
				showMonthAfterYear: true,
				yearSuffix: '년',
				orientation: "top left"
			},
// 			startDate: moment().subtract(1, 'months').format('YYYY-MM-DD')
			startDate: moment().add(-1, 'months').format('YYYY-MM-DD') //한 달전
		});
	}
	
	function fnLoadCommonOption_m() {
		
		 $('#m_in_date, #m_out_date').daterangepicker({
			opens: 'right',
			singleDatePicker: true,
			locale: {
				format : 'YYYYMMDD'	,
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
				daysOfWeek: [ "일","월", "화", "수", "목", "금", "토" ],
				showMonthAfterYear : true,
				yearSuffix : '년'
		    },
		});
		 
//    		$('#m_out_date').on('cancel.daterangepicker', function(ev, picker) {
//                $(this).val('');
// 		});
		 
	}
	
	function columnGroupSetting(){
		var group_arr = [];
		
		for(var i = 0; i < 28; i++){
			var obj = {};
			if( 22 < i && i < 24){
				obj['span'] = 2;
				obj['caption'] = '자재크기';
			} else{
				obj['span'] = 1;
				obj['master'] = true;
			}
			group_arr.push(obj);
		}
		return group_arr;

	}
	
	function fnLoadProdGrid(){
		var rowArr = [];
		
		$('#grid_list').w2grid({ 
	        name: 'grid_list',
// 			columnGroups : [
// 				{ span:1,master:true},
// 				{ span:1,master:true},
// 				{ span:1,master:true},
// 				{ span:3,caption:"공정율"}
//            ],
			columnGroups : columnGroupSetting(),
	        show: {
	        	selectColumn: true,
				lineNumbers: true,
	            footer: true,
	            toolbar: false
	        },
	        multiSelect: true,
	        columns: [                
				{ field:'in_date', caption:'입고일자', size:'70px', style:'text-align:center', sortable: true, frozen: true }, 
				{ field:'out_date', caption:'출고일자', size:'70px', style:'text-align:center', sortable: true, frozen: true }, 
				{ field:'step', caption:'STEP', size:'70px', style:'text-align:center', frozen: true }, 
				{ field:'item_no', caption:'Item No', size:'160px', style:'text-align:center', frozen: true },
				{ field:'lot_no', caption:'Lot No', size:'160px', style:'text-align:center', frozen: true }, 
				{ field:'pic', caption:'담당자', size:'70px', style:'text-align:center', frozen: true },
				{ field:'pnl_cnt', caption:'매수(PNL)', size:'80px', style:'text-align:center', editable: {type:'text'}}, 
				{ field:'data_d', caption:'DATA', size:'200px', style:'text-align:center'},
				{ field:'special_note', caption:'특이사항', size:'220px', style:'text-align:center'},
				{ field:'alarm_history', caption:'알람이력확인', size:'70px', style:'text-align:center'},
				{ field:'prod_gubun', caption:'제품구분', size:'100px', style:'text-align:center'},
				{ field:'after_process', caption:'후공정', size:'70px', style:'text-align:center'},
				{ field:'model', caption:'Model', size:'220px', style:'text-align:center'},
				{ field:'qwe6', caption:'ST', size:'60px', style:'text-align:center'},
				{ field:'stack', caption:'stack', size:'60px', style:'text-align:center'},
				{ field:'customer_nm', caption:'고객사', size:'100px', style:'text-align:center'},
				{ field:'prod_div', caption:'제품군', size:'60px', style:'text-align:center'},
				{ field:'layer', caption:'Layer', size:'60px', style:'text-align:center'},
				{ field:'area_m2', caption:'면적(m2)', size:'80px', style:'text-align:center'},
				{ field:'lengh', caption:'합X연', size:'60px', style:'text-align:center'},
				{ field:'pcs_cnt', caption:'PCS 수', size:'60px', style:'text-align:center'},
				{ field:'s_pi', caption:'최소파이', size:'70px', style:'text-align:center'},
				{ field:'item_nm', caption:'자재명', size:'230px', style:'text-align:center'},
				{ field:'item_size_r', caption:'자재크기(R)', size:'85px', style:'text-align:center'},
				{ field:'item_size_l', caption:'자재크기(L)', size:'85px', style:'text-align:center'},
				{ field:'item_size_thin', caption:'자재두께', size:'70px', style:'text-align:center'},
				{ field:'hole', caption:'Hol수', size:'60px', style:'text-align:center'},
				{ field:'x_axis', caption:'X', size:'70px', style:'text-align:center'},
				{ field:'y_axis', caption:'Y', size:'70px', style:'text-align:center'}
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
		
		var page_url = "/frontend/production/selectP2ProdLog";
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
					var rowArr = data.rows;

					$.each(rowArr, function(idx, row){
						row.recid = idx+1;
						row.pcs_cnt = row.pnl_cnt*1 * row.lengh*1;
						
						row.area_m2 = row.pnl_cnt*1 * row.x_axis*1 * row.y_axis*1 / 1000000;

// 						row.area_m2 = Number(row.pnl_cnt) * Number(row.x_axis) * Number(row.y_axis) / 1000000;
						
						if (isNaN(row.pcs_cnt)) {
							row.pcs_cnt = row.lengh*1;
						}
						
						if (isNaN(row.area_m2)) {
							row.area_m2 = '';
						}
						
						comboValue_item_no.push(row.item_no ? row.item_no+'' : '');
						comboValue_nm.push(row.customer_nm ? row.customer_nm+'' : '');
					});
					
					// set record
					w2ui['grid_list'].records = rowArr;
					$('#item_no').w2field('combo', { items: _.uniq(comboValue_item_no, false), match : 'contains' });
					$('#customer_nm').w2field('combo', { items: _.uniq(comboValue_nm, false), match : 'contains' });
					
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
	
	function insertP2ProdLog() {
		
		var arr = [
					{
		       		'item_no' : $('#m_item_no').val(),
		    		'step' : $('#m_step').val(),
		    		'in_date' : $('#m_in_date').val(),
		    		'out_date' : $('#m_out_date').val(),
		    		'pic' : $('#m_pic').val(),
		    		'lot_no' : $('#m_lot_no').val(),
		    		'pnl_cnt' : $('#m_pnl_cnt').val(),
		    		'data_d' : $('#m_data_d').val(),
		    		'special_note' : $('#m_special_note').val(),
		    		'alarm_history' : $('#m_alarm_history').val()
					}
				];
		
		
		fnMessageModalConfirm("알림", "선택한 내용을 생성하시겠습니까?", function(result) {
			if(result) {
				
				var page_url = "/frontend/production/insertP2ProdLog";
				var postData = "gridData="+encodeURIComponent(JSON.stringify(arr));
				
				$.ajax({
					 url: page_url,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		if(data.result == "정상처리"){
						 		$("#modal_info").modal("hide");
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
					 		} else if(data.result == "코드없음"){
					 			fnMessageModalAlert("결과", "Item No 또는 STEP이 잘못되었습니다.");
					 		} else {
					 			fnMessageModalAlert("결과", "이미 등록된 항목이 존재합니다.");
					 		}
					 	} else {
					 		fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 	}
					 },
					 error: function(jqXHR, textStatus, errorThrown){
					    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 },
					 complete: function() {
					 }
				});
				
			}
		});
	}
	
	function updateP2ProdLog() {
		
		var get_grid = w2ui['grid_list'].get(w2ui['grid_list'].getSelection()[0]);
		
		fnMessageModalConfirm("알림", "해당 내용을 저장하시겠습니까?", function(result) {
			if(result) {
				
				var page_url = "/frontend/production/updateP2ProdLog";
				var postData = "p2key="+encodeURIComponent(get_grid.p2key)
					+ "&in_date="+encodeURIComponent($('#m_in_date').val())
					+ "&out_date="+encodeURIComponent($('#m_out_date').val())
					+ "&pic="+encodeURIComponent($('#m_pic').val())
					+ "&lot_no="+encodeURIComponent($('#m_lot_no').val())
					+ "&pnl_cnt="+encodeURIComponent($('#m_pnl_cnt').val())
					+ "&data_d="+encodeURIComponent($('#m_data_d').val())
					+ "&special_note="+encodeURIComponent($('#m_special_note').val())
					+ "&alarm_history="+encodeURIComponent($('#m_alarm_history').val());
				
				$.ajax({
					 url: page_url,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		if(data.result == "정상처리"){
						 		$("#modal_info").modal("hide");
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
					 		} else {
					 			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
					 		}
					 	} else {
					 		fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 	}
					 },
					 error: function(jqXHR, textStatus, errorThrown){
					    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 },
					 complete: function() {
					 }
				});
				
			}
		});
	}
	
	function deleteP2ProdLog() {
		
		var key = w2ui['grid_list'].getSelection();
		
		if(key.length == 0){
			fnMessageModalAlert("알림","삭제할 내용을 선택해주세요");
			return;
		}
		
		var get_data = w2ui['grid_list'].get(key);
		
		fnMessageModalConfirm("알림", "선택한 내용을 삭제하시겠습니까?", function(result) {
			if(result) {
				
				var page_url = "/frontend/production/deleteP2ProdLog";
				var postData = "gridData="+encodeURIComponent(JSON.stringify(get_data));
// 				var postData = "p2key="+encodeURIComponent(get_data[0].p2key);
				
				$.ajax({
					 url: page_url,
					 type: "POST",
					 dataType : 'json', 
					 data : postData, 
					 async : false,
					 success:function(data, textStatus, jqXHR){
					 	if(data.status == "200") {
					 		if(data.result == "정상처리"){
						 		loadList();
						    	fnMessageModalAlert("결과", "정상적으로 처리되었습니다."); // Notification(MES)
					 		} else {
					 			fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");
					 		}
					 	} else {
					 		fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 	}
					 },
					 error: function(jqXHR, textStatus, errorThrown){
					    	fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
					 },
					 complete: function() {
					 }
				});
				
			}
		});
	}
	
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
//		    .append('<option value="All">-----</option>')
	    .val();
	}
	
	function modalOpen(){
		console.log('modalOpen');
		
		var key = w2ui['grid_list'].getSelection();
		if( key.length != 1) {
			fnMessageModalAlert("알림", "작업지시 목록 1개 선택해주세요."); // Notification
			return;
		}
 
		var get_data = w2ui['grid_list'].get(key[0]);
		
		$('.in_field').text(''); //칸 비워주기
		
		$('.in_field')[0].innerHTML = get_data.date_created; 	// 2023-12-29 9:41 						id도 줌 (key value)
		$('.in_field')[1].innerHTML = get_data.pic; 			// (작성)	: 담당자
		$('.in_field')[2].innerHTML = '';						// (수입)				: 수입테스터
		$('.in_field')[3].innerHTML = ''; 						// (출하)				: 출하테스터
		$('.in_field')[4].innerHTML = '';						// (승인)				: 승인테스터
		$('.in_field')[5].innerHTML = get_data.step;			// (Step No)		: 240				id도 줌 (key value)
		$('.in_field')[6].innerHTML = get_data.prod_gubun;		// (작업 확인 사항)		: BVH(G/D PNL)		id도 줌 (key value)
		$('.in_field')[7].innerHTML = get_data.after_process;	// (후공정)			: SKIV				id도 줌 (key value)
		$('.in_field')[8].innerHTML = '';						// (특이사항)			: 빈칸
		$('.in_field')[9].innerHTML = get_data.data_d;			// (가공DATA)			: MS23N0225-01-ST033-FLC08994A00-008(GDRILL_1-4)(C)_.D00
		$('.in_field')[10].innerHTML = get_data.model;			// (Model)			: 050138G A(R001-B949L)(DJI UT0297)(ITS-A)(X)(2D)
		$('.in_field')[11].innerHTML = get_data.lot_no;			// (Lot No)			: MS23N0225-01
		$('.in_field')[12].innerHTML = get_data.item_no;		// (Item No)		: FLC08994A00-008
		$('.in_field')[13].innerHTML = get_data.item_nm;		// (원자재)			: MGC HL-832NSFLCAE 0.060T 02/02 415 515
		$('.in_field')[14].innerHTML = get_data.layer;			// (Layer)			: 1-4L
		$('.in_field')[15].innerHTML = get_data.item_size_thin; // (자재 두께)			: 0.06
		$('.in_field')[16].innerHTML = get_data.customer_nm;	// (고객사)			: JSCC
		$('.in_field')[17].innerHTML = get_data.pnl_cnt;		// (작업수량)			: 60 	매수(PNL)
		$('.in_field')[18].innerHTML = get_data.hole;			// (Hole 수)			: 569
		$('.in_field')[19].innerHTML = '';						// QR코드				: QR코드
		$('.in_field')[20].innerHTML = get_data.stack; 			// (Stack 수)		: 4
		$('.in_field')[21].innerHTML = get_data.x_axis;			// (원본Scale 적용값 X)	: 100.000
		$('.in_field')[22].innerHTML = '';						// (수정 의뢰 사항)		: 수정 의뢰 테스트
		$('.in_field')[23].innerHTML = '';						// (수정 Scale 적용 값 X)	: x_1값100
		$('.in_field')[24].innerHTML = '';						// (수정 Scale 적용 값 X)	: x_2값100
		$('.in_field')[25].innerHTML = 'SG074H(70/40)';			// (Entry Board)		: SG074H(70/40)
		$('.in_field')[26].innerHTML = 'XPC';					// (Back-Up-Board)	: XPC
		$('.in_field')[27].innerHTML = get_data.y_axis;			// (원본Scale 적용값 Y)	: 100.000
		$('.in_field')[28].innerHTML = '';						// (수정 Scale 적용값 Y)	: y_1값100
		$('.in_field')[29].innerHTML = '';						// (수정 Scale 적용값 Y)	: y_2값100
		$('.in_field')[30].innerHTML = '';						// (검사 수량)			: 검사수량 테스트
		$('.in_field')[31].innerHTML = '';						// (특이사항(별도구분 수량))	: 특이사항
		$('.in_field')[32].innerHTML = get_data.item_nm;		// (원자재명 확인(10%))	: MGC HL-832NSFLCAE 0.060T 02/02 415 515
		$('.in_field')[33].innerHTML = '';						// (검사수량(10%))		: 10%
		$('.in_field')[34].innerHTML = 'SG074H - '+moment().format('YYYYMMDD'); // (Entry Board (Lot No)) : SG074H - 231229
		$('.in_field')[35].innerHTML = 'XPC - '+moment().format('YYYYMMDD');// (Back-Up_Board (Lot No)) : XPC - 231229
		$('.in_field')[36].innerHTML = '';// (작업자)				: 작업자
		
		$('.in_field')[37].innerHTML = '(초품)';// (작업호기)			: 1100
		$('.in_field')[38].innerHTML = '';// (Table청소여부)		: T청소1
		$('.in_field')[39].innerHTML = '';// (방향성 확인)			: 방1
		$('.in_field')[40].innerHTML = '';// (작업자)				: 작업자1
		$('.in_field')[41].innerHTML = '';// (작업호기)			: 1101
		$('.in_field')[42].innerHTML = '';// (Table청소여부)		: T청소2
		$('.in_field')[43].innerHTML = '';// (방향성 확인)			: 방2
		$('.in_field')[44].innerHTML = '';// (작업자)				: 작업자2
		$('.in_field')[45].innerHTML = '';// (작업호기)			: 1102
		$('.in_field')[46].innerHTML = '';// (Table청소여부)		: T청소3
		$('.in_field')[47].innerHTML = '';// (방향성 확인)			: 방3
		$('.in_field')[48].innerHTML = '';// (작업자)				: 작업자3
		$('.in_field')[49].innerHTML = '';// (작업호기)			: 1103
		$('.in_field')[50].innerHTML = '';// (Table청소여부)		: T청소4
		$('.in_field')[51].innerHTML = '';// (방향성 확인)			: 방4
		$('.in_field')[52].innerHTML = '';// (작업자)				: 작업자4
		$('.in_field')[53].innerHTML = '';// (작업호기)			: 1104
		$('.in_field')[54].innerHTML = '';// (Table청소여부)		: T청소5
		$('.in_field')[55].innerHTML = '';// (방향성 확인)			: 방5
		$('.in_field')[56].innerHTML = '';// (작업자)				: 작업자5
		$('.in_field')[57].innerHTML = '';// (작업호기)			: 1105
		$('.in_field')[58].innerHTML = '';// (Table청소여부)		: T청소6
		$('.in_field')[59].innerHTML = '';// (방향성 확인)			: 방6
		$('.in_field')[60].innerHTML = '';// (작업자)				: 작업자6
		$('.in_field')[61].innerHTML = '';// (ZERO COMMAND (x축)) : x축.
		$('.in_field')[62].innerHTML = '';// (ZERO COMMAND (y축)) : y축.
		$('.in_field')[63].innerHTML = '';// (특이 사항)			: xy특이사항
		$('.in_field')[64].innerHTML = '';// (특이 사항)			: 초품검사 특이사항
		$('.in_field')[65].innerHTML = '';// (별도 구분)			: 별도 구분 텍스트
		$('.in_field')[66].innerHTML = '';// (특이 사항)			: 특이사항 텍스트
		$('.in_field')[67].innerHTML = '';// (제품 수량 확인)			: 제품 수량 테스트
		$('.in_field')[68].innerHTML = '';// (별도 구분여부)			: 구분테스트
		$('.in_field')[69].innerHTML = '';// (별도 구분여부)			: PNL칸

		
		$('.in_field')[19].innerHTML = ''; // QR코드
		var qrcode= new QRCode("qr_code_1", {width: 80, height: 80});
		qrcode.makeCode(get_data.data_d);	
		
		$('#modalWorkOrderSheet').modal('show');
		
	}
	
	function fnPrint(){
		$("#modal_work_body").printMe(
				{	"path": ["/res/plugins/printme/printme.css"]}
		);
			
	}
	
	function insertModalOpen(){
		
		$('#p2_prod_save').attr('onclick', 'insertP2ProdLog();');
		$('#p2_prod_save').html('생성');
		
		$('#m_in_date').val(moment().format('YYYYMMDD'));
		$('#m_out_date').val("");
		$('#m_item_no').val("").attr('disabled',false);
		$('#m_step').val("").attr('disabled',false);
		$('#m_pic').val("");
		$('#m_lot_no').val("");
		$('#m_pnl_cnt').val("");
		$('#m_data_d').val("");
		$('#m_special_note').val("");
		$('#m_alarm_history').val("");
		
		p2MLoadList();
		$('#modal_info').modal("show");
		
	}
	
	function updateModalOpen(){
		
		var key = w2ui['grid_list'].getSelection();
		if(key.length != 1){
			fnMessageModalAlert("알림", "수정할 항목 1개를 선택해주세요.");
			return;
		}
		var data = w2ui['grid_list'].get(key[0]);
		
		$('#p2_prod_save').attr('onclick', 'updateP2ProdLog();');
		$('#p2_prod_save').html('수정');
		
		$('#m_in_date').val(data.in_date_org);
		$('#m_out_date').val(data.out_date_org);
		$('#m_item_no').val(data.item_no).attr('disabled',true);
		$('#m_step').val(data.step).attr('disabled',true);
		$('#m_pic').val(data.pic);
		$('#m_lot_no').val(data.lot_no);
		$('#m_pnl_cnt').val(data.pnl_cnt);
		$('#m_data_d').val(data.data_d);
		$('#m_special_note').val(data.special_note);
		$('#m_alarm_history').val(data.alarm_history);
		
		p2MLoadList();
		$('#modal_info').modal("show");
		
	}
	
	function p2MLoadList() {
		
		var page_url = "/frontend/production/selectP2Prod";
	
		$.ajax({
			url : page_url,
			type : 'POST',
			dataType : 'json',
			success : function( data ) {
				if(data.status == 200) {
					var rowArr = data.rows;
					var m_item_arr = [];
					$.each(rowArr, function(idx, row){
						var obj = {};
						row.recid = idx+1;
						obj["step"] = row.step;
// 						obj["item_no"] = "("+row.drw_num+") " + row.item_nm;
						obj["item_no"] = row.item_no;
						m_item_arr.push(obj);
					});
					// 로컬 스토리지
					$("#m_item_no").w2field('combo', { items: _.uniq(_.map(m_item_arr, "item_no"),false) ,match : 'contains' });
// 					$("#m_step").w2field('combo', { items: _.map(m_item_arr, "item_nm") ,match : 'contains' });
					
					localStorage.setItem('m_item_arr',JSON.stringify(m_item_arr));
					document.getElementById("m_item_no").style.removeProperty("height");
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("결과", "정보를 처리하는데 에러가 발생하였습니다.");	 // Notification(MES)
			},
			complete: function () {
			}
		});
	}
	
	$('#m_item_no').on('change',function() {
		var item_arr = JSON.parse(localStorage.getItem("m_item_arr"));
		
		var arr = [];
		for(var i = 0; i < item_arr.length; i++){
			if(item_arr[i].item_no == $('#'+this.id).val()){
				arr.push(item_arr[i]);
			}
		}
		
		$("#m_step").w2field('combo', { items: _.uniq(_.map(arr, "step"),false) ,match : 'contains' });
		
		$('#m_step').click();
		document.getElementById("m_item_no").style.removeProperty("height"); //combo사용 시 css가 변해서 없앰
		document.getElementById("m_step").style.removeProperty("height");
	});
	
	function auto_key( target ) { // 자동완성을 담아준 인풋박스를 클릭하면 리스트가 셀렉트박스처럼 나옴
		$("#"+target).focus().trigger($.Event("keydown", {keyCode: 40}));
		return;
	}
	
</script>

</body>
</html>