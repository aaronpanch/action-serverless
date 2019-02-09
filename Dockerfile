FROM node:10-slim

LABEL version="1.0.0"
LABEL repository="https://github.com/aaronpanch/action-serverless"
LABEL homepage="https://github.com/aaronpanch/action-serverless"
LABEL maintainer="Aaron Panchal <aaron.panchal@gmail.com>"

LABEL "com.github.actions.name"="GitHub Action for Serverless Framework"
LABEL "com.github.actions.description"="Wraps the Serverless CLI"
LABEL "com.github.actions.icon"="zap"
LABEL "com.github.actions.color"="gray-dark"

# Install serverless globally
RUN yarn global add serverless

ADD "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["."]
