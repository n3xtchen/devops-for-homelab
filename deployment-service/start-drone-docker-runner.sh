
docker rm runner
docker run  \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --add-host=drone-server:10.0.248.14 \
  --env=DRONE_RPC_PROTO=http \
  --env=DRONE_RPC_HOST=drone-server \
  --env=DRONE_RPC_SECRET=d295982b36f2cfbc1fd657e476d2e846 \
  --env=DRONE_RUNNER_CAPACITY=1 \
  --env=DRONE_RUNNER_NAME=my-second-runneri-1 \
  --env=DRONE_HTTP_BIND=:3002 \
  --env=DRONE_DEBUG=true \
  --env=DRONE_TRACE=true \
  --env=DRONE_RPC_DUMP_HTTP=true \
  --env=DRONE_RPC_DUMP_HTTP_BODY=true \
  --publish=3002:3002 \
  --restart=always \
  --name=runner \
  drone/drone-runner-docker:1-linux-arm64
