package exam.garaman.Model;

public class SparePart {
    private int id;
    private String name;
    private int price;
    private String des;
    private int stockRemain;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
    public int getStockRemain() {
        return stockRemain;
    }
    public void setStockRemain(int stockRemain) {
        this.stockRemain = stockRemain;
    }
    public String getDes() {
        return des;
    }
    public void setDes(String des) {
        this.des = des;
    }
}
