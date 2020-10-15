package com.excel.domain;

import java.util.List;

public class SalaryType {

	private int sNo;
	private String sType;

	private List<Occupant> occupants;

	@Override
	public String toString() {
		return "SalaryType [sNo=" + sNo + ", sType=" + sType + ", occupants=" + occupants + "]";
	}

	public int getsNo() {
		return sNo;
	}

	public void setsNo(int sNo) {
		this.sNo = sNo;
	}

	public String getsType() {
		return sType;
	}

	public void setsType(String sType) {
		this.sType = sType;
	}

	public List<Occupant> getOccupants() {
		return occupants;
	}

	public void setOccupants(List<Occupant> occupants) {
		this.occupants = occupants;
	}

}
