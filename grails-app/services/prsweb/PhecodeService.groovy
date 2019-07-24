package prsweb

import grails.gorm.services.Service

@Service(Phecode)
interface PhecodeService {

    Phecode get(Serializable id)

    List<Phecode> list(Map args)

    Long count()

    void delete(Serializable id)

    Phecode save(Phecode phecode)

}