FROM scratch
ARG FILENAME=file
COPY download /file/${FILENAME}
