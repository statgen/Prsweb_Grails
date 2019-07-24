package prsweb

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class PhecodeController {

    PhecodeService phecodeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond phecodeService.list(params), model:[phecodeCount: phecodeService.count()]
    }

    def show(Long id) {
        respond phecodeService.get(id)
    }

    def create() {
        respond new Phecode(params)
    }

    def save(Phecode phecode) {
        if (phecode == null) {
            notFound()
            return
        }

        try {
            phecodeService.save(phecode)
        } catch (ValidationException e) {
            respond phecode.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'phecode.label', default: 'Phecode'), phecode.id])
                redirect phecode
            }
            '*' { respond phecode, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond phecodeService.get(id)
    }

    def update(Phecode phecode) {
        if (phecode == null) {
            notFound()
            return
        }

        try {
            phecodeService.save(phecode)
        } catch (ValidationException e) {
            respond phecode.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'phecode.label', default: 'Phecode'), phecode.id])
                redirect phecode
            }
            '*'{ respond phecode, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        phecodeService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'phecode.label', default: 'Phecode'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'phecode.label', default: 'Phecode'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
