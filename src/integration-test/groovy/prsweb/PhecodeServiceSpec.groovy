package prsweb

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class PhecodeServiceSpec extends Specification {

    PhecodeService phecodeService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new Phecode(...).save(flush: true, failOnError: true)
        //new Phecode(...).save(flush: true, failOnError: true)
        //Phecode phecode = new Phecode(...).save(flush: true, failOnError: true)
        //new Phecode(...).save(flush: true, failOnError: true)
        //new Phecode(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //phecode.id
    }

    void "test get"() {
        setupData()

        expect:
        phecodeService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<Phecode> phecodeList = phecodeService.list(max: 2, offset: 2)

        then:
        phecodeList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        phecodeService.count() == 5
    }

    void "test delete"() {
        Long phecodeId = setupData()

        expect:
        phecodeService.count() == 5

        when:
        phecodeService.delete(phecodeId)
        sessionFactory.currentSession.flush()

        then:
        phecodeService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        Phecode phecode = new Phecode()
        phecodeService.save(phecode)

        then:
        phecode.id != null
    }
}
