{
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create ns mariadb-galera
helm upgrade --install  mariadb-galera bitnami/mariadb-galera -n mariadb-galera \
--set rootUser.password=rfinland \
--set galera.mariabackup.password=rfin \
--set galera.bootstrap.forceBootstrap=true \
--set galera.bootstrap.bootstrapFromNode=3 \
--set galera.bootstrap.forceSafeToBootstrap=true \
--set podManagementPolicy=Parallel \
--set persistence.storageClass=local-storage \
--set metrics.serviceMonitor.enabled=true
}


kubectl create -f sc-local-storage.yaml -f pv-local-storage.yaml

sleep 60 
echo "YourPassword for user admin is":
{
echo "$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)"
}

