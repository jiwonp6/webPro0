package com.lec.condition;

import java.util.Scanner;
//0<=Math.random()<1
//0<=Math.random()*3<3
//0<=(int)(Math.random()*3)<3	: 0, 1, 2 �� �ϳ�
public class Quiz05 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		int num, com = (int)(Math.random()*3);
		System.out.println("����(0), ����(1), ��(2) �� �ϳ� ����");
		num = sc.nextInt(); //���� �Է¹ޱ�
		if(num==0) {
			System.out.println("����\t");
		}else if(num==1){
			System.out.println("����\t");
		}else if(num==2){
			System.out.println("��\t");
		}else {
			System.out.println("�߸� �¾��. ����");
			num=3;	//������ ���� ����
		}
		if(num !=3) {
			String msg = (com==0) ? "��ǻ�ʹ� ����": (com==1) ? "��ǻ�ʹ� ����" : "��ǻ�ʹ� ��";
			System.out.println(msg);
			//�������
			if(num==0) {
				if(com==0) {
					System.out.println("����.");
				}else if(num==1){
					System.err.println("����� �̰��.");
				}else {
					System.out.println("��ǻ�Ͱ� �̰��.");
				}
			}else if(num==1) {
				if(com==0) {
					System.out.println("����� �̰��.");
				}else if(num==1){
					System.err.println("����.");
				}else {
					System.out.println("��ǻ�Ͱ� �̰��.");
				}
				
			}else {
				if(com==0) {
					System.out.println("��ǻ�Ͱ� �̰��.");
				}else if(num==1){
					System.err.println("����� �̰��.");
				}else {
					System.out.println("����.");
				}
			}
		}
		
		sc.close();
		
		
		//System.out.println((int)(Math.random()*3));
}
}