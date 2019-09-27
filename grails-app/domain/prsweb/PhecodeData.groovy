package prsweb

class PhecodeData {

    String phecodeid
    String phecoderange
    String sex
    String pcategory
    String icdcode
    String icddesc
    String icdtype
    String phenome
    static transients = ['icddata']




    static constraints = {
    }

 /*   static mapping = {
        icddata formula: 'icdcode'+'(' + 'icddesc' + ')'
    }
*/
   String getIcddata()
   {
       String icddata = icdcode + "("+icddesc+")"
       return icddata
   }


}
