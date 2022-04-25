package com.lec.ex3_student;

public class StudentDto {
	private int rank;
	private int sno;
	private String sname;
	private int mcode;
	private String mname;
	private int score;
	private int sexpel;
	public StudentDto() {}
	
	public StudentDto(int sno, String sname, String mname, int score) {
		super();
		this.sno = sno;
		this.sname = sname;
		this.mname = mname;
		this.score = score;
	}

	public StudentDto(int sno, String sname, int mcode, String mname, int score, int sexpel) {
		super();
		this.sno = sno;
		this.sname = sname;
		this.mcode = mcode;
		this.mname = mname;
		this.score = score;
		this.sexpel = sexpel;
	}
	@Override
	public String toString() {
		return "StudentDto [sNo=" + sno + ", sname=" + sname + ", mcode=" + mcode + ", mname=" + mname + ", score="
				+ score + ", sexpel=" + sexpel + "]";
	}
	public int getSno() {
		return sno;
	}
	public void setSno(int sno) {
		this.sno = sno;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int mcode) {
		this.mcode = mcode;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getSexpel() {
		return sexpel;
	}
	public void setSexpel(int sexpel) {
		this.sexpel = sexpel;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	
	
	
	
}
