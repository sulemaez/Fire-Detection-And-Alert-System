package com.eds.eds.repositories;


import com.eds.eds.models.EmergencyType;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "emergencytypes", path = "emergencytypes")
public interface EmergencyTypeRepository extends MongoRepository<EmergencyType,String> {

    EmergencyType findByName(@Param("name") String name);
}
