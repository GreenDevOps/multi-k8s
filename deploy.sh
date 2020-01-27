docker build -t greendevops/multi-client:latest -t greendevops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t greendevops/multi-server:latest -t greendevops/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t greendevops/multi-worker:latest -t greendevops/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push greendevops/multi-client:latest
docker push greendevops/multi-server:latest
docker push greendevops/multi-worker:latest

docker push greendevops/multi-client:$SHA
docker push greendevops/multi-server:$SHA
docker push greendevops/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=greendevops/multi-server:$SHA
kubectl set image deployments/client-deployment client=greendevops/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=greendevops/multi-worker:$SHA