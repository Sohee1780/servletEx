package el;

public class MyElClass {
	
	public MyElClass() {
		// TODO Auto-generated constructor stub
	}

	// 주민번호를 입력받아 성별을 반환하는 메서드
	public String getGender(String jumin) {
		String res = "";
		try {
			int startIndex = jumin.indexOf("-")+1;
			int endIndex = startIndex+1;
			
			// substring 시작인덱스(포함), 끝인덱스(불포함), 0부터 시작
			String gender = jumin.substring(startIndex, endIndex);
			
			if("1".equals(gender) || "3".equals(gender)) res = "남자";
			else if("2".equals(gender) || "4".equals(gender)) res = "여자";
			else throw new Exception(); // 예외 발생
		}catch (Exception e) {
			// TODO: handle exception
			res = "주민등록 번호를 확인해주세요.";
		}
		return res;
	}
	
	// 입력받은 문자열이 숫자인지 판별하는 정적메서드
	public static boolean isNumber(String value) {
//		try {
//			Integer.parseInt(value);
//			return true;
//		}catch(NumberFormatException e){
//			return false;
//		}
		
		// 배열을 돌면서 숫자인지 확인
		char[] chArr = value.toCharArray();
		
		for(int i=0; i<chArr.length; i++) {
			if(!(chArr[i]>='0'&&chArr[i]<='9')) {
				return false;
			}
		}
		return true;
	}
	
	// 입력받은 정수까지 구구단을 HTML테이블로 출력하는 정적메서드
	// 1~입력받은 숫자까지 출력 
	public static String showGugudan(int limitDan) {
		StringBuffer sb = new StringBuffer();

		sb.append("<table border='1'>");
		for(int i=1; i<=limitDan; i++) {
			sb.append("<tr>");
			for(int j=1; j<=9; j++) {
				sb.append("<td>"+i+"*"+j+"="+i*j+"</td>");
			}
			sb.append("</tr>");
		}
		sb.append("<table>");
		return sb.toString();
	}
}
