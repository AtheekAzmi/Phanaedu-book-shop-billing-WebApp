package model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private int customerId;
    private int userId;
    private Date billDate;
    private double totalAmount;
    private List<BillItem> items;

    public Bill() {}
    public Bill(int billId, int customerId, int userId, Date billDate,
                double totalAmount, List<BillItem> items) {
        this.billId = billId;
        this.customerId = customerId;
        this.userId = userId;
        this.billDate = billDate;
        this.totalAmount = totalAmount;
        this.items = items;
    }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public List<BillItem> getItems() { return items; }
    public void setItems(List<BillItem> items) { this.items = items; }
}
