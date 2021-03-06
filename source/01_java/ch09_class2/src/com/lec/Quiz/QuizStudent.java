package com.lec.Quiz;

import com.lec.ex7_product.Product;

public class QuizStudent {
	private String name;
	private int kor;
	private int eng;
	private int mat;
	private int tot;
	private double avg;
	private int studentNum;
	public static int count;

	public QuizStudent( String name, int kor, int eng, int mat) {
		studentNum = ++count;
		this.name = name;
		this.kor = kor;
		this.eng = eng;
		this.mat = mat;
		tot = kor + eng + mat;
		avg = tot / 3.0;
	}
	public void print() {
		System.out.printf("\t%3d\t%s\t%3d\t%3d\t%3d\t%3d\t%.1f\n", 
				studentNum,	name, kor, eng, mat, tot, avg);
	}
	public String infoString() {
		return String.format("\t %s \t %d \t %d \t %d \t %d \t %.1f\n", 
								name, kor, eng, mat, tot, avg);
	}
	public String getName() {return name;}
	public int getKor() {return kor;}
	public int getEng() {return eng;}
	public int getMat() {return mat;}
	public int getTot() {return tot;}
	public double getAvg() {return avg;}
	public int getCount() {return count;}
	
}
