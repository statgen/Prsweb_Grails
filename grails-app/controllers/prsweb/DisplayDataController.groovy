//Hardcoded paths in the file are
///Users/snehalpatil/Documents/GithubProjects/PRSWEbData/shareSnehal


package prsweb

import com.google.gson.Gson
import grails.converters.JSON
import jdk.nashorn.internal.runtime.JSONFunctions

import javax.validation.ValidationException
import groovy.io.FileType
import groovy.json.JsonBuilder
import org.grails.web.json.JSONArray
import org.grails.web.json.JSONObject

import prsweb.sortPrsObject
import prsweb.FileParserObject

import java.text.DecimalFormat
import java.util.regex.Matcher
import java.util.regex.Pattern

//import static org.apache.http.HttpStatus.*

class DisplayDataController {

    DisplayDataService displayDataService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def main()
    {

        println("params from main $params")


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

        for(int i = 0 ; i < phenocat.size(); i++) {


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



        //THis is for second view where user will be able to the values from the table view


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

            def res =disobj.collect{
                en ->
                    return [phecode:en.phecodedata, phenome:en.phenomes,model:en.sourcedata, desc:en.descdata, snp:en.nsnp, r2nag:en.r2_nage, brier: en.brierScore, auc:en.auc, aucci:en.aucci, hom_chi:en.hosm_chi, hom_p:en.hosm_p,prsweb:en.prsweb,mgip:en.mgip,mgior:en.mgior,mgiorci:en.mgiorci,ukbp:en.ukbp,ukbor:en.ukbor,ukborci:en.ukborci]

            }

            phenamemap.put("phecodeObj", res)

           // println(res)

            jsonBuilder.add(phenamemap)

          // println(res)
        }

        Gson gson = new Gson();




        def resultJson = gson.toJson(jsonBuilder)

        def uniqPhecodesDesc = gson.toJson(uniquedescPhecode)

        //uniqPhecodesDesc.
           // println(resultJson)


        [drilldown:DisplayData.getAll(),resultJson:resultJson,phenocat:phenocat,uniqPhecodesDesc:uniqPhecodesDesc,jsonBuilder:jsonBuilder]

    }

    def index()
    {

    }

    def contact()
    {

    }

