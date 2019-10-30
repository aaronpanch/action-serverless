FROM node:12-slim

ARG framework_version=latest

# Install serverless globally
RUN yarn global add serverless@$frameworkVersion

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
