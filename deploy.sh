docker build -t fallingsappy/multi-client:latest -t fallingsappy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fallingsappy/multi-server:latest -t fallingsappy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fallingsappy/multi-worker:latest -t fallingsappy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push fallingsappy/multi-client:latest
docker push fallingsappy/multi-server:latest
docker push fallingsappy/multi-worker:latest

docker push fallingsappy/multi-client:$SHA
docker push fallingsappy/multi-server:$SHA
docker push fallingsappy/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=fallingsappy/multi-server:$SHA
kubectl set image deployments/client-deployment client=fallingsappy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fallingsappy/multi-worker:$SHA