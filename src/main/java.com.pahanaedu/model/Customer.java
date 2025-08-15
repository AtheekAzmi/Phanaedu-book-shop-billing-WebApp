package model;

public class Customer {
    private int customer_id;
    private String account_number;
    private String full_name;
    private String address;
    private String contact_no;
    private int unit_consumed;

    public Customer() {}

    public Customer(int customer_id, String account_number, String full_name, String address, String contact_no, int unit_consumed) {
        this.customer_id = customer_id;
        this.account_number = account_number;
        this.full_name = full_name;
        this.address = address;
        this.contact_no = contact_no;
        this.unit_consumed = unit_consumed;
    }

    public int getCustomer_id() { return customer_id; }
    public String getAccount_number() { return account_number; }
    public String getFull_name() { return full_name; }
    public String getAddress() { return address; }
    public String getContact_no() { return contact_no; }
    public int getUnit_consumed() { return unit_consumed; }

    public void setCustomer_id(int customer_id) { this.customer_id = customer_id; }
    public void setAccount_number(String account_number) { this.account_number = account_number; }
    public void setFull_name(String full_name) { this.full_name = full_name; }
    public void setAddress(String address) { this.address = address; }
    public void setContact_no(String contact_no) { this.contact_no = contact_no; }
    public void setUnit_consumed(int unit_consumed) { this.unit_consumed = unit_consumed; }
}
