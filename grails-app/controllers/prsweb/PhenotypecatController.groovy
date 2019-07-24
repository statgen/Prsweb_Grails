package prsweb

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class PhenotypecatController {

    PhenotypecatService phenotypecatService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond phenotypecatService.list(params), model:[phenotypecatCount: phenotypecatService.count()]
    }

    def show(Long id) {
        respond phenotypecatService.get(id)
    }

    def create() {
        respond new Phenotypecat(params)
    }

    def save(Phenotypecat phenotypecat) {
        if (phenotypecat == null) {
            notFound()
            return
        }

        try {
            phenotypecatService.save(phenotypecat)
        } catch (ValidationException e) {
            respond phenotypecat.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'phenotypecat.label', default: 'Phenotypecat'), phenotypecat.id])
                redirect phenotypecat
            }
            '*' { respond phenotypecat, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond phenotypecatService.get(id)
    }

    def update(Phenotypecat phenotypecat) {
        if (phenotypecat == null) {
            notFound()
            return
        }

        try {
            phenotypecatService.save(phenotypecat)
        } catch (ValidationException e) {
            respond phenotypecat.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'phenotypecat.label', default: 'Phenotypecat'), phenotypecat.id])
                redirect phenotypecat
            }
            '*'{ respond phenotypecat, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        phenotypecatService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'phenotypecat.label', default: 'Phenotypecat'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'phenotypecat.label', default: 'Phenotypecat'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
