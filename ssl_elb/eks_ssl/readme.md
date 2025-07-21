
# Terraform init Module/ssl_dns_record first 

# Get Route 53 Hosted Zone ID 
```aws route53 list-hosted-zones-by-name --dns-name example.com --query "HostedZones[0].Id" --output text```


# Get Classic ELB name ##

```aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName"```

# in the root main.tf update the hosted zone and  elb-name

# deploy frontend_k8s.yml comment out the annotation or ssl-cert and run to create your domain 
# Update the certificate on frontend_k8s.yml for each environment and redeploy 

 ``` annotations:```
    ```service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:ca-central-1:050752609092:certificate/ef108c4b-26ea-4449-9ef9-a8e863ed5bd2 # Replace with your ACM certificate ARN```
