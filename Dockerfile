# Use the official OpenJDK 11 image as base
FROM openjdk:11

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/CampusPathFinderBellmanFord-with-dependencies.jar /app/

# Command to run the application when the container starts
CMD ["java", "-jar", "CampusPathFinderBellmanFord-with-dependencies.jar"]
