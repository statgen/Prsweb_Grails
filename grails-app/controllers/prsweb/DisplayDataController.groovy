//Hardcoded paths in the file are
///Users/snehalpatil/Documents/GithubProjects/PRSWEbData/shareSnehal


package prsweb

import com.google.gson.Gson
import grails.converters.JSON
import grails.util.Environment
import jdk.nashorn.internal.runtime.JSONFunctions

import javax.validation.ValidationException
import groovy.io.FileType
import groovy.json.JsonBuilder
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

import prsweb.sortPrsObject
import prsweb.FileParserObject
import prsweb.getweightFileHeader

import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.regex.Matcher
import java.util.regex.Pattern
import groovy.time.*

//import static org.apache.http.HttpStatus.*

class DisplayDataController {

    DisplayDataService displayDataService
    // Export service provided by Export plugin
    def exportService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def test()
    {


    }

    def main()
    {

        println("params from main $params")
        Gson gson = new Gson();


        def phenocat = Phenotypecat.getAll()
        def phecode = Phecode.getAll()
        def dispUni = DisplayData.createCriteria()
        def uniqphecode2 = dispUni.list{

            eq("prsweb","TRUE")
            groupProperty("phecodedata")


        }.phecodedata.unique().collect{it.replace("X", '')}
        //println("********************")
       // println(uniqphecode2);

        def c2= Phecode.createCriteria()
        // select * from phecode where phecodeid in(select replace(phecodedata,"X",'')  from display_data where prsweb="TRUE" group by phecodedata);
        def phecodeuniquedata3 = c2.list {
            'in'("phecodeid", uniqphecode2)
            order("phecodeid", "asc")

        }
//println(phecodeuniquedata3)
        println("********************")
        ArrayList jsonBuilder = new ArrayList()
        ArrayList uniquedescPhecode = new ArrayList()

        def pheidunique = DisplayData.findAllWhere(phecat: 2).phecodedata.unique().collect{it.replace("X",'')}.toList()
        def c = Phecode.createCriteria()
        def phecodeuniquedata = c.list {
            'in'("phecodeid", pheidunique)
            order("phecodeid", "asc")

        }

        //println(phecodeuniquedata)


        //THis is for second view where user will be able to the values from the table view
        def formatter = new DecimalFormat("0.##E0");

        for(int i = 0 ; i < phenocat.size(); i++)
        {

            String phenocatname  = phenocat.get(i).phename
            int phenocatid = phenocat.get(i).id
            //println(pheid)
            def disobj = DisplayData.findAllWhere(phecat: phenocatid)
            LinkedHashMap<String, Object> phenamemap = new HashMap<>()
            phenamemap.put("phenocatname",phenocatname)
            phenamemap.put("phenocatid",phenocatid)


            //println(phecode.find {phecodeid:'171.1'}.phecodedesc)
//formatter.format



            def res =disobj.collect{
                en ->
                    return [refdata: en.refdata, urldata:en.urldata,pid:en.id,phecode:en.phecodedata, phenome:en.phenomes,prefixdata:en.prefixdata,prswebprefix:en.prswebprefix,model:en.outsource, desc:en.descdata, snp:en.nsnp, r2nag:en.r2_nage, brier: en.brierScore, auc:en.auc, aucci:en.aucci, hom_chi:en.hosm_chi, hom_p:en.hosm_p,prsweb:en.prsweb,pval:en.pval,logp:en.logpval,orval:en.orval,orcival:en.orcival,prsmethod:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal,
                            genld :en.genld,srcdata:en.source,datecreated:en.datecreated,topor:en.topor,topci1: en.toporci1,topci2:en.toporci2,tunp:en.tunparam,genob:en.genomebuild, topor2:en.topor2,topci12:en.toporci12,topci22:en.toporci22,topor5:en.topor5,topci15:en.toporci15,topci25:en.toporci25]
            }

            phenamemap.put("phecodeObj", res)

            // println(res)

            jsonBuilder.add(phenamemap)

            //println(res)
        }






        def resultJson = gson.toJson(jsonBuilder)

        def uniqPhecodesDesc = gson.toJson(uniquedescPhecode)



        //uniqPhecodesDesc.
        //println(uniquedescPhecode.findAll{ it.phenocatname.equals("Neoplasms")}.phecodetest)

        //println(resultJson)

        def drilldown = DisplayData.getAll()




        //[drilldown:DisplayData.getAll(),resultJson:resultJson,phenocat:phenocat,uniqPhecodesDesc:uniqPhecodesDesc,jsonBuilder:jsonBuilder]

        [drilldown:DisplayData.getAll(),resultJson:resultJson,phecodeuniquedata:phecodeuniquedata3,inputprscode:params.inputprscode,inprsstudy:params.inprsstudy]

    }

    def main_new()
    {

        println("params from main $params")
        Gson gson = new Gson();






        def phenocat = Phenotypecat.getAll()
        def phecode = Phecode.getAll()

        def dispUni = DisplayData.createCriteria()
        def uniqphecode2 = dispUni.list{

            eq("prsweb","TRUE")
            groupProperty("phecodedata")


        }.phecodedata.unique().collect{it.replace("X", '')}



        //println("********************")
        // println(uniqphecode2);





        def c2= Phecode.createCriteria()
        // select * from phecode where phecodeid in(select replace(phecodedata,"X",'')  from display_data where prsweb="TRUE" group by phecodedata);
        def phecodeuniquedata3 = c2.list {
            'in'("phecodeid", uniqphecode2)
            order("phecodeid", "asc")

        }
//println(phecodeuniquedata3)
        println("********************")
        ArrayList jsonBuilder = new ArrayList()
        ArrayList uniquedescPhecode = new ArrayList()
        //LinkedHashMap<String, Object> jsonBuilder = new HashMap<>()


        //Get the json in the format for each phenotype category : collect the phecode and information

        /*    for(int i = 0 ; i < phenocat.size(); i++) {


                LinkedHashMap<String, Object> phenocatmap = new HashMap<>()
                def phenocatobj = phenocat.get(i)
                def pheidunique = DisplayData.findAllWhere(phecat: phenocat.get(i).id.toInteger()).phecodedata.unique().collect{it.replace("X",'')}.toList()
                if(pheidunique.size() > 0 )
                {
                    def c = Phecode.createCriteria()
                    def phecodeuniquedata = c.list {
                        'in'("phecodeid", pheidunique)
                        order("phecodeid", "asc")

                    }
                    def pheunique = phecodeuniquedata.collect {phe -> return[phecodename:phe.phecodedesc,phecodeid:phe.phecodeid] }
                    phenocatmap.put("phenocatname",phenocatobj.phename)
                    phenocatmap.put("phenocatid",phenocatobj.id)
                    phenocatmap.put("phecodetest",pheunique)
                }
                else {
                    phenocatmap.put("phenocatname",phenocatobj.phename)
                    phenocatmap.put("phenocatid",phenocatobj.id)
                    phenocatmap.put("phecodetest",'')

                }

                uniquedescPhecode.add(phenocatmap)

            }
    */
        def pheidunique = DisplayData.findAllWhere(phecat: 2).phecodedata.unique().collect{it.replace("X",'')}.toList()
        def c = Phecode.createCriteria()
        def phecodeuniquedata = c.list {
            'in'("phecodeid", pheidunique)
            order("phecodeid", "asc")

        }

        //println(phecodeuniquedata)


        //THis is for second view where user will be able to the values from the table view
        def formatter = new DecimalFormat("0.##E0");

        for(int i = 0 ; i < phenocat.size(); i++)
        {

            String phenocatname  = phenocat.get(i).phename
            int phenocatid = phenocat.get(i).id
            //println(pheid)
            def disobj = DisplayData.findAllWhere(phecat: phenocatid)
            LinkedHashMap<String, Object> phenamemap = new HashMap<>()
            phenamemap.put("phenocatname",phenocatname)
            phenamemap.put("phenocatid",phenocatid)


            //println(phecode.find {phecodeid:'171.1'}.phecodedesc)
//formatter.format



            def res =disobj.collect{
                en ->
                    return [refdata: en.refdata, urldata:en.urldata,pid:en.id,phecode:en.phecodedata, phenome:en.phenomes,prefixdata:en.prefixdata,prswebprefix:en.prswebprefix,model:en.outsource, desc:en.descdata, snp:en.nsnp, r2nag:en.r2_nage, brier: en.brierScore, auc:en.auc, aucci:en.aucci, hom_chi:en.hosm_chi, hom_p:en.hosm_p,prsweb:en.prsweb,pval:en.pval,logp:en.logpval,orval:en.orval,orcival:en.orcival,prsmethod:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal,
                            genld :en.genld,srcdata:en.source,datecreated:en.datecreated,topor:en.topor,topci1: en.toporci1,topci2:en.toporci2,tunp:en.tunparam,genob:en.genomebuild, topor2:en.topor2,topci12:en.toporci12,topci22:en.toporci22,topor5:en.topor5,topci15:en.toporci15,topci25:en.toporci25]
            }

            phenamemap.put("phecodeObj", res)

            // println(res)

            jsonBuilder.add(phenamemap)

            //println(res)
        }






        def resultJson = gson.toJson(jsonBuilder)

        def uniqPhecodesDesc = gson.toJson(uniquedescPhecode)



        //uniqPhecodesDesc.
        //println(uniquedescPhecode.findAll{ it.phenocatname.equals("Neoplasms")}.phecodetest)

        //println(resultJson)

        def drilldown = DisplayData.getAll()




        //[drilldown:DisplayData.getAll(),resultJson:resultJson,phenocat:phenocat,uniqPhecodesDesc:uniqPhecodesDesc,jsonBuilder:jsonBuilder]

        [drilldown:DisplayData.getAll(),resultJson:resultJson,phecodeuniquedata:phecodeuniquedata3,inputprscode:params.inputprscode,inprsstudy:params.inprsstudy]

    }



