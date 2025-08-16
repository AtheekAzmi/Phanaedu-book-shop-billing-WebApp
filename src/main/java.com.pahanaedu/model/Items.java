package model;

public class Items {
    private int item_id;
    private String item_name;
    private String description;
    private double price;
    private int stock_quantity;
    public Items() {}

    public Items(int item_id, String item_name, String description, double price, int stock_quantity) {
        this.item_id = item_id;
        this.item_name = item_name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
    }

    public int getItem_id() { return item_id; }
    public String getItem_name() { return item_name; }
    public String getDescription() { return description; }
    public double getPrice() { return price; }
    public int getStock_quantity() { return stock_quantity; }

    public void setItem_id(int item_id) { this.item_id = item_id; }
    public void setItem_name(String item_name) { this.item_name = item_name; }
    public void setDescription(String description) { this.description = description; }
    public void setPrice(double price) { this.price = price; }
    public void setStock_quantity(int stock_quantity) { this.stock_quantity = stock_quantity; }
}
