package prsweb

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PhenotypecatServiceSpec extends Specification {

    PhenotypecatService phenotypecatService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Phenotypecat(...).save(flush: true, failOnError: true)
        //new Phenotypecat(...).save(flush: true, failOnError: true)
        //Phenotypecat phenotypecat = new Phenotypecat(...).save(flush: true, failOnError: true)
        //new Phenotypecat(...).save(flush: true, failOnError: true)
        //new Phenotypecat(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //phenotypecat.id
    }

    void "test get"() {
        setupData()

        expect:
        phenotypecatService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Phenotypecat> phenotypecatList = phenotypecatService.list(max: 2, offset: 2)

        then:
        phenotypecatList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        phenotypecatService.count() == 5
    }

    void "test delete"() {
        Long phenotypecatId = setupData()

        expect:
        phenotypecatService.count() == 5

        when:
        phenotypecatService.delete(phenotypecatId)
        sessionFactory.currentSession.flush()

        then:
        phenotypecatService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Phenotypecat phenotypecat = new Phenotypecat()
        phenotypecatService.save(phenotypecat)

        then:
        phenotypecat.id != null
    }
}