    def displayTable()
    {
            println("params from the displayParams $params ")

        //select_desc:153, select_phenomes:MGI, select_odds:1, submit:upload, controller:displayData, format:null, action:displayTable]

        def phecode = params.select_desc
        def phenome =params.select_phenomes
        def oddratio = params.select_odds


        //this part is needed to display list of cancer traits which has pRsWeb true

        def dispUni = DisplayData.createCriteria()
        def uniqphecode2 = dispUni.list{

            eq("prsweb","TRUE")
            groupProperty("phecodedata")


        }.phecodedata.unique().collect{it.replace("X", '')} //got the list of the phecodes which has prs


        def c2= Phecode.createCriteria()
        // select * from phecode where phecodeid in(select replace(phecodedata,"X",'')  from display_data where prsweb="TRUE" group by phecodedata);
        def phecodeuniquedata3 = c2.list {
            'in'("phecodeid", uniqphecode2)
            order("phecodeid", "asc")

        }
        //println(phecodeuniquedata3)

        //select distinct(phenomes) from display_data where phecodedata ='X153';


        def dispO = DisplayData.createCriteria()

        def tempphecode = "X"+phecode

        def uniPhe = dispO.list{

            eq("phecodedata",tempphecode)

        }.phenomes.unique()

       println(uniPhe)




       //def disobj = DisplayData.findAllWhere(phecodedata: tempphecode)

        def dobj = DisplayData.createCriteria()
        def disFilObj = dobj.list{

            'eq' ("phecodedata",tempphecode)
            'eq'("phenomes",phenome)
        }


        println("size of the filtered object")
        println(disFilObj.phenomes.unique())
               //To get specific phenomes to selected


        DecimalFormat df = new DecimalFormat("0", DecimalFormatSymbols.getInstance(Locale.ENGLISH));
        df.setMaximumFractionDigits(600); // 340 = DecimalFormat.DOUBLE_FRACTION_DIGITS

       // System.out.println(df.format(1e-571));

        def res =disFilObj.collect{
            en ->
                return [refdata: en.refdata, urldata:en.urldata,pid:en.id,phecodedata:en.phecodedata, phenomes:en.phenomes,prefixdata:en.prefixdata,prswebprefix:en.prswebprefix,outsource:en.outsource, descdata:en.descdata, nsnp:en.nsnp, r2_nage:en.r2_nage, brierScore: en.brierScore, auc:en.auc, aucci:en.aucci, hosm_chi:en.hosm_chi, hosm_p:en.hosm_p,prsweb:en.prsweb,pval:en.pval,logpval:en.logpval,orval:en.orval,orcival:en.orcival,method:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal,
                        genld :en.genld,source:en.source,datecreated:en.datecreated,topor:en.topor,toporci1: en.toporci1,toporci2:en.toporci2,tunparam:en.tunparam,genomebuild:en.genomebuild, topor2:en.topor2,toporci12:en.toporci12,toporci22:en.toporci22,topor5:en.topor5,toporci15:en.toporci15,toporci25:en.toporci25,topor10:en.topor10,toporci110:en.toporci110,toporci210:en.toporci210, topor25:en.topor25,toporci125:en.toporci125,toporci225:en.toporci225,gwassource:en.gwassource]
        }











        [phecode:phecode,phenome:phenome, phenomes:uniPhe,odds:oddratio,phecodeuniquedata:phecodeuniquedata3,disobj:res]


    }

    def method()
    {


    }

    def news()
    {


    }
    def getPhenome()
    {
        def phecode = "X"+params.val1
        def phenomes = DisplayData.findAllByPhecodedata(phecode).phenomes.unique()

        render phenomes


    }


    def main_old()
    {

        println("params from main $params")
        Gson gson = new Gson();


       /* def dir = new File("/Users/snehalpatil/Documents/GithubProjects/PRSweb-master/data/phewas")
        JSONArray drilldown = new JSONArray()
        def list = []


        dir.eachFileRecurse(FileType.FILES) { file ->
            list << file
            //println(file.getName())

            JSONObject fileDetails = new JSONObject();
            def fname = file.getName()
            Pattern p = Pattern.compile("Phecode(.*?)_(.*?)_(.*?)-[0-9]{8}_PRS-PheWAS_Results.txt");
            Matcher m = p.matcher(fname);
            def prscode, prsstudy, prssrc = ''
            if (m.find()) {

                prscode = m.group(1)
                prssrc = m.group(2)
                prsstudy = m.group(3)

                fileDetails.put("prscode", prscode)
                fileDetails.put("prssrc", prssrc)
                fileDetails.put("prsstudy", prsstudy)
                drilldown.add(fileDetails)


            }
        }*/

/*

THis part will be needed for the tree view
        ArrayList phecodelist = DisplayData.getAll().phecodedata
        HashMap<String, ArrayList<String>> phecodemap = new HashMap<>()


        for(int i = 0 ; i < phecodelist.size(); i++)
        {
            String mainkey
            if(phecodelist.get(i).contains("."))
            {
                mainkey= phecodelist.get(i).substring(0,phecodelist.get(i).indexOf(".") )
            }
           else{
                mainkey= phecodelist.get(i)

            }
           //println(mainkey)

            if(phecodemap.containsKey(mainkey))
            {
                ArrayList phevalue = phecodemap.get(mainkey)
                if(!phevalue.contains(phecodelist.get(i)) && !phecodelist.get(i).equals(mainkey))
                {
                    //phevalue.add(phecodelist.get(i))
                    phecodemap.get(mainkey).add(phecodelist.get(i));
                }
            }
            else
            {

                ArrayList newentry = new ArrayList()
                def entry = phecodelist.get(i)
                if(!mainkey.equals(entry))
                {
                    newentry.add(phecodelist.get(i))
                    //println("mainkey is $mainkey and entry os $entry ")

                }

                //println("mainkey is $mainkey and outside the loop entry os $entry ")
               // println(mainkey.size())
               // println(entry.size())
                phecodemap.put(mainkey,newentry)
            }

            //println(phecodemap)



        }*/

//
        /*
        FOr the fist dropdown menu steps are below

        Get all the phecodedata(id ) from the display_data table for each phenotype categogy
        Get there unique description.for e. g.
        3	1	C3_TONGUENAS	X145.2	Malignant neoplasm of other and unspecified parts of tongue
        80	1	C01	            X145.2	Diagnoses - main ICD10: C01 Malignant neoplasm of base of tongue
        81	1	C02	            X145.2	Diagnoses - main ICD10: C02 Malignant neoplasm of other and unspecified parts of tongue
        124	1	20001_1011	    X145.2	Cancer code; self-reported: tongue cancer

        SO GWAS collection(display_data) tables file has different desc for the phecode while the phecode table has only single desctiption that is
        Cancer of tougue

        SO for the first list trying to get the unique description then when user selects the



         */
        def phenocat = Phenotypecat.getAll()
        def phecode = Phecode.getAll()

       ArrayList jsonBuilder = new ArrayList()
       ArrayList uniquedescPhecode = new ArrayList()
        //LinkedHashMap<String, Object> jsonBuilder = new HashMap<>()


        //Get the json in the format for each phenotype category : collect the phecode and information

    /*    for(int i = 0 ; i < phenocat.size(); i++) {


            LinkedHashMap<String, Object> phenocatmap = new HashMap<>()
            def phenocatobj = phenocat.get(i)
            def pheidunique = DisplayData.findAllWhere(phecat: phenocat.get(i).id.toInteger()).phecodedata.unique().collect{it.replace("X",'')}.toList()
            if(pheidunique.size() > 0 )
            {
                def c = Phecode.createCriteria()
                def phecodeuniquedata = c.list {
                    'in'("phecodeid", pheidunique)
                    order("phecodeid", "asc")

                }
                def pheunique = phecodeuniquedata.collect {phe -> return[phecodename:phe.phecodedesc,phecodeid:phe.phecodeid] }
                phenocatmap.put("phenocatname",phenocatobj.phename)
                phenocatmap.put("phenocatid",phenocatobj.id)
                phenocatmap.put("phecodetest",pheunique)
            }
            else {
                phenocatmap.put("phenocatname",phenocatobj.phename)
                phenocatmap.put("phenocatid",phenocatobj.id)
                phenocatmap.put("phecodetest",'')

            }

            uniquedescPhecode.add(phenocatmap)

        }
*/
        def pheidunique = DisplayData.findAllWhere(phecat: 2).phecodedata.unique().collect{it.replace("X",'')}.toList()
        def c = Phecode.createCriteria()
        def phecodeuniquedata = c.list {
            'in'("phecodeid", pheidunique)
            order("phecodeid", "asc")

        }

        //println(phecodeuniquedata)


        //THis is for second view where user will be able to the values from the table view
        def formatter = new DecimalFormat("0.##E0");

        for(int i = 0 ; i < phenocat.size(); i++)
        {

            String phenocatname  = phenocat.get(i).phename
            int phenocatid = phenocat.get(i).id
            //println(pheid)
            def disobj = DisplayData.findAllWhere(phecat: phenocatid)
            LinkedHashMap<String, Object> phenamemap = new HashMap<>()
            phenamemap.put("phenocatname",phenocatname)
            phenamemap.put("phenocatid",phenocatid)


            //println(phecode.find {phecodeid:'171.1'}.phecodedesc)
//formatter.format



            def res =disobj.collect{
                en ->
                    return [refdata: en.refdata, urldata:en.urldata,pid:en.id,phecode:en.phecodedata, phenome:en.phenomes,prefixdata:en.prefixdata,prswebprefix:en.prswebprefix,model:en.outsource, desc:en.descdata, snp:en.nsnp, r2nag:en.r2_nage, brier: en.brierScore, auc:en.auc, aucci:en.aucci, hom_chi:en.hosm_chi, hom_p:en.hosm_p,prsweb:en.prsweb,pval:en.pval,logp:en.logpval,orval:en.orval,orcival:en.orcival,prsmethod:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal,
                            genld :en.genld,srcdata:en.source,datecreated:en.datecreated,topor:en.topor,topci1: en.toporci1,topci2:en.toporci2,tunp:en.tunparam,genob:en.genomebuild, topor2:en.topor2,topci12:en.toporci12,topci22:en.toporci22,topor5:en.topor5,topci15:en.toporci15,topci25:en.toporci25]
            }

            phenamemap.put("phecodeObj", res)

           // println(res)

            jsonBuilder.add(phenamemap)

           //println(res)
        }






        def resultJson = gson.toJson(jsonBuilder)

        def uniqPhecodesDesc = gson.toJson(uniquedescPhecode)



        //uniqPhecodesDesc.
        //println(uniquedescPhecode.findAll{ it.phenocatname.equals("Neoplasms")}.phecodetest)

        //println(resultJson)

        def drilldown = DisplayData.getAll()




        //[drilldown:DisplayData.getAll(),resultJson:resultJson,phenocat:phenocat,uniqPhecodesDesc:uniqPhecodesDesc,jsonBuilder:jsonBuilder]

        [drilldown:DisplayData.getAll(),resultJson:resultJson,phecodeuniquedata:phecodeuniquedata,inputprscode:params.inputprscode,inprsstudy:params.inprsstudy]

    }

    def getWtFileInfo()
    {

        println(params)
        String [] tokens = params.val1.toString().split(":")

        def fname  = tokens[1]
        def lno  = tokens[0]
        def datadirpath
        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version2/PRSweb_Update_20190801/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/data/'
        }
        def filepath =datadirpath+fname+"_WEIGHTS.txt"
        def file = new File(filepath)

        println(file.exists())



        BufferedReader br = new BufferedReader(new FileReader(filepath))
        String line

        String infof  = lno+":"

        while ((line = br.readLine()) != null) {



            if(line.contains("##"))
            {
               // println(line)
                infof = infof + line.replace("##" ,"") + "\n" ;
            }



        }



        println(infof.split(":")[0])

        println(infof)


