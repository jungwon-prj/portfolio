package kr.co.passcombine.shinhan.svc;

import java.util.HashMap;
//import java.lang.reflect.Field;
//import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;








//import org.json.simple.parser.ParseException;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import kr.co.passcombine.shinhan.dao.SYProductionDAO;
import kr.co.passcombine.shinhan.vo.SYP2ProdVo;




@Service(value = "shinhanProductionService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYProductionService {

	// private static final Logger logger = LoggerFactory.getLogger(SYCodeService.class);
	@Resource
	private Environment environment;
	
	@Resource(name = "shinhanProductionDAO")
	private SYProductionDAO prdDAO;

	// p2prod
	public List<SYP2ProdVo> selectP2Prod(SYP2ProdVo vo) {
		return prdDAO.selectP2Prod(vo);
	}
	public int excelUploadP2Prod(List<SYP2ProdVo> list) {
		return prdDAO.excelUploadP2Prod(list);
	}
	public int deleteP2Prod(List<SYP2ProdVo> list) {
		return prdDAO.deleteP2Prod(list);
	}
	
	public String insertP2ProdLog(List<Map<String, Object>> mapList) {
		
		List<Map<String, Object>> p2List = prdDAO.chkSelectP2Prod(mapList.get(0));
		
		if(p2List.size() == 0){
			return "코드없음";
		
		}
		p2List.get(0).put("in_date", mapList.get(0).get("in_date"));
		p2List.get(0).put("out_date", mapList.get(0).get("out_date"));
		p2List.get(0).put("pic", mapList.get(0).get("pic"));
		p2List.get(0).put("lot_no", mapList.get(0).get("lot_no"));
		p2List.get(0).put("pnl_cnt", mapList.get(0).get("pnl_cnt"));
		p2List.get(0).put("data_d", mapList.get(0).get("data_d"));
		p2List.get(0).put("special_note", mapList.get(0).get("special_note"));
		p2List.get(0).put("alarm_history", mapList.get(0).get("alarm_history"));
		
		
		for(int i = 0; i < p2List.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("p2key", p2List.get(i).get("p2key"));
			List<Map<String, Object>> list = prdDAO.selectP2ProdLog(map);
			if(list.size() > 0){
				return "코드중복";
			}
		}
		
		for(int i = 0; i < p2List.size(); i++){
			int cnt = prdDAO.insertP2ProdLog(p2List.get(i));
		}
		String result = "정상처리";
		return result;
	}
	
	public List<Map<String, Object>> selectP2ProdLog(Map<String, Object> param) {
		return prdDAO.selectP2ProdLog(param);
	}
	public String deleteP2ProdLog(List<Map<String, Object>> list) {
		
		for(int i = 0; i < list.size(); i++){
			int cnt = prdDAO.deleteP2ProdLog(list.get(i));
		}

		String result = "정상처리";
		return result;
	}
	public String updateP2ProdLog(Map<String, Object> param) {
		int cnt = prdDAO.updateP2ProdLog(param);

		String result = "정상처리";
		return result;
	}
}

