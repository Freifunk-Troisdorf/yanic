FROM scratch
COPY yanic /yanic
ENTRYPOINT ["/yanic"]
