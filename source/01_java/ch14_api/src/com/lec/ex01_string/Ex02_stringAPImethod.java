package com.lec.ex01_string;

public class Ex02_stringAPImethod {
	public static void main(String[] args) {
		String str1 = "abcXabc";
		String str2 = new String("ABCXabc");
		String str3 = "      ja   va      ";
		System.out.println("1."+str1.concat(str2));		//문자열 결합 : abcXabcABCXabc
		System.out.println("2."+str1.substring(3));		//3번방 문자부터 쭉
		System.out.println("3."+str1.substring(3,5));	//3번방 문자부터 5번방 앞까지
		System.out.println("4."+str1.length());		//글자길이7
		System.out.println("5."+str1.toUpperCase());	//대문자로 ABCXABC
		System.out.println("6."+str1.toLowerCase());	//소문자로 abcxabc
		System.out.println("7."+str1.charAt(3));	//3번방 문자 'X'
		System.out.println("8."+str1.indexOf('b'));	//문자 idx 1출력
		System.out.println("9."+str1.indexOf('b', 3));	//3번방부터 검색해서 첫번째 'b'위치
		System.out.println("10."+str1.indexOf("abc"));	//"abc"위치
		System.out.println("11."+str1.indexOf("abc", 2));	//2번방부터 검색해서 "abc"위치
		System.out.println("12."+str1.indexOf('j'));	//없으면 -1 
		System.out.println("13."+str1.lastIndexOf('b'));	//마지막 'b' idx반환
		System.out.println("14."+str1.lastIndexOf('b', 3));	//3번방부터 앞으로 오면서 b찾음
		System.out.println("15."+str1.equals(str2));	//str1과 str2가 같은 문자열인지 false(대소문자 구분O)
		System.out.println("16."+str1.equalsIgnoreCase(str2));	//대소문자 구분없이 비교 true
		System.out.println("17."+str3.trim());	//앞뒤 공백제거 (중간X)
		System.out.println("18."+str1.replace('a', 'b'));	//문자를 바꿈
		System.out.println("19."+str1.replace("abc", "＃"));	//문자열도 가능
		System.out.println("20."+str1.replaceAll("abc", "Z"));	
			//정규표현식 http://goo.gl/HLntbd
				//연습장 : http://nextree.co.kr/p4327/
			// replaceAll과 cf.replace
			String str = "안녕Hello";		//영문자 다 *로 바꾸기
			System.out.println("+"+str.replaceAll("[a-zA-Z]", "*"));	//알파벳을 "*"으로 수정
			System.out.println("+"+str.replaceAll("[가-힣]", "*"));	//한글을 "*"으로 수정
		//문자열 메소드는 문자열을 수정 안함
		System.out.println("str1 = "+str1);
		System.out.println("str2 = "+str2);
		System.out.println("str3 = "+str3);
		
	}
}