        render infof


    }

    def getTableData()
    {

        println(params)
        def prswt = "X"+params.prswt
        def phenomes = params.phenome

        // select * from display_data where phecodedata = "X172.2" and phenomes="MGI";
        def c = DisplayData.createCriteria()
        def displaydatatable = c.list {
            'in'("phecodedata", prswt)
            order("phenomes", "phenomes")

        }



        def res =displaydatatable.collect{
            en ->
                return [pid:en.id,phecode:en.phecodedata,wtfiletext: new getweightFileHeader().readWtFile(en.prswebprefix), phenome:en.phenomes,prswebprefix:en.prswebprefix,model:en.outsource, desc:en.descdata, snp:en.nsnp, r2nag:en.r2_nage, brier: en.brierScore, auc:en.auc, aucci:en.aucci, hom_chi:en.hosm_chi, hom_p:en.hosm_p,prsweb:en.prsweb,pval:en.pval,orval:en.orval,orcival:en.orcival,prsmethod:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal]
        }

        //println(res)

        def tbodyup = ''

        for(int i = 0; i < res.size(); i++)
        {
            println(res.get(i).phecode)
        }




       for(int i = 0; i < res.size(); i++)
        {

            def filepathlink = '${createLink(action:\'downloadFile\')}?filename='+ res.get(i).prswebprefix;

            def filelinkpage ='<a class="intro" href="'+filepathlink +'">link</a>';




            def popuplink = '<span onclick="displayInfo(\''+res.get(i).prswebprefix+'\')"> <i class="fa fa-info-circle"></i> </span>';




            def str =   '<tr>'
            +'<td>'+res.get(i).model+'</td>'
            +'<td>'+res(i).model+'</td>'
            +'<td>'+res(i).desc+'</td>'
            +'<td>'+res(i).snp+'</td>'
            +'<td>'+res(i).r2nag+'</td>'
            +'<td>'+res(i).brier+'</td>'
            +'<td>'+res(i).auc+'</td>'
            +'<td>'+res(i).aucci+'</td>'
            +'<td>'+res(i).hom_p+'</td>'
            +'<td>'+res(i).hom_chi+'</td>'
            +'<td>'+res(i).prsmethod+'</td>'
            +'<td>'+res(i).orval+'</td>'

            +'<td>'+res(i).pval+'</td>'

            +'<td>'+res(i).orci+'</td>'
           // +'<td>'+linkpage+'</td>'
            +'<td data-toggle="popover" data-trigger="hover" title=" test"  data-content="'+res.get(i).wtfiletext +'">' +  filelinkpage+ '</td>'


            +'</tr>';

            tbodyup = tbodyup+str;



        }

        //println(tbodyup)

                    render tbodyup


    }

    def downloadMainTable()
    {
        println(params)

        //select_desc=153&select_phenomes=MGI&select_odds=1


        def phecode = params.phecode
        def phenome =params.phenome
        def oddratio = params.oddratio
        def tempphecode = "X"+phecode



        def dobj = DisplayData.createCriteria()
        def disFilObj = dobj.list{

            'eq' ("phecodedata",tempphecode)
            'eq'("phenomes",phenome)
        }


        println("size of the filtered object")
        println(oddratio.getClass())
        //To get specific phenomes to selected


        def res =disFilObj.collect{
            en ->
                return [refdata: en.refdata, urldata:en.urldata,pid:en.id,phecodedata:en.phecodedata, phenomes:en.phenomes,prefixdata:en.prefixdata,prswebprefix:en.prswebprefix,outsource:en.outsource, descdata:en.descdata, nsnp: en.nsnp, r2_nage:en.r2_nage, brierScore: en.brierScore, auc:en.auc, aucci:en.aucci, hosm_chi:en.hosm_chi, hosm_p:en.hosm_p,prsweb:en.prsweb,pval:String.format("%.3e",Math.pow(10, (-en.logpval.toBigDecimal()))),logpval:en.logpval,orval:en.orval,orcival:en.orcival,method:en.method,nomsig:en.nomsig,warreveff :en.warreveff,perunpow:en.perunpow,quaanal:en.quaanal,
                        genld :en.genld,source:en.source,datecreated:en.datecreated,topor:en.topor,topci1: en.toporci1,topci2:en.toporci2,tunparam:en.tunparam,genomebuild:en.genomebuild, topor2:en.topor2,toporci12:en.toporci12,toporci22:en.toporci22,topor5:en.topor5,toporci15:en.toporci15,toporci25:en.toporci25,topor10:en.topor10,toporci110:en.toporci110,toporci210:en.toporci210, topor25:en.topor25,toporci125:en.toporci125,toporci225:en.toporci225,gwassource:en.gwassource]
        }
        def datadirpath

        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version7/PRSweb_Update_20191112/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/phecode/'
        }


        def filename = phecode+"_"+phenome+"_"+oddratio+".txt"
        def filepath = datadirpath + filename
        File phecodefile = new File(filepath)
        BufferedWriter bw = new BufferedWriter(new FileWriter(phecodefile));
        def headerline = "Phecode\t Gwas Source \t Description \t.Method \t Tuning Parameter \t # SNPS  \t P-Value \t Psuedo-R2 \t Brier Score \t AUC Estimate \t AUC 95% CI \t Hosmer-Lemeshow P  \t  Hosmer-Lemeshow Chi-square \t Odds Ratio Estimate \t Odds Ratio ORCI1  \t Odds Ratio ORCI2 \t PRSweb \t Nominal Significance \t WARNING_REVERSED_EFFECT \n";
        bw.write(headerline)
        println(headerline)

        for(int i = 0; i < disFilObj.size(); i++) {

            String line = ''
            def topor
            def toporci1
            def toporci2

            println(disFilObj[i].gwassource)
            if(oddratio.toInteger() == 1)
            {
                topor = disFilObj[i].topor
                toporci1=disFilObj[i].toporci1
                toporci2=  disFilObj[i].toporci2
            }
            else if(oddratio.toInteger() == 2)
            {
                topor = disFilObj[i].topor2
                toporci1=disFilObj[i].toporci12
                toporci2=  disFilObj[i].toporci22

            }
            else if(oddratio.toInteger() == 5)
            {
                topor = disFilObj[i].topor5
                toporci1=disFilObj[i].toporci15
                toporci2=  disFilObj[i].toporci25

            }
            else if(oddratio.toInteger() == 10)
            {
                topor = disFilObj[i].topor10
                toporci1=disFilObj[i].toporci110
                toporci2=  disFilObj[i].toporci210

            }
            else if(oddratio.toInteger() == 25)
            {
                topor = disFilObj[i].topor25
                toporci1=disFilObj[i].toporci125
                toporci2=  disFilObj[i].toporci225

            }

            line = phecode+"\t"+disFilObj[i].gwassource+"\t"+disFilObj[i].descdata+"\t"+disFilObj[i].method+"\t"+disFilObj[i].tunparam+"\t"+disFilObj[i].nsnp+"\t"+disFilObj[i].pval+"\t"+disFilObj[i].r2_nage+"\t"+disFilObj[i].brierScore+"\t"+disFilObj[i].auc+"\t"+disFilObj[i].aucci+"\t"+disFilObj[i].hosm_p+"\t"+disFilObj[i].hosm_chi+"\t"+topor+"\t"+toporci1+"\t"+toporci2+"\t"+disFilObj[i].prsweb+"\t"+disFilObj[i].nomsig+"\t"+disFilObj[i].warreveff+"\n";

            println(line)
            bw.write(line)



        }

        bw.close()
        render file: phecodefile, fileName: filename,contentType: 'text/rtf'
    }

    def downloadData()
    {
        def dispUni = DisplayData.createCriteria()
        def uniqphecode2 = dispUni.list{

            eq("prsweb","TRUE")
            groupProperty("phecodedata")


        }.phecodedata.unique().collect{it.replace("X", '')} //got the list of the phecodes which has prs

        def c2= Phecode.createCriteria()

        def phecodeuniquedata3 = c2.list {
            'in'("phecodeid", uniqphecode2)
            order("phecodeid", "asc")

        }



        [phecodeuniquedata3:phecodeuniquedata3]

    }



    def downloadFile ()
    {
println(params)
        def fname  = params.filename
        def datadirpath
        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version7/PRSweb_Update_20191112/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/data/'
        }

        def filepath
        if(params.type.equals("weight")) {
            filepath  = datadirpath + fname + "_WEIGHTS.txt"
        }
        else if(params.type.equals("df")) {
             filepath = datadirpath + fname + "_PRS_PHEWAS.txt"
        }
        else if(params.type.equals("excl")) {
             filepath = datadirpath + fname + "_EXCLUSION_PRS_PHEWAS.txt"
        }

        def file = new File(filepath)

        def dfname = fname+"_WEIGHTS.txt"

        println(file.getName())

        render file: new File (filepath), fileName: dfname,contentType: 'text/rtf'
    }

    def index()
    {

    }

    def contact()
    {

    }
//for version 20190801
    def showGraph() {

        def timeStart = new Date()

        def doneexobj
        def dbphecode
        LinkedHashMap<String, Object> datajson = new HashMap<>()
        Gson gson = new Gson()
        DecimalFormat df = new DecimalFormat("#.###")
        def list = []
        LinkedHashMap<String, Object> colcatmapr = new HashMap<>()


        println("params are $params")
        def inputprscode = params.phecode
        def inprscat = params.model.toString().toUpperCase()//source data eg. fingen
        def inprsstudy = params.phenome.toString()//eg MGI o UKB
        def inputid = params.id


        def dispObj = DisplayData.findById(inputid.toLong())

        def filepath = dispObj.prswebprefix
        println(filepath);

        def datadirpath = ''
        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version7/PRSweb_Update_20191112/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version3/PRSweb_Update_20190801/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/data/'
        }


        //def
        def dir = new File(datadirpath+"phewas")


        datajson.put("PRS_code",inputprscode)
        datajson.put("PRS_source",inprscat)
        datajson.put("PRS_study",inprsstudy)



        def weights_out_fname_37 =datadirpath +filepath+"_WEIGHTS.txt"
        //def weights_out_fname_38 =datadirpath +"weights-GRCH37/"+inputprscode+"_"+inprscat+"__GRCH38_Weights.txt"

        def weights37 =new File(weights_out_fname_37)
        if(!weights37.exists())
        {
            weights_out_fname_37 ='None'
            //println("37 weights doesnt exists")

        }


        datajson.put("weights37_fname",weights_out_fname_37)

