package prsweb

import grails.gorm.services.Service

@Service(DisplayData)
interface DisplayDataService {

    DisplayData get(Serializable id)

    List<DisplayData> list(Map args)

    Long count()

    void delete(Serializable id)

    DisplayData save(DisplayData displayData)

}