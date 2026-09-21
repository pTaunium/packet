FROM scratch
ARG FILENAME=file
COPY download /file/${FILENAME}
CMD ["/dev/null"]
