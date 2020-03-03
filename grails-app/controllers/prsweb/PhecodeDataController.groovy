package prsweb

import grails.util.Environment
import grails.validation.ValidationException
//import static org.eclipse.jetty.http.HttpStatus.*
import grails.converters.JSON

class PhecodeDataController {

    PhecodeDataService phecodeDataService
    def exportService


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 500, 1000)
        respond phecodeDataService.list(params), model:[phecodeDataCount: phecodeDataService.count()]
    }

    def show(Long id) {
        respond phecodeDataService.get(id)
    }

    def create() {
        respond new PhecodeData(params)
    }

    def showPhecode() {


        def phecodeid = params.pid.toDouble()

        def results = PhecodeData.findAllByPhecodeid(phecodeid)


    }

    def searchPhecode()
    {



    }
    def displayTable()
    {
        println("1")
        def phecodeData = PhecodeData.getAll()
        println("2")
        def phecode = PhecodeData.getAll();
        println("3")

        def results = phecodeData.collect {
            en ->
                return [phecodeid: en.phecodeid,phecodedesc : phecode.find {it.phecodeid ==en.phecodeid },range:en.phecoderange, sex: en.sex, cat: en.pcategory, icdcode : en.icdcode, icddesc: en.icddesc, type:en.icdtype,phenome:en.icdtype]
        }
        println("4")




    }

    def showPhecodeInfo()
    {
        println(params)

        def fil = params.fil.toString()
        def searchterm = params.q?.toString()
        println(searchterm)
        def pinfo = PhecodeData.createCriteria()
        def phecodedata

        if(fil.equals("icd"))
        {

            phecodedata =pinfo.list {
                ilike ("icddesc", searchterm+"%")
                order("icddesc", "asc")
            }

        }
        else if(fil.equals('phecodename'))
        {
            def pdesc = (searchterm.contains(":"))? searchterm.substring(searchterm.indexOf(":")+1,searchterm.length()) : searchterm

           // def phecodedesc = Phecode.findByPhecodeid(searchterm)

           def phecodedesc = Phecode.withCriteria {
                eq 'phecodedesc', pdesc
            }



            println(phecodedesc.phecodeid2[0].toString())

            println(phecodedesc.phecodeid2.toString().replaceAll("\\[|\\]",""))

            // println(phecode)
            phecodedata = pinfo.list {
                eq ("phecodeid", phecodedesc.phecodeid2.toString().replaceAll("\\[|\\]",""))
                order("icddesc", "asc")
            }


        }
        else
        {

             def pdesc = searchterm.substring(searchterm.indexOf(":")+1,searchterm.length())

            def phecodedesc = Phecode.findByPhecodeid(searchterm)

            println("phecodedesc.phecodeid2[0].toString()")

            println(phecodedesc.phecodeid2)

           // println(phecode)
            phecodedata = pinfo.list {
                eq ("phecodeid", phecodedesc.phecodeid2.toString())
                order("icddesc", "asc")
            }


        }
//println(phecodedata.phecodeid)
            println("***************")
        //println(Phecode.findAllByPhecodeid2008))
        println("***************")
        def phecoreres = phecodedata.collect {
            en -> return[phecodeid : en.phecodeid,pdesc:Phecode.findAllByPhecodeid2(en.phecodeid).phecodedesc[0],icdcode:en.icdcode,prange:en.phecoderange,icddesc:en.icddesc,icdtype:en.icdtype,sex:en.sex,pcategory:en.pcategory,phenome:en.phenome]
        }

        if(params?.f && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.f]
            response.setHeader("Content-disposition", "attachment; filename=${searchterm}.${params.extension}")

            exportService.export(params.f, response.outputStream,phecoreres, [:], [:])

        }




        //println(phecoreres)


  [phecoreres:phecoreres, fil: fil,q:searchterm]



    }

    def downloadPhecodeTable()
    {


        def filename ="test.txt"
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
        def filepath = datadirpath + filename
        File phecodefile = new File(filepath)
        BufferedWriter bw = new BufferedWriter(new FileWriter(phecodefile));
        def headerline = "Phecode ID\t Phecode Description \t.Range \t Sex  \t Category  \t ICD COde \t Desc \t ICD TYpe  \t Phenome \n";
        bw.write(headerline)
        println(headerline)

        for(int i = 0; i < phecoreres.size(); i++) {

            println(phecoreres[i].phecodeid)



        }


        bw.close()
        render file: phecodefile, fileName: filename,contentType: 'text/rtf'


    }

    def showPhecodeInfoTable()
    {
        println(params)
        def fil = params.fil.toString()
        def searchterm = params.q?.toString()
        println("search term ")
        println(searchterm)


        def pinfo = PhecodeData.createCriteria()
        def phecodedata




           // def pdesc = searchterm.substring(searchterm.indexOf(":")+1,searchterm.length())

            def phecodedesc = Phecode.findAllByPhecodeid(params.phecode)

            println(phecodedesc.phecodeid2.toString())

            // println(phecode)
            phecodedata = pinfo.list {
                eq ("phecodeid", phecodedesc.phecodeid2[0].toString())
                order("icddesc", "asc")
            }



//println(phecodedata.phecodeid)
        println("***************")
        //println(Phecode.findAllByPhecodeid2008))
        println("***************")


        def phecoreres = phecodedata.collect {
            en -> return[phecodeid : en.phecodeid,pdesc:Phecode.findAllByPhecodeid2(en.phecodeid).phecodedesc[0],icdcode:en.icdcode,prange:en.phecoderange,icddesc:en.icddesc,icdtype:en.icdtype,sex:en.sex,pcategory:en.pcategory,phenome:en.phenome]
        }
        //println(phecoreres)


        [phecoreres:phecoreres, fil: fil]



    }

    def ajaxFindCity = {
        println("From ajax find city and params are"+params)
        // log.debug "Find city:${params.term}"

        def filter = params.radio.toString()
        def foundCities
        def ans

        if (filter.equals("icd"))
                {
                     foundCities = PhecodeData.withCriteria {
                        ilike 'icdcode', params.term + '%'
                        order("icddesc", "asc")
                     }



                     //ans = foundCities.icddata
                    ans = foundCities.icddesc

                }
        else if(filter.equals("phecodename"))
        {
            println("phecodename loop")
            def pid = params.term
            foundCities = Phecode.withCriteria {
                ilike 'phecodedesc', params.term + '%'
            }
            //println(foundCities)
            ans = foundCities?.pdata

        }

        else{

            //select * from phecode where phecodeid like '%8';
             def pid = params.term.toDouble()
             foundCities = Phecode.withCriteria {
                 ilike 'phecodeid', params.term + '%'
             }
            //println(foundCities)
            ans = foundCities?.pdata


        }
        //println("FfoundCities"+ ans)
        render (ans as JSON)




    }



    def save(PhecodeData phecodeData) {
        if (phecodeData == null) {
            notFound()
            return
        }

        try {
            phecodeDataService.save(phecodeData)
        } catch (ValidationException e) {
            respond phecodeData.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'phecodeData.label', default: 'PhecodeData'), phecodeData.id])
                redirect phecodeData
            }
            '*' { respond phecodeData, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond phecodeDataService.get(id)
    }

    def update(PhecodeData phecodeData) {
        if (phecodeData == null) {
            notFound()
            return
        }

        try {
            phecodeDataService.save(phecodeData)
        } catch (ValidationException e) {
            respond phecodeData.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'phecodeData.label', default: 'PhecodeData'), phecodeData.id])
                redirect phecodeData
            }
            '*'{ respond phecodeData, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        phecodeDataService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'phecodeData.label', default: 'PhecodeData'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'phecodeData.label', default: 'PhecodeData'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
