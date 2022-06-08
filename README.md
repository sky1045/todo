# todo
[example](https://todo.roboto.info)

## create EKS cluster via terraform
```
$ cd eks/terraform
$ terraform init   # need to update s3 backend bucket
$ terraform plan   # need to update vpc, subnet IDs
$ terraform apply
```

## bootstrap & install helm chart
### prerequisite
 - route53 domain
 - hosted zone & domain record for domain
 - ACM certificate for hosted zone
 - update ingress host and certificate arn
```
$ cd eks/helm
$ aws eks update-kubeconfig --name <cluster name>
$ ./bootstrap.sh
```
 - associate the loadbalancer from nginx service with route53 record

## loadtest
```
$ cd eks/locust
$ ./setup.sh
$ kubectl --namespace default port-forward service/awsblog-locust 8089:8089
```

https://user-images.githubusercontent.com/35055316/172654851-0e30939f-6787-48d8-b008-4f7bd71baa01.mp4

