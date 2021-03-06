package com.lec.ex01_inputstreamOutputstream;
//(1)파일을 연다(출력용 스트림객체 생성) (2)write한다 (3)파일을 닫는다(스트림객체.close)
import java.io.*;

public class Ex04_OutputStream {
	public static void main(String[] args) {
		OutputStream os = null;
		try {
			os = new FileOutputStream("txtFile/outTest.txt");	//(1)파일을 연다	true는 출력값이 계속 추가돼서 나옴
			String str = "Hello, Java\n이 시국에 모두 건강하세요";
			byte[] bs = str.getBytes();	//알아서 배열로
			os.write(bs); //(2)write함
			System.out.println("파일 출력 성공");
		} catch (FileNotFoundException e) {
			System.out.println(e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if(os != null) {	//(3)파일 닫음
					os.close();
				}
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}
		}
	}
}
