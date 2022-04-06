package com.lec.quiz2;

import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;

public class MemberTestMain2 {
	public static void main(String[] args) {
		OutputStream fos = null;

		String todayfm = new SimpleDateFormat("MM/dd").format(new Date(System.currentTimeMillis()));
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd");
		Scanner sc = new Scanner(System.in);

		int cnt = 0;
		String name = null;
		String tel = null;
		String address = null;
		String birth = null;
		Date today = new Date();
		// Member member = new Member();

		ArrayList<Member> arrayList = new ArrayList<Member>();
		try {
			fos = new FileOutputStream("src/com/lec/quiz2/member.txt");
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
					arrayList.add(new Member(name, tel, birth, address));
				} else {
					break;
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
			} catch (Exception ignore) {
			}
		}
		sc.close();
	}
}