//If the phecode hax extension then to get a;ll the entries for eg. to catct all the 172.1 172.2 172.22
        if(inputprscode.toString().contains("."))
        {

            dbphecode = '%'+inputprscode.toString().substring(0,inputprscode.toString().indexOf("."))+'%'
        }
        else
        {
            dbphecode = '%'+inputprscode.toString()
        }


        def phenocatObj = Phenotypecat.getAll()

        //println("input dbphecode is $dbphecode")
        def displayObjselect = DisplayData.findAllByPhecodedataLike(dbphecode)


        LinkedHashMap<String, Object> pr = new HashMap<>()
        Set<String> uniquecode = new HashSet<String>(displayObjselect.phecodedata);
        LinkedHashMap<String, Object> codemap = new HashMap<>()


        uniquecode.each{
            def loopphecodedata = it
            def sourceSpeObje= displayObjselect.findAll { it.phecodedata.equals(loopphecodedata)}
            Set<String> uniquesrc = new HashSet<String>(sourceSpeObje.descdata);
            //println("uniqye source for this phecodedata is $uniquesrc")
            LinkedHashMap<String, Object> descmap = new HashMap<>()
            uniquesrc.each {
                def loopsrcdata = it
                def srcdata = sourceSpeObje.findAll{ it.descdata.equals(loopsrcdata)}
                def list2= []
                srcdata.each {
                    def desc = it.descdata
                    def studies = it.phenomes
                    list2 << ['info': desc, 'studies':studies]
                }
                descmap.put(loopsrcdata,list2)
            }

            codemap.put(loopphecodedata,descmap)


        }

        //THis code is to get PRS_code_strings
        LinkedHashMap<String, Object> prsstringmap = new HashMap<>()
        uniquecode.each {prsstringmap.put(it.replace("X",""),Phecode.findByPhecodeid(it.replace("X","")).phecodedesc)}
        datajson.put("PRS_code_strings",prsstringmap)
        println("uniquecode $prsstringmap")

        //This code is to get color by category
        phenocatObj.each {colcatmapr.put(it.phename,it.color)}
        datajson.put("color_by_category",colcatmapr)

        //println(displayObjselect)
        datajson.put("drilldown",uniquecode)
        LinkedHashMap<String, Object> phewas_df = new HashMap<>()
        def donejson=''





        //println(gson.toJson(drilldown))*/

//parse file name and check which matches the criteria..The file which matches the criteria will be added to the String phewasdf_json string and displayed to the user



        //this is for phewas_df
        //*****************************************************************************************************************************************
        //find the file required based on the user selection
        //read column names and get the order
        //parse the file and create list of object
        //sort the object first using groupnum and then phewas_code
        //create the list of individual columns and create hashmap

        def fname=''
        def foundfname =''
        String phewasdf_json= ''
        ArrayList<FileParserObject> prsobjlist = new ArrayList<FileParserObject>()

        def timeinmiddle = new Date()
        TimeDuration duration = TimeCategory.minus(timeinmiddle, timeStart)
        println("Before startign to read the file $duration")


                def phewasdffile = datadirpath+filepath+"_PRS_PHEWAS.txt"

                def phewas_df_file=new File(phewasdffile)

                def exfilepath = datadirpath+filepath+"_EXCLUSION_PRS_PHEWAS.txt"


        if(phewas_df_file.exists()) {

                    BufferedReader br = new BufferedReader(new FileReader(phewasdffile))
                    String line
                    println("Phewas file exists")
                    println(phewas_df_file.getName())

                    //Parse the header to get the position of the column names so they are used to parse the data:
                    String header = br.readLine()
                    String[] colname = header.split("\t")
                    HashMap<String, Integer> colorder = new HashMap<>()
                    // as the column is not fixed , try to find the index based on the name of the column

                    for (int k = 0; k < colname.size(); k++) {
                        colorder.put(colname[k], k)
                    }

                    def timereadingfilestart = new Date()
                    TimeDuration duration1 = TimeCategory.minus(timereadingfilestart, timeinmiddle)
                    println("after got the name of the file $duration1")
                    while ((line = br.readLine()) != null) {
                        String[] tokens = line.split("\t")

                        String code = tokens[colorder.get("phewas_code")]
                        String pstring = tokens[colorder.get("phewas_string")]
                        String category = tokens[colorder.get("group")]
                        String grpnum = tokens[colorder.get("groupnum")]
                        int numcases = Integer.parseInt(tokens[colorder.get("MatchedCases")])
                        //column used MatchedControls
                        int numcont = Integer.parseInt(tokens[colorder.get("MatchedControls")])
                        String sex = tokens[colorder.get("sex")]

                        //println(tokens[28].getClass())
                        Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI1")])).toDouble()
                        Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI2")])).toDouble()
                        Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_OR")])).toDouble()

                        Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI1")])).toDouble()
                        Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI2")])).toDouble()
                        Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_OR")])).toDouble()

                        Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI1")])).toDouble()
                        Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI2")])).toDouble()
                        Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_OR")])).toDouble()

                        Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_BETA")])).toDouble()
                        Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI1")])).toDouble()
                        Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI2")])).toDouble()
                        //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                        Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_log10P")])).toDouble()
                        Double prsp = Double.parseDouble(tokens[colorder.get("PRS_P")])
                        Double prsfromlogp =   String.format("%.3e",Math.pow(10, (-lcogp))).toDouble()
                        //Double prsfromlogp = Math.pow(10, (-lcogp))
                        Double cor = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_OR")])).toDouble()
                        Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_SEBETA")])).toDouble()

                        FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp, prsfromlogp, cor, csebata)
                        prsobjlist.add(tempfpo)

                    }

                    br.close()

                    // println(prsobjlist.code)
                    //Sort the list by grp name and then by code so they all stay together
                    Collections.sort(prsobjlist, new Comparator<FileParserObject>() {
                        @Override
                        public int compare(FileParserObject u1, FileParserObject u2) {


                            int x3 = Integer.parseInt(u1.getGrpnum());
                            int x4 = Integer.parseInt(u2.getGrpnum());
                            int sComp = x3.compareTo(x4)
                            if (sComp != 0) {
                                return sComp
                            } else {
                                Double x1 = Double.parseDouble(u1.getCode());
                                Double x2 = Double.parseDouble(u2.getCode());
                                return x1.compareTo(x2)
                            }
                            // return u1.getCategory().compareTo(u2.getCategory());
                        }
                    });

                    def timereadingfiledone1 = new Date()
            println(timereadingfiledone1)
                    TimeDuration duration2 = TimeCategory.minus(timereadingfiledone1, timereadingfilestart)
                    println("done reading and sorted object $duration2")

                    ArrayList<String> categorylist = new ArrayList<String>()
                    ArrayList<String> codelist = new ArrayList<String>()
                    ArrayList<String> complist = new ArrayList<String>()
                    ArrayList<String> numcaselist = new ArrayList<String>()
                    ArrayList<String> numconlist = new ArrayList<String>()
                    ArrayList<String> sexlist = new ArrayList<String>()
                    ArrayList<String> pbsstringlist = new ArrayList<String>()


                    LinkedHashMap<String, Object> q1q2 = new HashMap<>()
                    LinkedHashMap<String, Object> q1q3 = new HashMap<>()
                    LinkedHashMap<String, Object> q1q4 = new HashMap<>()
                    LinkedHashMap<String, Object> contlist = new HashMap<>()
                    LinkedHashMap<String, Object> comparisons = new HashMap<>()

                    q1q2.put("ci1", prsobjlist.q1q2ci1)
                    q1q2.put("ci2", prsobjlist.q1q2ci2)
                    q1q2.put("or", prsobjlist.q1q2or)
                    comparisons.put("Q1Q2", q1q2)

                    q1q3.put("ci1", prsobjlist.q1q3ci1)
                    q1q3.put("ci2", prsobjlist.q1q3ci2)
                    q1q3.put("or", prsobjlist.q1q3or)
                    comparisons.put("Q1Q3", q1q3)

                    q1q4.put("ci1", prsobjlist.q1q4ci1)
                    q1q4.put("ci2", prsobjlist.q1q4ci2)
                    q1q4.put("or", prsobjlist.q1q4or)
                    comparisons.put("Q1Q4", q1q4)


                    contlist.put("beta", prsobjlist.cbeta)
                    contlist.put("ci1", prsobjlist.cci1)
                    contlist.put("ci2", prsobjlist.cci2)
                    contlist.put("logp", prsobjlist.lcogp)
                    contlist.put("or", prsobjlist.cor)
                    contlist.put("sebeta", prsobjlist.csebata)
                    comparisons.put("continuous", contlist)


                    categorylist = prsobjlist.category
                    codelist = prsobjlist.code
                    numcaselist = prsobjlist.numcases
                    numconlist = prsobjlist.numcont
                    sexlist = prsobjlist.sex
                    pbsstringlist = prsobjlist.pstring

                    phewas_df.put("category", categorylist)
                    phewas_df.put("code", codelist)
                    phewas_df.put("comparisons", comparisons)
                    phewas_df.put("num_cases", numcaselist)
                    phewas_df.put("num_controls", numconlist)
                    phewas_df.put("sex", sexlist)
                    phewas_df.put("string", pbsstringlist)

                    phewasdf_json = gson.toJson(phewas_df);

            donejson = new Date()
            TimeDuration djason = TimeCategory.minus(donejson, timereadingfiledone1)
            println(" required to create the phewas df json $djason")


        }




        //this is for phewas_df_excluded
        //*****************************************************************************************************************************************



        String phewasexdf_json= ''
        println(exfilepath)
        def phewas_ex_df_file=new File(exfilepath)

        LinkedHashMap<String, Object> phewas_ex_df = new HashMap<>()
        ArrayList<FileParserObject> prsexobjlist = new ArrayList<FileParserObject>()
        if(phewas_ex_df_file.exists())
        {
            println("exclusion file exists")
            BufferedReader brex = new BufferedReader(new FileReader(phewas_ex_df_file))
            String line2
            //Parse the header to get the position of the column names so they are used to parse the data:
            String headerex= brex.readLine()
            String [] colnameex = headerex.split("\t")
            HashMap<String, Integer> colorderex = new HashMap<>()
            for(int j=0; j < colnameex.size(); j++)
            {
                colorderex.put(colnameex[j],j)
            }
            while ((line2 = brex.readLine()) != null) {
                String[] tokens = line2.split("\t")
                String code = tokens[colorderex.get("phewas_code")]
                String pstring = tokens[colorderex.get("phewas_string")]
                String category = tokens[colorderex.get("group")]
                String grpnum = tokens[colorderex.get("groupnum")]
                int numcases = Integer.parseInt(tokens[colorderex.get("MatchedCases")])
                //column used MatchedControls
                int numcont = Integer.parseInt(tokens[colorderex.get("MatchedControls")])
                String sex = tokens[colorderex.get("sex")]

                //println(tokens[28].getClass())
                Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_CI1")])).toDouble()
                Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_CI2")])).toDouble()
                Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_OR")])).toDouble()

                Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_CI1")])).toDouble()
                Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_CI2")])).toDouble()
                Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_OR")])).toDouble()

                Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_CI1")])).toDouble()
                Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_CI2")])).toDouble()
                Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_OR")])).toDouble()

                Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_BETA")])).toDouble()
                Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_CI1")])).toDouble()
                Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_CI2")])).toDouble()
                //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_log10P")])).toDouble()
                Double prsp =  Double.parseDouble(tokens[colorderex.get("PRS_P")]).toBigDecimal()
                Double prsfromlogp = String.format("%.3e",Math.pow(10, (-lcogp))).toDouble()
                Double cor = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_OR")])).toDouble()
                Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_SEBETA")])).toDouble()



                FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp,prsfromlogp, cor, csebata)
                prsexobjlist.add(tempfpo)

            }

            brex.close()

            // println(prsobjlist.code)
            //Sort the list by grp name and then by code so they all stay together
            Collections.sort(prsexobjlist, new Comparator<FileParserObject>() {
                @Override
                public int compare(FileParserObject u1, FileParserObject u2) {


                    int x3 = Integer.parseInt(u1.getGrpnum());
                    int x4 = Integer.parseInt(u2.getGrpnum());
                    int sComp = x3.compareTo(x4)
                    if (sComp != 0) {
                        return sComp
                    } else {
                        Double x1 = Double.parseDouble(u1.getCode());
                        Double x2 = Double.parseDouble(u2.getCode());
                        return x1.compareTo(x2)
                    }
                    // return u1.getCategory().compareTo(u2.getCategory());
                }
            });



            doneexobj = new Date()
            TimeDuration exobjtime = TimeCategory.minus(doneexobj, donejson)
            println("done creating phewas ex df object and sortef $exobjtime")

            // println(prsobjlist.code)
            //println(prsobjlist.category)

            ArrayList<String> categorylistex = new ArrayList<String>()
            ArrayList<String> codelistex = new ArrayList<String>()
            ArrayList<String> complistex = new ArrayList<String>()
            ArrayList<String> numcaselistex = new ArrayList<String>()
            ArrayList<String> numconlistex = new ArrayList<String>()
            ArrayList<String> sexlistex = new ArrayList<String>()
            ArrayList<String> pbsstringlistex = new ArrayList<String>()


            LinkedHashMap<String, Object> q1q2ex = new HashMap<>()
            LinkedHashMap<String, Object> q1q3ex = new HashMap<>()
            LinkedHashMap<String, Object> q1q4ex = new HashMap<>()
            LinkedHashMap<String, Object> contlistex = new HashMap<>()
            LinkedHashMap<String, Object> comparisonsex = new HashMap<>()

            q1q2ex.put("ci1", prsexobjlist.q1q2ci1)
            q1q2ex.put("ci2", prsexobjlist.q1q2ci2)
            q1q2ex.put("or", prsexobjlist.q1q2or)
            comparisonsex.put("Q1Q2", q1q2ex)

            q1q3ex.put("ci1", prsexobjlist.q1q3ci1)
            q1q3ex.put("ci2", prsexobjlist.q1q3ci2)
            q1q3ex.put("or", prsexobjlist.q1q3or)
            comparisonsex.put("Q1Q3", q1q3ex)

            q1q4ex.put("ci1", prsexobjlist.q1q4ci1)
            q1q4ex.put("ci2", prsexobjlist.q1q4ci2)
            q1q4ex.put("or", prsexobjlist.q1q4or)
            comparisonsex.put("Q1Q4", q1q4ex)


            contlistex.put("beta", prsexobjlist.cbeta)
            contlistex.put("ci1", prsexobjlist.cci1)
            contlistex.put("ci2", prsexobjlist.cci2)
            contlistex.put("logp", prsexobjlist.lcogp)
            contlistex.put("or", prsexobjlist.cor)
            contlistex.put("sebeta", prsexobjlist.csebata)
            comparisonsex.put("continuous", contlistex)


            categorylistex = prsexobjlist.category
            codelistex = prsexobjlist.code
            numcaselistex = prsexobjlist.numcases
            numconlistex = prsexobjlist.numcont
            sexlistex = prsexobjlist.sex
            pbsstringlistex = prsexobjlist.pstring

            phewas_ex_df.put("category", categorylistex)
            phewas_ex_df.put("code", codelistex)
            phewas_ex_df.put("comparisons", comparisonsex)
            phewas_ex_df.put("num_cases", numcaselistex)
            phewas_ex_df.put("num_controls", numconlistex)
            phewas_ex_df.put("sex", sexlistex)
            phewas_ex_df.put("string", pbsstringlistex)

            phewasexdf_json = gson.toJson(phewas_ex_df);



        }
        else
        {
            println("exclusion file doesnt exists")
        }


        def check = phewas_df as JSON
        datajson.put("phewas_df",phewas_df)
        datajson.put("phewas_ex_df",phewas_ex_df)
        def dataRes = gson.toJson(datajson)



        if(params?.f && params.f != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.f]
            response.setHeader("Content-disposition", "attachment; filename=books.${params.extension}")

            exportService.export(params.f, response.outputStream,displayObjselect, [:], [:])
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }





        def endoffun = new Date()
        TimeDuration duration3 = TimeCategory.minus(endoffun, timeStart)
        println("Total duration:  $duration3")

        def pheobj = Phecode.findByPhecodeid(inputprscode)


        [dataRes:dataRes,prsobjlist:prsobjlist.sort{a,b -> a.prsp <=> b.prsp},prsexobjlist:prsexobjlist,inputid:inputid,dispObj:dispObj,pheobj:pheobj]


    }

    def showGraphMod() {

        def timeStart = new Date()

        def doneexobj
        def dbphecode
        LinkedHashMap<String, Object> datajson = new HashMap<>()
        Gson gson = new Gson()
        DecimalFormat df = new DecimalFormat("#.###")
        def list = []
        LinkedHashMap<String, Object> colcatmapr = new HashMap<>()


        println("params are $params")
        def inputprscode = params.phecode
        def inprscat = params.model.toString().toUpperCase()//source data eg. fingen
        def inprsstudy = params.phenome.toString()//eg MGI o UKB
        def inputid = params.id


        def dispObj = DisplayData.findById(inputid.toLong())

        def filepath = dispObj.prswebprefix
        println(filepath);

        def datadirpath = ''
        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version7/PRSweb_Update_20191112/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version3/PRSweb_Update_20190801/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/data/'
        }


        //def
        def dir = new File(datadirpath+"phewas")


        datajson.put("PRS_code",inputprscode)
        datajson.put("PRS_source",inprscat)
        datajson.put("PRS_study",inprsstudy)



        def weights_out_fname_37 =datadirpath +filepath+"_WEIGHTS.txt"
        //def weights_out_fname_38 =datadirpath +"weights-GRCH37/"+inputprscode+"_"+inprscat+"__GRCH38_Weights.txt"

        def weights37 =new File(weights_out_fname_37)
        if(!weights37.exists())
        {
            weights_out_fname_37 ='None'
            //println("37 weights doesnt exists")

        }


        datajson.put("weights37_fname",weights_out_fname_37)

