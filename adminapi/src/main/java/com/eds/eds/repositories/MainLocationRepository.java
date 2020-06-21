package com.eds.eds.repositories;

import com.eds.eds.models.MainLocation;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "mainlocations", path = "mainlocations")
public interface MainLocationRepository extends MongoRepository<MainLocation,String> {
   MainLocation findByName(@Param("name") String name);
}
