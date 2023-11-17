# need to use go as the build image
FROM golang:alpine as build

# install git to clone repo
RUN apk add --update git

# checkout tag
ENV GOPATH=/opt/geoipupdate
ARG VERSION

# build binary for alpine
RUN MAJOR=$(echo $VERSION | awk '{print substr($0,1,2)}') && \
    go install github.com/maxmind/geoipupdate/$MAJOR/cmd/geoipupdate@$VERSION

# final image
FROM alpine:latest

# install certs needed for raw binary
RUN apk add --update ca-certificates && \
    rm -rf /var/cache/apk/*

# copy the binary over from the build image, directly into bin dir
COPY --from=build /opt/geoipupdate/bin/geoipupdate /usr/bin/

# configure startup
ADD src/exec.sh /
CMD [ "/exec.sh" ]
