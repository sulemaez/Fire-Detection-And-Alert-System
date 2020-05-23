package com.eds.eds.repositories;


import com.eds.eds.models.UserType;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "usertypes", path = "usertypes")
public interface UserTypeRepository extends MongoRepository<UserType,String> {

    UserType findByName(@Param("name")String name);

}