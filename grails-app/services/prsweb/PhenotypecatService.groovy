package prsweb

import grails.gorm.services.Service

@Service(Phenotypecat)
interface PhenotypecatService {

    Phenotypecat get(Serializable id)

    List<Phenotypecat> list(Map args)

    Long count()

    void delete(Serializable id)

    Phenotypecat save(Phenotypecat phenotypecat)

}