package prsweb;

/**
 * Created by snehalpatil on 6/7/19.
 */
public class FileParserObject {

    String code ;
    String pstring  ;
    String category ;
    String grpnum;
    Integer numcases ;
    Integer numcont ;
    String sex ;

    Double q1q2ci1 ;
    Double q1q2ci2 ;
    Double q1q2or ;

    Double q1q3ci1 ;
    Double q1q3ci2 ;
    Double q1q3or ;

    Double q1q4ci1 ;
    Double q1q4ci2 ;
    Double q1q4or ;

    Double cbeta ;
    Double cci1 ;
    Double cci2 ;
    Double lcogp ;
    Double cor ;
    Double csebata ;

    public FileParserObject(String code, String pstring, String category, String grpnum, Integer numcases, int numcont, String sex, Double q1q2ci1, Double q1q2ci2, Double q1q2or, Double q1q3ci1, Double q1q3ci2, Double q1q3or, Double q1q4ci1, Double q1q4ci2, Double q1q4or, Double cbeta, Double cci1, Double cci2, Double lcogp, Double cor, Double csebata) {
        this.code = code;
        this.pstring = pstring;
        this.category = category;
        this.grpnum = grpnum;
        this.numcases = numcases;
        this.numcont = numcont;
        this.sex = sex;
        this.q1q2ci1 = q1q2ci1;
        this.q1q2ci2 = q1q2ci2;
        this.q1q2or = q1q2or;
        this.q1q3ci1 = q1q3ci1;
        this.q1q3ci2 = q1q3ci2;
        this.q1q3or = q1q3or;
        this.q1q4ci1 = q1q4ci1;
        this.q1q4ci2 = q1q4ci2;
        this.q1q4or = q1q4or;
        this.cbeta = cbeta;
        this.cci1 = cci1;
        this.cci2 = cci2;
        this.lcogp = lcogp;
        this.cor = cor;
        this.csebata = csebata;
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

    public String getGrpnum() {
        return grpnum;
    }

    public void setGrpnum(String grpnum) {
        this.grpnum = grpnum;
    }

    public Integer getNumcases() {
        return numcases;
    }

    public void setNumcases(int numcases) {
        this.numcases = numcases;
    }

    public int getNumcont() {
        return numcont;
    }

    public void setNumcont(int numcont) {
        this.numcont = numcont;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Double getQ1q2ci1() {
        return q1q2ci1;
    }

    public void setQ1q2ci1(Double q1q2ci1) {
        this.q1q2ci1 = q1q2ci1;
    }

    public Double getQ1q2ci2() {
        return q1q2ci2;
    }

    public void setQ1q2ci2(Double q1q2ci2) {
        this.q1q2ci2 = q1q2ci2;
    }

    public Double getQ1q2or() {
        return q1q2or;
    }

    public void setQ1q2or(Double q1q2or) {
        this.q1q2or = q1q2or;
    }

    public Double getQ1q3ci1() {
        return q1q3ci1;
    }

    public void setQ1q3ci1(Double q1q3ci1) {
        this.q1q3ci1 = q1q3ci1;
    }

    public Double getQ1q3ci2() {
        return q1q3ci2;
    }

    public void setQ1q3ci2(Double q1q3ci2) {
        this.q1q3ci2 = q1q3ci2;
    }

    public Double getQ1q3or() {
        return q1q3or;
    }

    public void setQ1q3or(Double q1q3or) {
        this.q1q3or = q1q3or;
    }

    public Double getQ1q4ci1() {
        return q1q4ci1;
    }

    public void setQ1q4ci1(Double q1q4ci1) {
        this.q1q4ci1 = q1q4ci1;
    }

    public Double getQ1q4ci2() {
        return q1q4ci2;
    }

    public void setQ1q4ci2(Double q1q4ci2) {
        this.q1q4ci2 = q1q4ci2;
    }

    public Double getQ1q4or() {
        return q1q4or;
    }

    public void setQ1q4or(Double q1q4or) {
        this.q1q4or = q1q4or;
    }

    public Double getCbeta() {
        return cbeta;
    }

    public void setCbeta(Double cbeta) {
        this.cbeta = cbeta;
    }

    public Double getCci1() {
        return cci1;
    }

    public void setCci1(Double cci1) {
        this.cci1 = cci1;
    }

    public Double getCci2() {
        return cci2;
    }

    public void setCci2(Double cci2) {
        this.cci2 = cci2;
    }

    public Double getLcogp() {
        return lcogp;
    }

    public void setLcogp(Double lcogp) {
        this.lcogp = lcogp;
    }

    public Double getCor() {
        return cor;
    }

    public void setCor(Double cor) {
        this.cor = cor;
    }

    public Double getCsebata() {
        return csebata;
    }

    public void setCsebata(Double csebata) {
        this.csebata = csebata;
    }

    @Override
    public String toString() {
        return "FileParserObject{" +
                "code='" + code + '\'' +
                ", pstring='" + pstring + '\'' +
                ", category='" + category + '\'' +
                ", grpnum='" + grpnum + '\'' +
                ", numcases=" + numcases +
                ", numcont=" + numcont +
                ", sex='" + sex + '\'' +
                ", q1q2ci1=" + q1q2ci1 +
                ", q1q2ci2=" + q1q2ci2 +
                ", q1q2or=" + q1q2or +
                ", q1q3ci1=" + q1q3ci1 +
                ", q1q3ci2=" + q1q3ci2 +
                ", q1q3or=" + q1q3or +
                ", q1q4ci1=" + q1q4ci1 +
                ", q1q4ci2=" + q1q4ci2 +
                ", q1q4or=" + q1q4or +
                ", cbeta=" + cbeta +
                ", cci1=" + cci1 +
                ", cci2=" + cci2 +
                ", lcogp=" + lcogp +
                ", cor=" + cor +
                ", csebata=" + csebata +
                '}';
    }
}
