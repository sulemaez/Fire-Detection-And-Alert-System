package com.eds.eds.repositories;

import com.eds.eds.models.Emergency;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource(collectionResourceRel = "emergencies", path = "emergencies")
public interface EmergencyRepository extends MongoRepository<Emergency,String> {

    List<Emergency> findAllByTypeId(@Param("typeId") String typeId);
    List<Emergency> findAllByLocationId(@Param("typeId") String locationId);
}
