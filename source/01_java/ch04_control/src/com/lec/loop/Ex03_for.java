package com.lec.loop;
//��ø for��

public class Ex03_for {
	public static void main(String[] args) {
		for(int j=1 ; j<=5 ; j++) { //j�� 5ȸ �ݺ�
			for(int i=1; i<=j ; i++) { //i�� 1���� j���� jȸ �ݺ� 
				System.out.print('*');
			}//for.i
			System.out.println(); //����
		}//for.j
	}//main
}//class