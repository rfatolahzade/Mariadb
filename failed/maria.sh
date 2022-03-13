
helm install mariadb  -n mariadb .

#k label node workertwo app=master


#helm install mariadb-galera  -n mariadb . \
#    --set rootUser.password=rfinland \
#    --set replication.password=rfinland \
#    --set db.user=rfinland \
#    --set db.password=rfinland \
#    --set db.name=mydb \
#    --set slave.replicas=3 \
#    --set metrics.enabled=true \
#    --set metrics.serviceMonitor.enabled=true


helm upgrade --install  mariadb-galera bitnami/mariadb-galera -n mariadb-galera \
--set rootUser.password=rfinland \
--set galera.mariabackup.password=rfin \
--set galera.bootstrap.forceBootstrap=true \
--set galera.bootstrap.bootstrapFromNode=3 \
--set galera.bootstrap.forceSafeToBootstrap=true \
--set podManagementPolicy=Parallel \
--set persistence.storageClass=local-storage \
--set metrics.serviceMonitor.enabled=true




# helm delete --purge  mariadb
k label node workertwo app=master
k label node workertwo  app.kubernetes.io/name=mariadb-galera



            - name: MARIADB_HOST
              value: "185.235.40.199"
			  
			  

** Please be patient while the chart is being deployed **
Tip:

  Watch the deployment status using the command:

    kubectl get sts -w --namespace mariadb-galera -l app.kubernetes.io/instance=mariadb-galera

MariaDB can be accessed via port "" on the following DNS name from within your cluster:

    mariadb-galera.mariadb-galera.svc.cluster.local

To obtain the password for the MariaDB admin user run the following command:

    echo "$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-root-password}" | base64 --decode)"

To connect to your database run the following command:

    kubectl run mariadb-galera-client --rm --tty -i --restart='Never' --namespace mariadb-galera --image docker.io/bitnami/mariadb-galera:10.6.7-debian-10-r17 --command \
      -- mysql -h mariadb-galera -P  -uroot -p$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-root-password}" | base64 --decode) my_database

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace mariadb-galera svc/mariadb-galera : &
    mysql -h 127.0.0.1 -P  -uroot -p$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-root-password}" | base64 --decode) my_database

To upgrade this helm chart:

    helm upgrade --namespace mariadb-galera mariadb-galera bitnami/mariadb-galera \
      --set rootUser.password=$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-root-password}" | base64 --decode) \
      --set db.name=my_database \
      --set galera.mariabackup.password=$(kubectl get secret --namespace mariadb-galera mariadb-galera -o jsonpath="{.data.mariadb-galera-mariabackup-password}" | base64 --decode)



# helm delete --purge  mariadb
