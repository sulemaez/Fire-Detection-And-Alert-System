package com.eds.eds.repositories;

import com.eds.eds.models.County;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "counties", path = "counties")
public interface CountyRepository extends MongoRepository<County,String> {
   County findByName(@Param("name") String name);
}
