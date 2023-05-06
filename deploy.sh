docker build -t shrempf/multi-client:latest -t shrempf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shrempf/multi-server:latest -t shrempf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shrempf/multi-worker:latest -t shrempf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shrempf/multi-client:latest
docker push shrempf/multi-server:latest
docker push shrempf/multi-worker:latest

docker push shrempf/multi-client:$SHA
docker push shrempf/multi-server:$SHA
docker push shrempf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=shrempf/multi-client:$SHA
kubectl set image deployments/server-deployment server=shrempf/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=shrempf/multi-worker:$SHA
