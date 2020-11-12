docker build -t chkbarlow/multi-client:latest -t chkbarlow/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chkbarlow/multi-server:latest -t chkbarlow/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chkbarlow/multi-worker:latest -t chkbarlow/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chkbarlow/multi-client:latest
docker push chkbarlow/multi-server:latest
docker push chkbarlow/multi-worker:latest

docker push chkbarlow/multi-client:$SHA
docker push chkbarlow/multi-server:$SHA
docker push chkbarlow/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chkbarlow/multi-server:$SHA
kubectl set image deployments/client-deployment client=chkbarlow/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chkbarlow/multi-worker:$SHA