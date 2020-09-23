package com.eds.eds.repositories;

import com.eds.eds.models.Location;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource(collectionResourceRel = "locations", path = "locations")
public interface LocationRepository extends MongoRepository<Location,String> {
   Location findByName(@Param("name") String name);

   List<Location> findAllByMainLocationId(@Param("mainLocationId") String mainLocationId);
}
