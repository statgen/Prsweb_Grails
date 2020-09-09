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

    String topor10
    String toporci110
    String toporci210
    String topor25
    String toporci125
    String toporci225

    String tunparam
    String genomebuild

    String gwassource

    Double aauc
    String aauc_ci



    String uploadtoprsweb//used to display the model first column into the main table

    String referenceurl




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
