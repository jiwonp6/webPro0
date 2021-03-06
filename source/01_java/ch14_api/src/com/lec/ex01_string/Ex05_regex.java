package com.lec.ex01_string;

public class Ex05_regex {
	public static void main(String[] args) {
		String str = "010-9999-9999    yisy0703@naver.com    (02)565-8888    반갑습니다. Hello   951212-2524251    010-8888-8888";
		System.out.println("replace => "+ str.replace("0", "홍"));	//0만 홍으로 바뀜
		/* 정규표현식(regex)
		 1. 참조 : goo.gl/HLntbd		연습장 : regexr.com/regexpal.com
		 2. 간략한 문법
		 	\d : 숫자와 매치, [0-9]와 동일	\D : 숫자가 아닌 것
		 	\s : whitespacen : space, 탭, 엔터
		 	\w : 영문자나 숫자, [a-zA-z0-9]와 동일		\W : 영문자나 숫자가 아닌것
		 	. : 문자하나
		 	+ : 1번이상 반복
		 	* : 0번이상 반복
		 	? : 0~1번이상 반복
		 	{2,4} : 2~4회 반복
		 3. 정규표현식 연습장 : 
		 	ex. 전화번호 : .?[0-9]{2,3}.[0-9]{3,4}-[0,9]{4}
		 4. 특정 정규표현식의 문자열 변경 : replaceAll("정규표현식", "대체문자열")
		 */
		//전화번호 지움
		System.out.println(str.replaceAll("[(]?[0-9]{2,3}\\D[0-9]{3,4}-[0,9]{4}", "*전화번호지움*"));
		//이메일 지움
		String str2 = "010-9999-9999    yisy0703@naver.com    (02)565-8888    반갑습니다. Hello   951212-2524251    abc@hong.co.kr";
		System.out.println(str2.replaceAll("\\w+@\\w+(.\\w+){1,2}", "+"));
		//알파벳 지움
		System.out.println(str2.replaceAll("[a-zA-Z]", "-"));
		//한글 지움
		System.out.println(str2.replaceAll("[가-힣ㄱ-ㅎ]", "~"));
		//주민번호 뒷자리 지움
		System.out.println(str2.replaceAll("[0-9]{7}", "*******"));
	}
}