//If the phecode hax extension then to get a;ll the entries for eg. to catct all the 172.1 172.2 172.22
        if(inputprscode.toString().contains("."))
        {

            dbphecode = '%'+inputprscode.toString().substring(0,inputprscode.toString().indexOf("."))+'%'
        }
        else
        {
            dbphecode = '%'+inputprscode.toString()
        }


        def phenocatObj = Phenotypecat.getAll()

        //println("input dbphecode is $dbphecode")
        def displayObjselect = DisplayData.findAllByPhecodedataLike(dbphecode)


        LinkedHashMap<String, Object> pr = new HashMap<>()
        Set<String> uniquecode = new HashSet<String>(displayObjselect.phecodedata);
        LinkedHashMap<String, Object> codemap = new HashMap<>()


        uniquecode.each{
            def loopphecodedata = it
            def sourceSpeObje= displayObjselect.findAll { it.phecodedata.equals(loopphecodedata)}
            Set<String> uniquesrc = new HashSet<String>(sourceSpeObje.descdata);
            //println("uniqye source for this phecodedata is $uniquesrc")
            LinkedHashMap<String, Object> descmap = new HashMap<>()
            uniquesrc.each {
                def loopsrcdata = it
                def srcdata = sourceSpeObje.findAll{ it.descdata.equals(loopsrcdata)}
                def list2= []
                srcdata.each {
                    def desc = it.descdata
                    def studies = it.phenomes
                    list2 << ['info': desc, 'studies':studies]
                }
                descmap.put(loopsrcdata,list2)
            }

            codemap.put(loopphecodedata,descmap)


        }

        //THis code is to get PRS_code_strings
        LinkedHashMap<String, Object> prsstringmap = new HashMap<>()
        uniquecode.each {prsstringmap.put(it.replace("X",""),Phecode.findByPhecodeid(it.replace("X","")).phecodedesc)}
        datajson.put("PRS_code_strings",prsstringmap)
        println("uniquecode $prsstringmap")

        //This code is to get color by category
        phenocatObj.each {colcatmapr.put(it.phename,it.color)}
        datajson.put("color_by_category",colcatmapr)

        //println(displayObjselect)
        datajson.put("drilldown",uniquecode)
        LinkedHashMap<String, Object> phewas_df = new HashMap<>()
        def donejson=''





        //println(gson.toJson(drilldown))*/

