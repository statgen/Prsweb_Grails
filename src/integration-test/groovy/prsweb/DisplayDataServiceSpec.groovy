package prsweb

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class DisplayDataServiceSpec extends Specification {

    DisplayDataService displayDataService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new DisplayData(...).save(flush: true, failOnError: true)
        //new DisplayData(...).save(flush: true, failOnError: true)
        //DisplayData displayData = new DisplayData(...).save(flush: true, failOnError: true)
        //new DisplayData(...).save(flush: true, failOnError: true)
        //new DisplayData(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //displayData.id
    }

    void "test get"() {
        setupData()

        expect:
        displayDataService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<DisplayData> displayDataList = displayDataService.list(max: 2, offset: 2)

        then:
        displayDataList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        displayDataService.count() == 5
    }

    void "test delete"() {
        Long displayDataId = setupData()

        expect:
        displayDataService.count() == 5

        when:
        displayDataService.delete(displayDataId)
        sessionFactory.currentSession.flush()

        then:
        displayDataService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        DisplayData displayData = new DisplayData()
        displayDataService.save(displayData)

        then:
        displayData.id != null
    }
}
