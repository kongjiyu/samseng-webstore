# ===== Build stage =====
FROM eclipse-temurin:17-jdk-jammy AS build-env
SHELL ["/bin/bash", "--login", "-i", "-c"]

# Install node + NVM (optional, if you also need Node/Tailwind)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN . $HOME/.nvm/nvm.sh
RUN nvm install 22

WORKDIR /usr/app

# Copy in everything needed for Maven
COPY ./.mvn ./.mvn
COPY ./mvnw ./mvnw
COPY ./pom.xml ./pom.xml

# (Optional) install your node modules if needed
COPY package.json .
RUN npm install

# Copy the rest of your source
COPY . .

# Tailwind build if needed
RUN npx tailwindcss -i ./src/main/webapp/static/css/tailwind.css -o ./src/main/webapp/static/css/output.css

# Build the WAR
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package

# ===== Final stage (GlassFish) =====
FROM ghcr.io/eclipse-ee4j/glassfish
# Optionally copy the WAR here if you want the WAR baked into the image:
COPY --from=build-env /usr/app/target/*.war /opt/glassfish7/
#CMD ["/opt/glassfish7/bin/asadmin", "start-domain", "--verbose"]
#
# (But we'll skip it if we’re extracting the WAR onto our host, then volume-mounting to GlassFish.)