package prsweb

import grails.gorm.services.Service

@Service(PhecodeData)
interface PhecodeDataService {

    PhecodeData get(Serializable id)

    List<PhecodeData> list(Map args)

    Long count()

    void delete(Serializable id)

    PhecodeData save(PhecodeData phecodeData)

}