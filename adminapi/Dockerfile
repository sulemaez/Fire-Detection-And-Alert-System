# Stage 1, build container
FROM openjdk:11 as build

# Get gradle distribution 
COPY *.gradle gradle.* gradlew /src/
COPY gradle /src/gradle
WORKDIR /src
RUN ./gradlew --version

COPY . .
RUN ./gradlew build

# Stage 2, distribution container

FROM openjdk:11 as production
WORKDIR /app
COPY --from=build /src/build/libs/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","app.jar"]