//parse file name and check which matches the criteria..The file which matches the criteria will be added to the String phewasdf_json string and displayed to the user



        //this is for phewas_df
        //*****************************************************************************************************************************************
        //find the file required based on the user selection
        //read column names and get the order
        //parse the file and create list of object
        //sort the object first using groupnum and then phewas_code
        //create the list of individual columns and create hashmap

        def fname=''
        def foundfname =''
        String phewasdf_json= ''
        ArrayList<FileParserObject> prsobjlist = new ArrayList<FileParserObject>()

        def timeinmiddle = new Date()
        TimeDuration duration = TimeCategory.minus(timeinmiddle, timeStart)
        println("Before startign to read the file $duration")


        def phewasdffile = datadirpath+filepath+"_PRS_PHEWAS.txt"

        def phewas_df_file=new File(phewasdffile)

        def exfilepath = datadirpath+filepath+"_EXCLUSION_PRS_PHEWAS.txt"


        if(phewas_df_file.exists()) {

            BufferedReader br = new BufferedReader(new FileReader(phewasdffile))
            String line
            println("Phewas file exists")
            println(phewas_df_file.getName())

            //Parse the header to get the position of the column names so they are used to parse the data:
            String header = br.readLine()
            String[] colname = header.split("\t")
            HashMap<String, Integer> colorder = new HashMap<>()
            // as the column is not fixed , try to find the index based on the name of the column

            for (int k = 0; k < colname.size(); k++) {
                colorder.put(colname[k], k)
            }

            def timereadingfilestart = new Date()
            TimeDuration duration1 = TimeCategory.minus(timereadingfilestart, timeinmiddle)
            println("after got the name of the file $duration1")
            while ((line = br.readLine()) != null) {
                String[] tokens = line.split("\t")

                String code = tokens[colorder.get("phewas_code")]
                String pstring = tokens[colorder.get("phewas_string")]
                String category = tokens[colorder.get("group")]
                String grpnum = tokens[colorder.get("groupnum")]
                int numcases = Integer.parseInt(tokens[colorder.get("MatchedCases")])
                //column used MatchedControls
                int numcont = Integer.parseInt(tokens[colorder.get("MatchedControls")])
                String sex = tokens[colorder.get("sex")]

                //println(tokens[28].getClass())
                Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI1")])).toDouble()
                Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI2")])).toDouble()
                Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_OR")])).toDouble()

                Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI1")])).toDouble()
                Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI2")])).toDouble()
                Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_OR")])).toDouble()

                Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI1")])).toDouble()
                Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI2")])).toDouble()
                Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_OR")])).toDouble()

                Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_BETA")])).toDouble()
                Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI1")])).toDouble()
                Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI2")])).toDouble()
                //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_log10P")])).toDouble()
                Double prsp = Double.parseDouble(tokens[colorder.get("PRS_P")])
                Double prsfromlogp =   String.format("%.3e",Math.pow(10, (-lcogp))).toDouble()
                //Double prsfromlogp = Math.pow(10, (-lcogp))
                Double cor = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_OR")])).toDouble()
                Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_SEBETA")])).toDouble()

                FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp, prsfromlogp, cor, csebata)
                prsobjlist.add(tempfpo)

            }

            br.close()

            // println(prsobjlist.code)
            //Sort the list by grp name and then by code so they all stay together
            Collections.sort(prsobjlist, new Comparator<FileParserObject>() {
                @Override
                public int compare(FileParserObject u1, FileParserObject u2) {


                    int x3 = Integer.parseInt(u1.getGrpnum());
                    int x4 = Integer.parseInt(u2.getGrpnum());
                    int sComp = x3.compareTo(x4)
                    if (sComp != 0) {
                        return sComp
                    } else {
                        Double x1 = Double.parseDouble(u1.getCode());
                        Double x2 = Double.parseDouble(u2.getCode());
                        return x1.compareTo(x2)
                    }
                    // return u1.getCategory().compareTo(u2.getCategory());
                }
            });

            def timereadingfiledone1 = new Date()
            println(timereadingfiledone1)
            TimeDuration duration2 = TimeCategory.minus(timereadingfiledone1, timereadingfilestart)
            println("done reading and sorted object $duration2")

            ArrayList<String> categorylist = new ArrayList<String>()
            ArrayList<String> codelist = new ArrayList<String>()
            ArrayList<String> complist = new ArrayList<String>()
            ArrayList<String> numcaselist = new ArrayList<String>()
            ArrayList<String> numconlist = new ArrayList<String>()
            ArrayList<String> sexlist = new ArrayList<String>()
            ArrayList<String> pbsstringlist = new ArrayList<String>()


            LinkedHashMap<String, Object> q1q2 = new HashMap<>()
            LinkedHashMap<String, Object> q1q3 = new HashMap<>()
            LinkedHashMap<String, Object> q1q4 = new HashMap<>()
            LinkedHashMap<String, Object> contlist = new HashMap<>()
            LinkedHashMap<String, Object> comparisons = new HashMap<>()

            q1q2.put("ci1", prsobjlist.q1q2ci1)
            q1q2.put("ci2", prsobjlist.q1q2ci2)
            q1q2.put("or", prsobjlist.q1q2or)
            comparisons.put("Q1Q2", q1q2)

            q1q3.put("ci1", prsobjlist.q1q3ci1)
            q1q3.put("ci2", prsobjlist.q1q3ci2)
            q1q3.put("or", prsobjlist.q1q3or)
            comparisons.put("Q1Q3", q1q3)

            q1q4.put("ci1", prsobjlist.q1q4ci1)
            q1q4.put("ci2", prsobjlist.q1q4ci2)
            q1q4.put("or", prsobjlist.q1q4or)
            comparisons.put("Q1Q4", q1q4)


            contlist.put("beta", prsobjlist.cbeta)
            contlist.put("ci1", prsobjlist.cci1)
            contlist.put("ci2", prsobjlist.cci2)
            contlist.put("logp", prsobjlist.lcogp)
            contlist.put("or", prsobjlist.cor)
            contlist.put("sebeta", prsobjlist.csebata)
            comparisons.put("continuous", contlist)


            categorylist = prsobjlist.category
            codelist = prsobjlist.code
            numcaselist = prsobjlist.numcases
            numconlist = prsobjlist.numcont
            sexlist = prsobjlist.sex
            pbsstringlist = prsobjlist.pstring

            phewas_df.put("category", categorylist)
            phewas_df.put("code", codelist)
            phewas_df.put("comparisons", comparisons)
            phewas_df.put("num_cases", numcaselist)
            phewas_df.put("num_controls", numconlist)
            phewas_df.put("sex", sexlist)
            phewas_df.put("string", pbsstringlist)

            phewasdf_json = gson.toJson(phewas_df);

            donejson = new Date()
            TimeDuration djason = TimeCategory.minus(donejson, timereadingfiledone1)
            println(" required to create the phewas df json $djason")


        }




        //this is for phewas_df_excluded
        //*****************************************************************************************************************************************



        String phewasexdf_json= ''
        println(exfilepath)
        def phewas_ex_df_file=new File(exfilepath)

        LinkedHashMap<String, Object> phewas_ex_df = new HashMap<>()
        ArrayList<FileParserObject> prsexobjlist = new ArrayList<FileParserObject>()
        if(phewas_ex_df_file.exists())
        {
            println("exclusion file exists")
            BufferedReader brex = new BufferedReader(new FileReader(phewas_ex_df_file))
            String line2
            //Parse the header to get the position of the column names so they are used to parse the data:
            String headerex= brex.readLine()
            String [] colnameex = headerex.split("\t")
            HashMap<String, Integer> colorderex = new HashMap<>()
            for(int j=0; j < colnameex.size(); j++)
            {
                colorderex.put(colnameex[j],j)
            }
            while ((line2 = brex.readLine()) != null) {
                String[] tokens = line2.split("\t")
                String code = tokens[colorderex.get("phewas_code")]
                String pstring = tokens[colorderex.get("phewas_string")]
                String category = tokens[colorderex.get("group")]
                String grpnum = tokens[colorderex.get("groupnum")]
                int numcases = Integer.parseInt(tokens[colorderex.get("MatchedCases")])
                //column used MatchedControls
                int numcont = Integer.parseInt(tokens[colorderex.get("MatchedControls")])
                String sex = tokens[colorderex.get("sex")]

                //println(tokens[28].getClass())
                Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_CI1")])).toDouble()
                Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_CI2")])).toDouble()
                Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q2_OR")])).toDouble()

                Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_CI1")])).toDouble()
                Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_CI2")])).toDouble()
                Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q3_OR")])).toDouble()

                Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_CI1")])).toDouble()
                Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_CI2")])).toDouble()
                Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("Q1Q4_OR")])).toDouble()

                Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_BETA")])).toDouble()
                Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_CI1")])).toDouble()
                Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_CI2")])).toDouble()
                //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_log10P")])).toDouble()
                Double prsp =  Double.parseDouble(tokens[colorderex.get("PRS_P")]).toBigDecimal()
                Double prsfromlogp = String.format("%.3e",Math.pow(10, (-lcogp))).toDouble()
                Double cor = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_OR")])).toDouble()
                Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorderex.get("PRS_SEBETA")])).toDouble()



                FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp,prsfromlogp, cor, csebata)
                prsexobjlist.add(tempfpo)

            }

            brex.close()

            // println(prsobjlist.code)
            //Sort the list by grp name and then by code so they all stay together
            Collections.sort(prsexobjlist, new Comparator<FileParserObject>() {
                @Override
                public int compare(FileParserObject u1, FileParserObject u2) {


                    int x3 = Integer.parseInt(u1.getGrpnum());
                    int x4 = Integer.parseInt(u2.getGrpnum());
                    int sComp = x3.compareTo(x4)
                    if (sComp != 0) {
                        return sComp
                    } else {
                        Double x1 = Double.parseDouble(u1.getCode());
                        Double x2 = Double.parseDouble(u2.getCode());
                        return x1.compareTo(x2)
                    }
                    // return u1.getCategory().compareTo(u2.getCategory());
                }
            });



            doneexobj = new Date()
            TimeDuration exobjtime = TimeCategory.minus(doneexobj, donejson)
            println("done creating phewas ex df object and sortef $exobjtime")

            // println(prsobjlist.code)
            //println(prsobjlist.category)

            ArrayList<String> categorylistex = new ArrayList<String>()
            ArrayList<String> codelistex = new ArrayList<String>()
            ArrayList<String> complistex = new ArrayList<String>()
            ArrayList<String> numcaselistex = new ArrayList<String>()
            ArrayList<String> numconlistex = new ArrayList<String>()
            ArrayList<String> sexlistex = new ArrayList<String>()
            ArrayList<String> pbsstringlistex = new ArrayList<String>()


            LinkedHashMap<String, Object> q1q2ex = new HashMap<>()
            LinkedHashMap<String, Object> q1q3ex = new HashMap<>()
            LinkedHashMap<String, Object> q1q4ex = new HashMap<>()
            LinkedHashMap<String, Object> contlistex = new HashMap<>()
            LinkedHashMap<String, Object> comparisonsex = new HashMap<>()

            q1q2ex.put("ci1", prsexobjlist.q1q2ci1)
            q1q2ex.put("ci2", prsexobjlist.q1q2ci2)
            q1q2ex.put("or", prsexobjlist.q1q2or)
            comparisonsex.put("Q1Q2", q1q2ex)

            q1q3ex.put("ci1", prsexobjlist.q1q3ci1)
            q1q3ex.put("ci2", prsexobjlist.q1q3ci2)
            q1q3ex.put("or", prsexobjlist.q1q3or)
            comparisonsex.put("Q1Q3", q1q3ex)

            q1q4ex.put("ci1", prsexobjlist.q1q4ci1)
            q1q4ex.put("ci2", prsexobjlist.q1q4ci2)
            q1q4ex.put("or", prsexobjlist.q1q4or)
            comparisonsex.put("Q1Q4", q1q4ex)


            contlistex.put("beta", prsexobjlist.cbeta)
            contlistex.put("ci1", prsexobjlist.cci1)
            contlistex.put("ci2", prsexobjlist.cci2)
            contlistex.put("logp", prsexobjlist.lcogp)
            contlistex.put("or", prsexobjlist.cor)
            contlistex.put("sebeta", prsexobjlist.csebata)
            comparisonsex.put("continuous", contlistex)


            categorylistex = prsexobjlist.category
            codelistex = prsexobjlist.code
            numcaselistex = prsexobjlist.numcases
            numconlistex = prsexobjlist.numcont
            sexlistex = prsexobjlist.sex
            pbsstringlistex = prsexobjlist.pstring

            phewas_ex_df.put("category", categorylistex)
            phewas_ex_df.put("code", codelistex)
            phewas_ex_df.put("comparisons", comparisonsex)
            phewas_ex_df.put("num_cases", numcaselistex)
            phewas_ex_df.put("num_controls", numconlistex)
            phewas_ex_df.put("sex", sexlistex)
            phewas_ex_df.put("string", pbsstringlistex)

            phewasexdf_json = gson.toJson(phewas_ex_df);



        }
        else
        {
            println("exclusion file doesnt exists")
        }


        def check = phewas_df as JSON
        datajson.put("phewas_df",phewas_df)
        datajson.put("phewas_ex_df",phewas_ex_df)
        def dataRes = gson.toJson(datajson)



        if(params?.f && params.f != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.f]
            response.setHeader("Content-disposition", "attachment; filename=books.${params.extension}")

            exportService.export(params.f, response.outputStream,displayObjselect, [:], [:])
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }





        def endoffun = new Date()
        TimeDuration duration3 = TimeCategory.minus(endoffun, timeStart)
        println("Total duration:  $duration3")

        def pheobj = Phecode.findByPhecodeid(inputprscode)


        [dataRes:dataRes,prsobjlist:prsobjlist.sort{a,b -> a.prsp <=> b.prsp},prsexobjlist:prsexobjlist,inputid:inputid,dispObj:dispObj,pheobj:pheobj]


    }

    def downloadPhewasFile()
    {
        println(params)
    }


    //for version 20190429
    def showGraphOld() {

        def timeStart = new Date()
        def timereadingfiledone
        def doneexobj

        LinkedHashMap<String, Object> datajson = new HashMap<>()
        println("params are $params")
        def inputprscode = params.phecode
        def inprscat = params.model.toString().toUpperCase()//source data eg. fingen
        def inprsstudy = params.phenome.toString()//eg MGI o UKB
        Gson gson = new Gson()
        DecimalFormat df = new DecimalFormat("#.###")
        def list = []


        def datadirpath = ''
        if (Environment.current == Environment.DEVELOPMENT) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/version7/PRSweb_Update_20191112/data/'
        } else
        if (Environment.current == Environment.TEST) {
            datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/'
        } else
        if (Environment.current == Environment.PRODUCTION) {
            datadirpath = '/var/lib/tomcat8/webapps/data/'
        }


        //def
        def dir = new File(datadirpath+"phewas")


        datajson.put("PRS_code",inputprscode)
        datajson.put("PRS_source",inprscat)
        datajson.put("PRS_study",inprsstudy)



        def weights_out_fname_37 =datadirpath +"weights-GRCH37/"+inputprscode+"_"+inprscat+"__GRCH37_Weights.txt"
        def weights_out_fname_38 =datadirpath +"weights-GRCH37/"+inputprscode+"_"+inprscat+"__GRCH38_Weights.txt"

        def weights37 =new File(weights_out_fname_37)
        def weights38 = new File(weights_out_fname_38)
        if(!weights37.exists())
        {
            weights_out_fname_37 ='None'
            //println("37 weights doesnt exists")

        }
        if(!weights38.exists())
        {
            weights_out_fname_38 ='None'
            //println("38 weights doesnt exists")

        }

        datajson.put("weights37_fname",weights_out_fname_37)
        datajson.put("weights38_fname",weights_out_fname_38)

        def phenocatObj = Phenotypecat.getAll()
        LinkedHashMap<String, Object> colcatmapr = new HashMap<>()

        def dbphecode
        if(inputprscode.toString().contains("."))
        {

            dbphecode = '%'+inputprscode.toString().substring(0,inputprscode.toString().indexOf("."))+'%'
        }
        else
        {
            dbphecode = '%'+inputprscode.toString()
        }


        //println("input dbphecode is $dbphecode")
        def displayObjselect = DisplayData.findAllByPhecodedataLike(dbphecode)
        LinkedHashMap<String, Object> pr = new HashMap<>()
        Set<String> uniquecode = new HashSet<String>(displayObjselect.phecodedata);
        LinkedHashMap<String, Object> codemap = new HashMap<>()
        uniquecode.each{
            def loopphecodedata = it
            def sourceSpeObje= displayObjselect.findAll { it.phecodedata.equals(loopphecodedata)}
            Set<String> uniquesrc = new HashSet<String>(sourceSpeObje.sourcedata);
            //println("uniqye source for this phecodedata is $uniquesrc")
            LinkedHashMap<String, Object> descmap = new HashMap<>()
            uniquesrc.each {
                def loopsrcdata = it
                def srcdata = sourceSpeObje.findAll{ it.sourcedata.equals(loopsrcdata)}
                def list2= []
                srcdata.each {
                    def desc = it.descdata
                    def studies = it.phenomes
                    list2 << ['info': desc, 'studies':studies]
                }
                descmap.put(loopsrcdata,list2)
            }

            codemap.put(loopphecodedata,descmap)


        }

        //THis code is to get PRS_code_strings
        LinkedHashMap<String, Object> prsstringmap = new HashMap<>()
        uniquecode.each {prsstringmap.put(it.replace("X",""),Phecode.findByPhecodeid(it.replace("X","")).phecodedesc)}
        datajson.put("PRS_code_strings",prsstringmap)
        println("uniquecode $prsstringmap")

        //This code is to get color by category
        phenocatObj.each {colcatmapr.put(it.phename,it.color)}
        datajson.put("color_by_category",colcatmapr)

       //println(displayObjselect)
        datajson.put("drilldown",uniquecode)
        LinkedHashMap<String, Object> color_by_category = new HashMap<>()



        LinkedHashMap<String, Object> phewas_df = new HashMap<>()

        /*JSONArray drilldown = new JSONArray()
        dir.eachFileRecurse(FileType.FILES) { file ->
            list << file
            //println(file.getName())

            JSONObject fileDetails = new JSONObject();
            def fname = file.getName()
            Pattern p = Pattern.compile("Phecode(.*?)_(.*?)_(.*?)-[0-9]{8}_PRS-PheWAS_Results.txt");
            Matcher m = p.matcher(fname);
            def prscode, prsstudy, prssrc = ''
            if (m.find()) {

                prscode = m.group(1)
                prssrc = m.group(2)
                prsstudy = m.group(3)
                fileDetails.put("prscode", prscode)
                fileDetails.put("prssrc", prssrc)
                fileDetails.put("prsstudy", prsstudy)
                drilldown.add(fileDetails)
            }
        }




        //println(gson.toJson(drilldown))*/

