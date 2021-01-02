docker build -t siroshtan154/multi-client:latest -t siroshtan154/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t siroshtan154/multi-server:latest -t siroshtan154/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t siroshtan154/multi-worker:latest -t siroshtan154/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push siroshtan154/multi-client:latest
docker push siroshtan154/multi-server:latest
docker push siroshtan154/multi-worker:latest

docker push siroshtan154/multi-client:$SHA
docker push siroshtan154/multi-server:$SHA
docker push siroshtan154/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=siroshtan154/multi-client:$SHA
kubectl set image deployments/server-deployment server=siroshtan154/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=siroshtan154/multi-worker:$SHA
