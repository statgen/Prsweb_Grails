package prsweb;

public class combinedFileParserObject {

    String code ;
    String pstring  ;
    String category ;
    String sex ;

    Double lcogp ;
    Double prsp ;
   // Double cbeta ;
   // Double csebata ;
    Double or;
    Double cc1;
    Double cc2;


    Integer numcases ;
    Integer numcont ;

    Double exlcogp ;
    Double exprsp ;
    Double exor;
    Double excc1;
    Double excc2;
    //Double excbeta ;
    //Double excsebata ;
    Integer exnumcases ;
    Integer exnumcont ;

    String grpnum;

    public combinedFileParserObject(String code, String pstring, String category, String sex, Double lcogp, Double prsp, Double or, Double cc1, Double cc2, Integer numcases, Integer numcont, Double exlcogp, Double exprsp, Double exor, Double excc1, Double excc2, Integer exnumcases, Integer exnumcont, String grpnum) {
        this.code = code;
        this.pstring = pstring;
        this.category = category;
        this.sex = sex;
        this.lcogp = lcogp;
        this.prsp = prsp;
        this.or = or;
        this.cc1 = cc1;
        this.cc2 = cc2;
        this.numcases = numcases;
        this.numcont = numcont;
        this.exlcogp = exlcogp;
        this.exprsp = exprsp;
        this.exor = exor;
        this.excc1 = excc1;
        this.excc2 = excc2;
        this.exnumcases = exnumcases;
        this.exnumcont = exnumcont;
        this.grpnum = grpnum;
    }

    public Double getOr() {
        return or;
    }

    public void setOr(Double or) {
        this.or = or;
    }

    public Double getCc1() {
        return cc1;
    }

    public void setCc1(Double cc1) {
        this.cc1 = cc1;
    }

    public Double getCc2() {
        return cc2;
    }

    public void setCc2(Double cc2) {
        this.cc2 = cc2;
    }

    public Double getExor() {
        return exor;
    }

    public void setExor(Double exor) {
        this.exor = exor;
    }

    public Double getExcc1() {
        return excc1;
    }

    public void setExcc1(Double excc1) {
        this.excc1 = excc1;
    }

    public Double getExcc2() {
        return excc2;
    }

    public void setExcc2(Double excc2) {
        this.excc2 = excc2;
    }





    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPstring() {
        return pstring;
    }

    public void setPstring(String pstring) {
        this.pstring = pstring;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }



    public Double getLcogp() {
        return lcogp;
    }

    public void setLcogp(Double lcogp) {
        this.lcogp = lcogp;
    }

    public Double getPrsp() {
        return prsp;
    }

    public void setPrsp(Double prsp) {
        this.prsp = prsp;
    }




    public Integer getNumcases() {
        return numcases;
    }

    public void setNumcases(Integer numcases) {
        this.numcases = numcases;
    }

    public Integer getNumcont() {
        return numcont;
    }

    public void setNumcont(Integer numcont) {
        this.numcont = numcont;
    }

    public Double getExlcogp() {
        return exlcogp;
    }

    public void setExlcogp(Double exlcogp) {
        this.exlcogp = exlcogp;
    }

    public Double getExprsp() {
        return exprsp;
    }

    public void setExprsp(Double exprsp) {
        this.exprsp = exprsp;
    }



    public Integer getExnumcases() {
        return exnumcases;
    }

    public void setExnumcases(Integer exnumcases) {
        this.exnumcases = exnumcases;
    }

    public Integer getExnumcont() {
        return exnumcont;
    }

    public void setExnumcont(Integer exnumcont) {
        this.exnumcont = exnumcont;
    }

    public String getGrpnum() {
        return grpnum;
    }

    public void setGrpnum(String grpnum) {
        this.grpnum = grpnum;
    }









}
