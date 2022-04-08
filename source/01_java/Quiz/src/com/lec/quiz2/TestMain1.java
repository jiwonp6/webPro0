package com.lec.quiz2;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;
import java.util.StringTokenizer;

public class TestMain1 {
	public static void main(String[] args) {
		OutputStream fos = null;

		Scanner sc = new Scanner(System.in);

		String name = null;
		String tel = null;
		String address = null;
		String birth = null;
		Date today = new Date();
		// Member member = new Member();

		ArrayList<Customer> arrayList = new ArrayList<Customer>();
		try {
			fos = new FileOutputStream("src/com/lec/quiz2/customer.txt");
			while (true) {
				System.out.println("ȸ�������� �Ͻðڽ��ϱ�?(y/n)");
				String ans = sc.next();
				if (ans.equalsIgnoreCase("y")) {
					System.out.println("�̸� : ");
					name = sc.next();
					System.out.println("��ȭ : ");
					tel = sc.next();
					System.out.println("�������(YYYY/MM/dd) :");
					birth = sc.next();
					System.out.println("�ּ� : ");
					sc.nextLine();
					address = sc.nextLine();
					StringTokenizer tok = new StringTokenizer(birth, "/");
					while (tok.hasMoreElements()) {
						int year = (Integer.parseInt(tok.nextToken()) - 1900);
						int month = (Integer.parseInt(tok.nextToken()) - 1);
						int day = Integer.parseInt(tok.nextToken());
						if (month == today.getMonth() && day== today.getDate()) {
							System.out.println(name + "�� ���������մϴ�");
						}
					}
					System.out.println("���ԿϷ�\n");
					arrayList.add(new Customer(name, tel, birth, address));
				} else if(ans.equalsIgnoreCase("n")){
					break;
				}else {
					System.out.println("�߸��Է��ϼ̽��ϴ�.");
					continue;
				}
			}
			String line = "\n";
			String str = "\t\t" + "-----�̻� " + arrayList.size() + "�� ȸ������-----";
			for (int i = 0; i < arrayList.size(); i++) {
				fos.write(arrayList.get(i).toString().getBytes());
				System.out.println(arrayList.get(i));
				fos.write(line.getBytes());
			}
			fos.write(str.getBytes());

			System.out.println("\t\t" + "-----�̻� " + arrayList.size() + "�� ȸ������-----");
			arrayList.clear();
		} catch (IOException e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (fos != null)
					fos.close();
			} catch (Exception ignore) {}
		}
		sc.close();
	}
}