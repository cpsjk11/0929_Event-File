package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.MemVO;

public class MemDAO {
	
	// 회원가입기능
	public static int registry (String m_id, String m_pw, String m_name, String m_email) {
		// 인자로 받은 값들을 mem.add를 호출하기 위해 Map구조 저장한다.
		Map<String, String> map = new HashMap<String, String>();
		map.put("m_id", m_id);
		map.put("m_pw", m_pw);
		map.put("m_name", m_name);
		map.put("m_email", m_email);
		
		// 이젠 맵퍼의 mem.add를 호출하기 위해 SqlSession이 필요하다.
		SqlSession ss = FactoryService.getFactory().openSession();
		
		//
		int cnt = ss.insert("mem.add", map);
		if(cnt > 0)
			ss.commit();
		else
			ss.rollback();
		
		ss.close();
		
		return cnt; // 수행된 레코드 수가 반환된다.
	}
	
	//로그인 기능
	public static MemVO login(String m_id, String m_pw) {
		
		// 인자로 받은 값들을 Map에 저장하자!
		Map<String, String> map = new HashMap<String, String>();
		map.put("m_id", m_id);
		map.put("m_pw", m_pw);
		
		// 이젠 맵퍼의 mem.login을 호출하기 위해 SqlSession이 필요하다
		SqlSession ss = FactoryService.getFactory().openSession();
		
		// 이제 DB와 연결하여 값을 MemVO에 저장하자!
		MemVO mvo = ss.selectOne("mem.login",map);
		
		ss.close();
		
		return mvo;
	}
	// 아이디를 체크해주는 기능
	public static boolean checkId(String m_id) {
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		
		MemVO mvo = ss.selectOne("mem.checkId",m_id);
		
		// 같은 아이디가 없을 때만 chk에 true를 넣는다.
		if(mvo == null)
			chk = true;
		
		ss.close();
		
		return chk;
	}
}
