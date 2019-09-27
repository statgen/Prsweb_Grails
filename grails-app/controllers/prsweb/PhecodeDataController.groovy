package prsweb

import grails.validation.ValidationException
//import static org.eclipse.jetty.http.HttpStatus.*
import grails.converters.JSON

class PhecodeDataController {

    PhecodeDataService phecodeDataService

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
                eq ("icddesc", searchterm)
                order("icddesc", "asc")
            }

        }
        else
        {

                def pdesc = searchterm.substring(searchterm.indexOf(":")+1,searchterm.length())

            def phecodedesc = Phecode.findAllByPhecodedesc(pdesc)

            println(phecodedesc.phecodeid2.toString())

           // println(phecode)
            phecodedata = pinfo.list {
                eq ("phecodeid", phecodedesc.phecodeid2[0].toString())
                order("icddesc", "asc")
            }


        }
println(phecodedata.phecodeid)
            println("***************")
        //println(Phecode.findAllByPhecodeid2008))
        println("***************")


        def phecoreres = phecodedata.collect {
            en -> return[phecodeid : en.phecodeid,pdesc:Phecode.findAllByPhecodeid2(en.phecodeid).phecodedesc[0],icdcode:en.icdcode,prange:en.phecoderange,icddesc:en.icddesc,icdtype:en.icdtype,sex:en.sex,pcategory:en.pcategory,phenome:en.phenome]
        }
        println(phecoreres)


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
