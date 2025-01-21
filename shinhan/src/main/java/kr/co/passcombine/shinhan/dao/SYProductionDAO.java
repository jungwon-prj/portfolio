package kr.co.passcombine.shinhan.dao;

import java.util.List;
import java.util.Map;

import kr.co.passcombine.shinhan.vo.SYP2ProdVo;

import org.springframework.stereotype.Repository;

@Repository(value = "shinhanProductionDAO")
public interface SYProductionDAO {
	
	// p2prod
	public List<SYP2ProdVo> selectP2Prod(SYP2ProdVo vo);
	
	public int excelUploadP2Prod(List<SYP2ProdVo> list);
	
	public int deleteP2Prod(List<SYP2ProdVo> list);

	public int insertP2ProdLog(Map<String, Object> map);

	public List<Map<String, Object>> selectP2ProdLog(Map<String, Object> param);

	public int deleteP2ProdLog(Map<String, Object> param);

	public int updateP2ProdLog(Map<String, Object> param);

	public List<Map<String, Object>> chkSelectP2Prod(Map<String, Object> map);
}