//parse file name and check which matches the criteria..The file which matches the criteria will be added to the String phewasdf_json string and displayed to the user



        //this is for phewas_df
        //*****************************************************************************************************************************************
        //find the file required based on the user selection
        //read column names and get the order
        //parse the file and create list of object
        //sort the object first using groupnum and then phewas_code
        //create the list of individual columns and create hashmap

        def fname=''
        def foundfname =''
        String phewasdf_json= ''
        ArrayList<FileParserObject> prsobjlist = new ArrayList<FileParserObject>()

        def timeinmiddle = new Date()
        TimeDuration duration = TimeCategory.minus(timeinmiddle, timeStart)
        println("Before startign to read the file $duration")

        dir.eachFileRecurse(FileType.FILES) { file ->
            list << file
            //println(file.getName())
             fname = file.getName()

                                                //Phecode153__GWAS-CATALOG-R2019-05-03__MGI-20190429__PRS-PheWAS_Results.txt

            Pattern p = Pattern.compile("Phecode(.*?)_(.*?)_(.*?)-[0-9]{8}_PRS-PheWAS_Results.txt");

            //Pattern p = Pattern.compile("Phecode(.*?)__(.*?)__(.*?)-[0-9]{8}__PRS-PheWAS_Results.txt");
            //Phecode153__GWAS-CATALOG-R2019-05-03__MGI-20190429__PRS-PheWAS_Results.txt
            Matcher m = p.matcher(fname);
            String prscode=''
            String prsstudy=''
            String prssrc = ''
            if (m.find()) {

                prscode = m.group(1)
                prssrc = m.group(2)
                prsstudy = m.group(3)

               // println("prscode"+prscode+"prssrc"+prssrc+"prsstudy"+prsstudy)

            } else {
                //System.out.println("Did not fin the file $fname");

            }



            int testprint = 0

                //System.out.println("prscode is $prscode prscode input $inputprscode is $prssrc and inprscat is $inprscat");

            if (prscode.equals(inputprscode) && prssrc.contains(inprscat.toString().toUpperCase().replace("_","-")) && prsstudy.equals(inprsstudy)) {
                //println("found the file")
                //println(fname)
                foundfname = fname


                BufferedReader br = new BufferedReader(new FileReader(file))
                String line


                //Parse the header to get the position of the column names so they are used to parse the data:
                String header= br.readLine()
                String [] colname = header.split("\t")
                HashMap<String, Integer> colorder = new HashMap<>()
                // as the column is not fixed , try to find the index based on the name of the column

                for(int k=0; k < colname.size(); k++)
                {
                    colorder.put(colname[k],k)
                }

                def timereadingfilestart = new Date()
                TimeDuration duration1 = TimeCategory.minus(timereadingfilestart, timeinmiddle)
                println("after got the name of the file $duration1")
                while ((line = br.readLine()) != null) {
                    String[] tokens = line.split("\t")

                    String code = tokens[colorder.get("phewas_code")]
                    String pstring = tokens[colorder.get("phewas_string")]
                    String category = tokens[colorder.get("group")]
                    String grpnum = tokens[colorder.get("groupnum")]
                    int numcases = Integer.parseInt(tokens[colorder.get("MatchedCases")])
                    //column used MatchedControls
                    int numcont = Integer.parseInt(tokens[colorder.get("MatchedControls")])
                    String sex = tokens[colorder.get("sex")]

                    //println(tokens[28].getClass())
                    Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI1")])).toDouble()
                    Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI2")])).toDouble()
                    Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_OR")])).toDouble()

                    Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI1")])).toDouble()
                    Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI2")])).toDouble()
                    Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_OR")])).toDouble()

                    Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI1")])).toDouble()
                    Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI2")])).toDouble()
                    Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_OR")])).toDouble()

                    Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_BETA")])).toDouble()
                    Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI1")])).toDouble()
                    Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI2")])).toDouble()
                    //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                    Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_LOGP")])).toDouble()
                    Double prsp = Double.parseDouble(tokens[colorder.get("PRS_P")])
                    Double cor = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_OR")])).toDouble()
                    Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_SEBETA")])).toDouble()
                  /*  if(testprint == 0)
                    {

                        //println("FileParserObject{" +
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
                                '}')
                    }*/

                    testprint =  1
                    FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp, prsp,cor, csebata)
                    prsobjlist.add(tempfpo)

                }

                br.close()

                // println(prsobjlist.code)
                //Sort the list by grp name and then by code so they all stay together
                Collections.sort(prsobjlist, new Comparator<FileParserObject>() {
                    @Override
                    public int compare(FileParserObject u1, FileParserObject u2) {


                        int x3 = Integer.parseInt(u1.getGrpnum());
                        int x4 = Integer.parseInt(u2.getGrpnum());
                        int sComp = x3.compareTo(x4)
                        if (sComp != 0) {
                            return sComp
                        } else {
                            Double x1 = Double.parseDouble(u1.getCode());
                            Double x2 = Double.parseDouble(u2.getCode());
                            return x1.compareTo(x2)
                        }
                        // return u1.getCategory().compareTo(u2.getCategory());
                    }
                });

                timereadingfiledone = new Date()
                TimeDuration duration2 = TimeCategory.minus(timereadingfiledone, timereadingfilestart)
                println("done reading and sorted object $duration2")






                // println(prsobjlist.code)
                //println(prsobjlist.category)

                ArrayList<String> categorylist = new ArrayList<String>()
                ArrayList<String> codelist = new ArrayList<String>()
                ArrayList<String> complist = new ArrayList<String>()
                ArrayList<String> numcaselist = new ArrayList<String>()
                ArrayList<String> numconlist = new ArrayList<String>()
                ArrayList<String> sexlist = new ArrayList<String>()
                ArrayList<String> pbsstringlist = new ArrayList<String>()


                LinkedHashMap<String, Object> q1q2 = new HashMap<>()
                LinkedHashMap<String, Object> q1q3 = new HashMap<>()
                LinkedHashMap<String, Object> q1q4 = new HashMap<>()
                LinkedHashMap<String, Object> contlist = new HashMap<>()
                LinkedHashMap<String, Object> comparisons = new HashMap<>()

                q1q2.put("ci1", prsobjlist.q1q2ci1)
                q1q2.put("ci2", prsobjlist.q1q2ci2)
                q1q2.put("or", prsobjlist.q1q2or)
                comparisons.put("Q1Q2", q1q2)

                q1q3.put("ci1", prsobjlist.q1q3ci1)
                q1q3.put("ci2", prsobjlist.q1q3ci2)
                q1q3.put("or", prsobjlist.q1q3or)
                comparisons.put("Q1Q3", q1q3)

                q1q4.put("ci1", prsobjlist.q1q4ci1)
                q1q4.put("ci2", prsobjlist.q1q4ci2)
                q1q4.put("or", prsobjlist.q1q4or)
                comparisons.put("Q1Q4", q1q4)


                contlist.put("beta", prsobjlist.cbeta)
                contlist.put("ci1", prsobjlist.cci1)
                contlist.put("ci2", prsobjlist.cci2)
                contlist.put("logp", prsobjlist.lcogp)
                contlist.put("or", prsobjlist.cor)
                contlist.put("sebeta", prsobjlist.csebata)
                comparisons.put("continuous", contlist)


                categorylist = prsobjlist.category
                codelist = prsobjlist.code
                numcaselist = prsobjlist.numcases
                numconlist = prsobjlist.numcont
                sexlist = prsobjlist.sex
                pbsstringlist = prsobjlist.pstring

                phewas_df.put("category", categorylist)
                phewas_df.put("code", codelist)
                phewas_df.put("comparisons", comparisons)
                phewas_df.put("num_cases", numcaselist)
                phewas_df.put("num_controls", numconlist)
                phewas_df.put("sex", sexlist)
                phewas_df.put("string", pbsstringlist)

                phewasdf_json = gson.toJson(phewas_df);
            }

        }

        def donejson = new Date()
        TimeDuration djason = TimeCategory.minus(donejson, timereadingfiledone)
        println(" required to create the phewas df json $djason")


        //this is for phewas_df_excluded
        //*****************************************************************************************************************************************


       println(foundfname)
        String phewasexdf_json= ''



                def exfilepath = datadirpath +"phewas-exclusion/"+foundfname
        println(exfilepath)
                def phewas_ex_df_file=new File(exfilepath)

        LinkedHashMap<String, Object> phewas_ex_df = new HashMap<>()
        ArrayList<FileParserObject> prsexobjlist = new ArrayList<FileParserObject>()

        println("phewas exclusion file status ")
        println(phewas_ex_df_file.exists())
        println("***************************************")

        if(phewas_ex_df_file.exists())
        {


            println("exclusion file exists")
            BufferedReader brex = new BufferedReader(new FileReader(phewas_ex_df_file))
            String line
            //Parse the header to get the position of the column names so they are used to parse the data:
            String headerex= brex.readLine()
            String [] colnameex = headerex.split("\t")
            HashMap<String, Integer> colorder = new HashMap<>()
            for(int k=0; k < colnameex.size(); k++)
            {
                colorder.put(colnameex[k],k)
            }

            while ((line = brex.readLine()) != null) {
                String[] tokens = line.split("\t")
                String code = tokens[colorder.get("phewas_code")]
                String pstring = tokens[colorder.get("phewas_string")]
                String category = tokens[colorder.get("group")]
                String grpnum = tokens[colorder.get("groupnum")]
                int numcases = Integer.parseInt(tokens[colorder.get("MatchedCases")])
                //column used MatchedControls
                int numcont = Integer.parseInt(tokens[colorder.get("MatchedControls")])
                String sex = tokens[colorder.get("sex")]

                //println(tokens[28].getClass())
                Double q1q2ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI1")])).toDouble()
                Double q1q2ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_CI2")])).toDouble()
                Double q1q2or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q2_OR")])).toDouble()

                Double q1q3ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI1")])).toDouble()
                Double q1q3ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_CI2")])).toDouble()
                Double q1q3or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q3_OR")])).toDouble()

                Double q1q4ci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI1")])).toDouble()
                Double q1q4ci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_CI2")])).toDouble()
                Double q1q4or = String.format("%.3f", Double.parseDouble(tokens[colorder.get("Q1Q4_OR")])).toDouble()

                Double cbeta = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_BETA")])).toDouble()
                Double cci1 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI1")])).toDouble()
                Double cci2 = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_CI2")])).toDouble()
                //Double lcogp = String.format("%.3f", sortPrsObject.str2neglog10(Double.parseDouble(tokens[colorder.get("PRS_LOGP")]))).toDouble()
                Double lcogp = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_LOGP")])).toDouble()
                Double prsp =  Double.parseDouble(tokens[colorder.get("PRS_P")]).toBigDecimal()
                Double cor = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_OR")])).toDouble()
                Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_SEBETA")])).toDouble()



                FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp,prsp, cor, csebata)
                prsexobjlist.add(tempfpo)

            }

            brex.close()

            // println(prsobjlist.code)
            //Sort the list by grp name and then by code so they all stay together
            Collections.sort(prsexobjlist, new Comparator<FileParserObject>() {
                @Override
                public int compare(FileParserObject u1, FileParserObject u2) {


                    int x3 = Integer.parseInt(u1.getGrpnum());
                    int x4 = Integer.parseInt(u2.getGrpnum());
                    int sComp = x3.compareTo(x4)
                    if (sComp != 0) {
                        return sComp
                    } else {
                        Double x1 = Double.parseDouble(u1.getCode());
                        Double x2 = Double.parseDouble(u2.getCode());
                        return x1.compareTo(x2)
                    }
                    // return u1.getCategory().compareTo(u2.getCategory());
                }
            });



             doneexobj = new Date()
            TimeDuration exobjtime = TimeCategory.minus(doneexobj, donejson)
            println("done creating phewas ex df object and sortef $exobjtime")

            // println(prsobjlist.code)
            //println(prsobjlist.category)

            ArrayList<String> categorylist = new ArrayList<String>()
            ArrayList<String> codelist = new ArrayList<String>()
            ArrayList<String> complist = new ArrayList<String>()
            ArrayList<String> numcaselist = new ArrayList<String>()
            ArrayList<String> numconlist = new ArrayList<String>()
            ArrayList<String> sexlist = new ArrayList<String>()
            ArrayList<String> pbsstringlist = new ArrayList<String>()


            LinkedHashMap<String, Object> q1q2 = new HashMap<>()
            LinkedHashMap<String, Object> q1q3 = new HashMap<>()
            LinkedHashMap<String, Object> q1q4 = new HashMap<>()
            LinkedHashMap<String, Object> contlist = new HashMap<>()
            LinkedHashMap<String, Object> comparisons = new HashMap<>()

            q1q2.put("ci1", prsexobjlist.q1q2ci1)
            q1q2.put("ci2", prsexobjlist.q1q2ci2)
            q1q2.put("or", prsexobjlist.q1q2or)
            comparisons.put("Q1Q2", q1q2)

            q1q3.put("ci1", prsexobjlist.q1q3ci1)
            q1q3.put("ci2", prsexobjlist.q1q3ci2)
            q1q3.put("or", prsexobjlist.q1q3or)
            comparisons.put("Q1Q3", q1q3)

            q1q4.put("ci1", prsexobjlist.q1q4ci1)
            q1q4.put("ci2", prsexobjlist.q1q4ci2)
            q1q4.put("or", prsexobjlist.q1q4or)
            comparisons.put("Q1Q4", q1q4)


            contlist.put("beta", prsexobjlist.cbeta)
            contlist.put("ci1", prsexobjlist.cci1)
            contlist.put("ci2", prsexobjlist.cci2)
            contlist.put("logp", prsexobjlist.lcogp)
            contlist.put("or", prsexobjlist.cor)
            contlist.put("sebeta", prsexobjlist.csebata)
            comparisons.put("continuous", contlist)


            categorylist = prsexobjlist.category
            codelist = prsexobjlist.code
            numcaselist = prsexobjlist.numcases
            numconlist = prsexobjlist.numcont
            sexlist = prsexobjlist.sex
            pbsstringlist = prsexobjlist.pstring

            phewas_ex_df.put("category", categorylist)
            phewas_ex_df.put("code", codelist)
            phewas_ex_df.put("comparisons", comparisons)
            phewas_ex_df.put("num_cases", numcaselist)
            phewas_ex_df.put("num_controls", numconlist)
            phewas_ex_df.put("sex", sexlist)
            phewas_ex_df.put("string", pbsstringlist)





            phewasexdf_json = gson.toJson(phewas_ex_df);



        }

        else
        {
            //println("exclusion file doesnt exists")
        }

        def exdfjson = new Date()
        TimeDuration duration6 = TimeCategory.minus(exdfjson, doneexobj)
        println("create json for phewas ex df $duration6")

        def check = phewas_df as JSON
        datajson.put("phewas_df",phewas_df)
        datajson.put("phewas_ex_df",phewas_ex_df)

        def dataRes = gson.toJson(datajson)

        println()


        //println()

        if(params?.f && params.f != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.f]
            response.setHeader("Content-disposition", "attachment; filename=books.${params.extension}")

            exportService.export(params.format, response.outputStream,displayObjselect                                                               , [:], [:])
            response.getOutputStream().flush();
            response.getOutputStream().close();
        }





        def endoffun = new Date()
        TimeDuration duration3 = TimeCategory.minus(endoffun, timeStart)
        println("Total duration:  $duration3")


        [dataRes:dataRes,prsobjlist:prsobjlist.sort{a,b -> a.prsp <=> b.prsp},prsexobjlist:prsexobjlist]


    }

    def show(Long id) {
        respond displayDataService.get(id)
    }

    def create() {
        respond new DisplayData(params)
    }

    def save(DisplayData displayData) {
        if (displayData == null) {
            notFound()
            return
        }

        try {
            displayDataService.save(displayData)
        } catch (ValidationException e) {
            respond displayData.errors, view: 'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'displayData.label', default: 'DisplayData'), displayData.id])
                redirect displayData
            }
            '*' { respond displayData, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond displayDataService.get(id)
    }

    def update(DisplayData displayData) {
        if (displayData == null) {
            notFound()
            return
        }

        try {
            displayDataService.save(displayData)
        } catch (ValidationException e) {
            respond displayData.errors, view: 'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'displayData.label', default: 'DisplayData'), displayData.id])
                redirect displayData
            }
            '*' { respond displayData, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        displayDataService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'displayData.label', default: 'DisplayData'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'displayData.label', default: 'DisplayData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
