package prsweb

class Phecode {

    String phecodeid
    String phecodeid2
    String phecodedesc
    static transients = ['pdata']

    static constraints = {
    }

    String getPdata()
    {
        String pdata = phecodeid + ":"+phecodedesc
        return pdata
    }
}
