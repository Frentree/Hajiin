package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class PCGroupVo implements Serializable {
	private String insa_code;
	private String up_idx;
	private int type;
	private String name;
	private int t_cnt;

	public PCGroupVo() {

	}
	
	 /**
     * @param insa_code
     * @param up_idx
     * @param type
     * @param name
     * @param t_cnt
     */
    public PCGroupVo(String insa_code, int type, String up_idx, String name,
            int t_cnt) {
       
        this.insa_code = insa_code;
        this.type = type;
        this.up_idx = up_idx;
        this.name = name;
        this.t_cnt = t_cnt;
    }

	public String getInsa_code() {
		return insa_code;
	}

	public void setInsa_code(String insa_code) {
		this.insa_code = insa_code;
	}

	public String getUp_idx() {
		return up_idx;
	}

	public void setUp_idx(String up_idx) {
		this.up_idx = up_idx;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getT_cnt() {
		return t_cnt;
	}

	public void setT_cnt(int t_cnt) {
		this.t_cnt = t_cnt;
	}

	@Override
	public String toString() {
		return "PCGroupVo [insa_code=" + insa_code + ", up_idx=" + up_idx + ", type=" + type + ", name=" + name
				+ ", t_cnt=" + t_cnt + "]";
	}
    
}