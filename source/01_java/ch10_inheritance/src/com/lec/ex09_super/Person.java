package com.lec.ex09_super;
//Person p = new Person("ȫ�浿", "����");
public class Person {
	private String name;
	private String character;
	//�Ű����� ���� ������
	public Person() {
		System.out.println("�Ű�����(=�Ķ���� =����)�� ���� Person ������");
	}
	//�Ű����� 2��¥�� ������
	public Person(String name, String character) {
		this.name = name;
		this.character = character;
		System.out.println("�Ű����� 2��¥�� Person ������");
	}
	public void intro() {
		System.out.println(name+"��(��) "+character);
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCharacter() {
		return character;
	}
	public void setCharacter(String character) {
		this.character = character;
	}
}