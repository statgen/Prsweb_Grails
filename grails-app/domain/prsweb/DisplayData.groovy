package prsweb

class DisplayData {

    String prefixdata
    String phecodedata
    String descdata

    String refdata
   // String sourcedata
    String urldata
    String ncases
    String ncontrols
    String sexdata
    String phenomes
    String outsource
    Integer nsnp
    Double r2_nage
    Double brierScore
    Double auc
    String aucci
    Double hosm_chi
    Double hosm_p
    int phecat
    String prsweb //indicates phenomwide significant

    String nomsig //nominal_significance
    String warreveff //warning_reversed_effect
    String perunpow
    String quaanal

    String pval
    String logpval
    String orval
    String orcival

    String prswebprefix
    String method

    String genld
    String source
    String datecreated

    String topor
    String toporci1
    String toporci2
    String topor2
    String toporci12
    String toporci22
    String topor5
    String toporci15
    String toporci25

    String tunparam
    String genomebuild




    /*
     String inputdata
     String mgip
    String mgior
    String mgiorci*/

  /*  String ukbp
    String ukbor
    String ukborci*/





    static constraints = {
    }
}
