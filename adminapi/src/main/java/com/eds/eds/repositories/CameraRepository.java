package com.eds.eds.repositories;

import com.eds.eds.models.Camera;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import java.util.List;

@RepositoryRestResource(collectionResourceRel = "cameras", path = "cameras")
public interface CameraRepository extends MongoRepository<Camera,String> {

  Camera findByName(@Param("typeId") String name);

  List<Camera> findAllByLocationId(@Param("locationId") String locationId);


}
