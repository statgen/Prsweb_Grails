package prsweb

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PhecodedataServiceSpec extends Specification {

    PhecodedataService phecodedataService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Phecodedata(...).save(flush: true, failOnError: true)
        //new Phecodedata(...).save(flush: true, failOnError: true)
        //Phecodedata phecodedata = new Phecodedata(...).save(flush: true, failOnError: true)
        //new Phecodedata(...).save(flush: true, failOnError: true)
        //new Phecodedata(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //phecodedata.id
    }

    void "test get"() {
        setupData()

        expect:
        phecodedataService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Phecodedata> phecodedataList = phecodedataService.list(max: 2, offset: 2)

        then:
        phecodedataList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        phecodedataService.count() == 5
    }

    void "test delete"() {
        Long phecodedataId = setupData()

        expect:
        phecodedataService.count() == 5

        when:
        phecodedataService.delete(phecodedataId)
        sessionFactory.currentSession.flush()

        then:
        phecodedataService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Phecodedata phecodedata = new Phecodedata()
        phecodedataService.save(phecodedata)

        then:
        phecodedata.id != null
    }
}
