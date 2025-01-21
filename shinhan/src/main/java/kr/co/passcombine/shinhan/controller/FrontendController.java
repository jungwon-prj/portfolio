package kr.co.passcombine.shinhan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.passcombine.shinhan.svc.SYProductionService;
import kr.co.passcombine.shinhan.util.ResponseUtils;
import kr.co.passcombine.shinhan.util.SessionUtil;
import kr.co.passcombine.shinhan.vo.SYP2ProdVo;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/frontend")
public class FrontendController {
	private static final Logger logger = LoggerFactory
			.getLogger(FrontendController.class);
	
	@Resource(name = "shinhanProductionService")
	SYProductionService sYPrdService;
	 
	

	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView frontendMenuNavigation(@PathVariable String menu_div,
			@PathVariable String menu_page, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.frontendMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontend/" + menu_div + "/" + menu_page);

		if ("materials_process_sub_medi".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		} else if ("materials_process_sub_optImg".equals(menu_page)) {
			modelAndView.addObject("routing_no", request.getParameter("routing_no"));
			modelAndView.addObject("routing_gno", request.getParameter("routing_gno"));
		}
		return modelAndView;
	}
	
//////////////////////////////////////////////////////////////////////////////
				// p2prod
				@ResponseBody
				@RequestMapping(value = "/production/selectP2Prod", method = {
						RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
				@SuppressWarnings("unchecked")
				public String selectP2Prod(@ModelAttribute SYP2ProdVo vo,
						HttpServletRequest request, HttpServletResponse response,
						HttpSession session) {
					logger.debug("FrontendController.selectP2Prod is called.");

					JSONObject resultData = new JSONObject();
					JSONArray listDataJArray = new JSONArray();
					JSONParser jsonParser = new JSONParser();
					
					try {
						List<SYP2ProdVo> dataList = sYPrdService.selectP2Prod(vo);
						
						String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
						listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
						resultData.put("status", HttpStatus.OK.value());
						resultData.put("rows", listDataJArray);
					} catch(Exception e) {
						e.printStackTrace();
						resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
						resultData.put("rows", null);
					}
					
					
					return resultData.toJSONString();
				}
				
				// p2Prod 엑셀 업로드
			  @ResponseBody
			  @RequestMapping(value = "/production/excelUploadP2Prod", method = {RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
			  @SuppressWarnings("unchecked")
			  public String excelUploadP2Prod(@ModelAttribute SYP2ProdVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			    vo.setCreator(SessionUtil.getMemberId(request));
			    
			    JSONArray jsonArray = new JSONArray();
				JSONParser parser = new JSONParser();
				JSONObject resultData = new JSONObject();

			    try {
			    	
			    	int CheckCnt = 0;
			    	String records = request.getParameter("gridData");
					jsonArray = (JSONArray) parser.parse(records); 
					
					List<SYP2ProdVo> list = new ArrayList<SYP2ProdVo>();
					
					if(jsonArray.size() > 0){
						Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
						
						for(int i=0; i<jsonArray.size(); i++) {
							JSONObject jObj = (JSONObject)jsonArray.get(i);
							SYP2ProdVo prodVo = new SYP2ProdVo();
							
							for(Object key : keyArr) { 
								String nKey = key.toString();
								String nValue = "";
								if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
									continue;
								else 
									nValue = jObj.get(nKey).toString();
								if( "dataseq".equals(nKey) ) prodVo.setDataseq(nValue);
								else if( "prod_gubun".equals(nKey) ) prodVo.setProd_gubun(nValue);
								else if( "step".equals(nKey) ) prodVo.setStep(nValue);
								else if( "after_process".equals(nKey) ) prodVo.setAfter_process(nValue);
								else if( "stack".equals(nKey) ) prodVo.setStack(nValue);
								else if( "customer_nm".equals(nKey) ) prodVo.setCustomer_nm(nValue);
								else if( "prod_div".equals(nKey) ) prodVo.setProd_div(nValue);
								else if( "layer".equals(nKey) ) prodVo.setLayer(nValue);
								else if( "model".equals(nKey) ) prodVo.setModel(nValue);
								else if( "item_no".equals(nKey) ) prodVo.setItem_no(nValue);
								else if( "lengh".equals(nKey) ) prodVo.setLengh(nValue);
								else if( "s_pi".equals(nKey) ) prodVo.setS_pi(nValue);
								else if( "item_nm".equals(nKey) ) prodVo.setItem_nm(nValue);
								else if( "item_size_l".equals(nKey) ) prodVo.setItem_size_l(nValue);
								else if( "item_size_r".equals(nKey) ) prodVo.setItem_size_r(nValue);
								else if( "item_size_thin".equals(nKey) ) prodVo.setItem_size_thin(nValue);
								else if( "hole".equals(nKey) ) prodVo.setHole(nValue);
								else if( "x_axis".equals(nKey) ) prodVo.setX_axis(nValue);
								else if( "y_axis".equals(nKey) ) prodVo.setY_axis(nValue);
							}
							prodVo.setCreator(SessionUtil.getMemberId(request));
//							int chkCode = 0;
//							 chkCode = sYPrdService.check_Prod(prodVo); // 중복 체크 
//							if(chkCode == 0){
//								list.add(prodVo);
//							}
//							else if(chkCode != 0){
//								CheckCnt++;
//							}

							list.add(prodVo);
						}
					}

			      int cnt = sYPrdService.excelUploadP2Prod(list);
		          resultData.put("cnt", CheckCnt);
		          resultData.put("status", HttpStatus.OK.value());


			    } catch (Exception e) {
			      e.printStackTrace();
			      resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			    }
			    return resultData.toJSONString();
			  }
				  
				// p2Prod 다중삭제
			  @ResponseBody
			  @RequestMapping(value = "/production/deleteP2Prod", method = {RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
			  @SuppressWarnings("unchecked")
			  public String deleteP2Prod(@ModelAttribute SYP2ProdVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

			    JSONArray jsonArray = new JSONArray();
				JSONParser parser = new JSONParser();
				JSONObject resultData = new JSONObject();

			    try {
			    	
			    	String records = request.getParameter("gridData");
					jsonArray = (JSONArray) parser.parse(records); 
					
					List<SYP2ProdVo> list = new ArrayList<SYP2ProdVo>();
					
					if(jsonArray.size() > 0){
						Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
						
						for(int i=0; i<jsonArray.size(); i++) {
							JSONObject jObj = (JSONObject)jsonArray.get(i);
							SYP2ProdVo prodVo = new SYP2ProdVo();
							
							for(Object key : keyArr) { 
								String nKey = key.toString();
								String nValue = "";
								if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
									continue;
								else 
									nValue = jObj.get(nKey).toString();
								if( "p2key".equals(nKey) ) prodVo.setP2key(nValue);
							}
							prodVo.setCreator(SessionUtil.getMemberId(request));
							
							list.add(prodVo);
						}
					}

			      int cnt = sYPrdService.deleteP2Prod(list);
		          resultData.put("status", HttpStatus.OK.value());

			    } catch (Exception e) {
			      e.printStackTrace();
			      resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			    }
			    return resultData.toJSONString();
			  }
			  
		@ResponseBody  
		@RequestMapping(value = "/production/insertP2ProdLog", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String insertP2ProdLog(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.insertP2ProdLog() is called.");
				   
			JSONArray jsonArray = new JSONArray();
			JSONParser parser = new JSONParser();
			JSONObject resultData = new JSONObject();
			try {
				
				String records = request.getParameter("gridData");
				jsonArray = (JSONArray) parser.parse(records);
				List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
				      
				if (jsonArray.size() > 0) {
					Object[] keyArr = ((JSONObject) jsonArray.get(0)).keySet().toArray();
					
					for (int i = 0; i < jsonArray.size(); i++) {
						JSONObject jObj = (JSONObject) jsonArray.get(i);
						Map<String, Object> map = new HashMap<String, Object>();
						
						for (Object key : keyArr) {
							String nKey = key.toString();
							String nValue = "";
							if (jObj.get(nKey) == null || jObj.get(nKey) == "")
								continue;
							else nValue = jObj.get(nKey).toString();
							
							map.put(nKey,nValue);
						}
						map.put("updater",SessionUtil.getMemberId(request));
						map.put("creator",SessionUtil.getMemberId(request));
						mapList.add(map);
					}
				}
				      
				String result = sYPrdService.insertP2ProdLog(mapList);
				      
				resultData.put("result", result);
				resultData.put("status", HttpStatus.OK.value());
				      
				} catch (Exception e) {
					e.printStackTrace();
				    resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
				}
				return resultData.toJSONString();
			}
		
	 	@ResponseBody
	 	@RequestMapping(value = "/production/updateP2ProdLog", method = {RequestMethod.GET, RequestMethod.POST }, produces ="application/json;charset=UTF-8")
	 	@SuppressWarnings("unchecked")
	 	public String updateP2ProdLog(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
	 		logger.debug("FrontendController.updateP2ProdLog is called.");
	 		
	 		JSONObject resultData = new JSONObject();
	 		try {
	 			param.put("updater",SessionUtil.getMemberId(request));
				String result = "";
				
				result = sYPrdService.updateP2ProdLog(param);
	 			
	 			resultData.put("result", result);
	 			resultData.put("status", HttpStatus.OK.value());
	 		} catch (Exception e) {
	 			e.printStackTrace();
	 			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	 		}
	 		return resultData.toJSONString();
	 	}
		
		@ResponseBody
		@RequestMapping(value = "/production/selectP2ProdLog", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String selectP2ProdLog(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
			logger.debug("FrontendController.selectP2ProdLog is called.");

			JSONObject resultData = new JSONObject();
			JSONArray listDataJArray = new JSONArray();
			JSONParser jsonParser = new JSONParser();
			
			try {
				List<Map<String, Object>> dataList = sYPrdService.selectP2ProdLog(param);
				
				String listDataJsonString = ResponseUtils.getJsonResponse(response, dataList);
				listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
				resultData.put("status", HttpStatus.OK.value());
				resultData.put("rows", listDataJArray);
			} catch(Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}
			
			
			return resultData.toJSONString();
		}
		
		@ResponseBody
		@RequestMapping(value = "/production/deleteP2ProdLog", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json;charset=UTF-8")
		@SuppressWarnings("unchecked")
		public String deleteP2ProdLog(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
			logger.debug("FrontendController.deleteP2ProdLog is called.");

			JSONObject resultData = new JSONObject();
			JSONParser parser = new JSONParser();
			
			try {
				
				List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
				
				String gridData = param.get("gridData").toString();
				
				JSONArray listDataJArray = (JSONArray)parser.parse(gridData);
			    for(int i=0; i<listDataJArray.size(); i++) { 
			    	JSONObject jObj = (JSONObject)listDataJArray.get(i);
			    	
			    	String p2key = jObj.get("p2key") == null?"":jObj.get("p2key").toString(); 
			    	
			    	
			    	Map<String, Object> map = new HashMap<String, Object>();
					map.put("p2key", p2key);
					
					list.add(map);
					
			    }
				
			    String result = sYPrdService.deleteP2ProdLog(list);
			    
			    resultData.put("result", result);
				resultData.put("status", HttpStatus.OK.value());	
			} catch (Exception e) {
				e.printStackTrace();
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			}

			return resultData.toJSONString();
		}
		
}