    def showGraph() {

        LinkedHashMap<String, Object> datajson = new HashMap<>()
        //println("params are $params")
        def inputprscode = params.phecode
        def inprscat = params.model.toString().toUpperCase()//source data eg. fingen
        def inprsstudy = params.phenome.toString()//eg MGI o UKB
        Gson gson = new Gson()
        DecimalFormat df = new DecimalFormat("#.###")
        def list = []


        def datadirpath = '/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/'
        //def datadirpath = '/net/dumbo/home/snehal/deploy1/data/'
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

        phenocatObj.each {colcatmapr.put(it.phename,it.color)}

        def dbphecode = '%'+inputprscode.toString().substring(0,inputprscode.toString().indexOf("."))+'%'
        //println("input dbphecode is $dbphecode")
        def displayObjselect = DisplayData.findAllByPhecodedataLike(dbphecode)

        LinkedHashMap<String, Object> pr = new HashMap<>()

        //println("from the loop source $displayObjselect")


        Set<String> uniquecode = new HashSet<String>(displayObjselect.phecodedata);

        LinkedHashMap<String, Object> codemap = new HashMap<>()

        uniquecode.each{

            //println("phecodedata is $it")

            def loopphecodedata = it
            def sourceSpeObje= displayObjselect.findAll { it.phecodedata.equals(loopphecodedata)}

            Set<String> uniquesrc = new HashSet<String>(sourceSpeObje.sourcedata);
            //println("uniqye source for this phecodedata is $uniquesrc")

            LinkedHashMap<String, Object> descmap = new HashMap<>()



            uniquesrc.each {
                def loopsrcdata = it

                //println("source is  is $loopsrcdata")

                def srcdata = sourceSpeObje.findAll{ it.sourcedata.equals(loopsrcdata)}
                //println("description for each source is $srcdata")


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
       // println("uniquecode $uniquecode")



        datajson.put("PRS_code_strings",displayObjselect.phecodedata)
        datajson.put("color_by_category",colcatmapr)

       // println(colcat)
        datajson.put("drilldown",uniquecode)







        LinkedHashMap<String, Object> color_by_category = new HashMap<>()



        LinkedHashMap<String, Object> phewas_df = new HashMap<>()

        JSONArray drilldown = new JSONArray()
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




        //println(drilldown)

//parse file name and check which matches the criteria..The file which matches the criteria will be added to the String phewasdf_json string and displayed to the user
        String phewasdf_json= ''


        //this is for phewas_df
        //*****************************************************************************************************************************************
        //find the file required based on the user selection
        //read column names and get the order
        //parse the file and create list of object
        //sort the object first using groupnum and then phewas_code
        //create the list of individual columns and create hashmap

        def fname, foundfname =''

        dir.eachFileRecurse(FileType.FILES) { file ->
            list << file
            //println(file.getName())
             fname = file.getName()
            Pattern p = Pattern.compile("Phecode(.*?)_(.*?)_(.*?)-[0-9]{8}_PRS-PheWAS_Results.txt");
            Matcher m = p.matcher(fname);
            String prscode=''
            String prsstudy=''
            String prssrc = ''
            if (m.find()) {

                prscode = m.group(1)
                prssrc = m.group(2)
                prsstudy = m.group(3)

            } else {
                //System.out.println("Did not fin the file $fname");

            }



            int testprint = 0

            //System.out.println("prssrc is $prssrc and inprscat is $inprscat");


            if (prscode.equals(inputprscode) && prssrc.equals(inprscat.toString().toUpperCase()) && prsstudy.equals(inprsstudy)) {
               // println("found the file")
                //println(fname)
                foundfname = fname

                ArrayList<FileParserObject> prsobjlist = new ArrayList<FileParserObject>()
                BufferedReader br = new BufferedReader(new FileReader(file))
                String line


                //Parse the header to get the position of the column names so they are used to parse the data:
                String header= br.readLine()
                String [] colname = header.split("\t")
                HashMap<String, Integer> colorder = new HashMap<>()
                for(int k=0; k < colname.size(); k++)
                {
                    colorder.put(colname[k],k)
                }
                //println(colorder)
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
                    FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp, cor, csebata)
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

        //this is for phewas_df_excluded
        //*****************************************************************************************************************************************


       //println(foundfname)
        String phewasexdf_json= ''



                def exfilepath = "/Users/snehalpatil/Documents/GithubProjects/PRSwebData/shareSnehal/data/phewas-exclusion/"+foundfname
                def phewas_ex_df_file=new File(exfilepath)

        LinkedHashMap<String, Object> phewas_ex_df = new HashMap<>()

        if(phewas_ex_df_file.exists())
        {


           // println("exclusion file exists")
            ArrayList<FileParserObject> prsexobjlist = new ArrayList<FileParserObject>()
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
                Double cor = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_OR")])).toDouble()
                Double csebata = String.format("%.3f", Double.parseDouble(tokens[colorder.get("PRS_SEBETA")])).toDouble()



                FileParserObject tempfpo = new FileParserObject(code, pstring, category, grpnum, numcases, numcont, sex, q1q2ci1, q1q2ci2, q1q2or, q1q3ci1, q1q3ci2, q1q3or, q1q4ci1, q1q4ci2, q1q4or, cbeta, cci1, cci2, lcogp, cor, csebata)
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

        def check = phewas_df as JSON
        datajson.put("phewas_df",phewas_df)
        datajson.put("phewas_ex_df",phewas_ex_df)

        def dataRes = gson.toJson(datajson)

        //rintln(phewasdf_json)








        [drilldown: drilldown, phewasdf_json: phewasdf_json,phewas_ex_df:phewasexdf_json,dataRes:dataRes]


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
