package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.MemoVO;

public class MemoDAO {
	
	// 모든 메모 정보를 목록(List<MemoVO>, MemoVO[])으로 반환하는 기능
	public static MemoVO[] getAll() {
		List<MemoVO> list = null;
		// 위의 list와 같은 길이의 배열도 준비
		MemoVO[] ar = null;
		
		// DB의 정보를 요청할 수 있는 SqlSessionFactory이 필요하다.
		SqlSession ss = FactoryService.getFactory().openSession();
		
		// 얻어진 ss를 통해 원하는 SQL문을 호출하자!
		list = ss.selectList("memo.all");
		
		// list의 길이와 같은 배열을 생성한다.(list 비었다면 하지 않는다.)
		if(list != null && !list.isEmpty()) {
			// list가 null도 아니고  비어있지 않은 경우!!
		ar = new MemoVO[list.size()];
		
		//list의 각 요소들을 ar에게 그대로 복사한다.
		list.toArray(ar);
		}
		ss.close();
		return ar;
	}
	public static boolean setAdd(String writer, String content, String ip) {// 호출하는 JSP에서 파라미터로 부터 받은 값들을 인자로 받는다.
		boolean chk = true;
		// 인자로 받은 3개의 값들을 memo.add라는 mapper를 호출하기 위해 java.util.Map형태로 다시 저장해야 한다.
		Map<String, String> map = new HashMap<String, String>(); // 맵 구조의 앞에 있는 k는 변수명이라 생각하고 뒤에 v는 전달해줘야하는 값 실제 값들을 넣어주야 한다.
		map.put("writer", writer);
		map.put("content", content);
		map.put("ip", ip);
		
		//위의 Map을 memo.add를 호출하기 위헤 SqlSession이 필요하다.
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.insert("memo.add",map);
		
		if(cnt > 0) {
			// 저장에 성공한 경우!
			ss.commit(); // DB에 바로 적용 - 트랜잭션 처리!
		}else {
			// 저장에 실패한 경우!
			ss.rollback();// 지금까지 기록
			chk = false;
		}
		ss.close();
		
		return chk;
	}
	public static int exit(String idx) {
		// 인자로 받은 값들을 DB에 연결 시켜야한다.
		SqlSession ss = FactoryService.getFactory().openSession();
		
		int cnt = ss.delete("memo.del", idx);
		
		// 삭제가 수행됐다면 cnt는 분명 0보다 큰 값을 가진다.
		if(cnt > 0) 
			ss.commit();
		else 
			ss.rollback();
		
		ss.close();
		
		return cnt;
	}
}
