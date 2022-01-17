package myPackage;

public class MsgCompany {
    String company_id;
    String name;
    String phone;
    String cnt;
    public MsgCompany(String company_id, String name, String phone, String cnt){
        this.company_id = company_id;
        this.name = name;
        this.phone = phone;
        this.cnt = cnt;
    }
    public String getCompanyId(){
        return company_id;
    }
    public String getName(){
        return name;
    }
    public String getPhone(){
        return phone;
    }
    public String getCnt(){
        return cnt;
    }
}
