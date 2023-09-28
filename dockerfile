FROM python:latest

#Set working directory
WORKDIR /code

#Copy requirements
COPY requirements.txt .

#install requirements
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY src/ .

#expose port 80 for use by NGINX
EXPOSE 8080

#vars for Redis
ARG REDIS_SERVER_ADDRESS
ENV redis_server_address=${REDIS_SERVER_ADDRESS}

ARG REDIS_SERVER_PORT
ENV redis_server_port=${REDIS_SERVER_PORT}

#vars for LogLevel
ARG JWTSECRET="2c6b9130-1dbb-425b-8efb-bea7848b4d95"
ENV jwtSecret=${JWTSECRET}}

# command to run on container start
CMD ["uvicorn", "main:app", "--reload", "--port", "8080", "--host", "0.0.0.0"]
