package com.bookstoremanage.pojo;

import java.util.List;

public class Purchase {
    private Integer id;

    private Integer did;

    private Integer sid;

    private Integer total;

    private String number;

    private String reason;

    private String opinion;

    private String proposal;

    /*非数据库字段*/
    private Details details;

    private Staff staff;

    private List<Book> bs;

    public Details getDetails() {
        return details;
    }
    public void setDetails(Details details) {
        this.details = details;
    }
    public Staff getStaff() {
        return staff;
    }
    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public List<Book> getBs() {
        return bs;
    }
    public void setBs(List<Book> bs) {
        this.bs = bs;
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDid() {
        return did;
    }

    public void setDid(Integer did) {
        this.did = did;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number == null ? null : number.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion == null ? null : opinion.trim();
    }

    public String getProposal() {
        return proposal;
    }

    public void setProposal(String proposal) {
        this.proposal = proposal == null ? null : proposal.trim();
    }
}