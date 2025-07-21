module "ssl_cert" {
  source         = "./modules/ssl_cert_dns_record"
  domain_name    = "dev.ladymarg.com"
  hosted_zone_id = "Z088902633J7AUZXQ0B9F"             #aws route53 list-hosted-zones-by-name --dns-name example.com --query "HostedZones[0].Id" --output text
  elb_name       = "a96edfc7bbe974b6eb1389c8a2a2bec0" #update after running rhe module/ssl_cert_dns_record -- aws elb describe-load-balancers --query "LoadBalancerDescriptions[*].LoadBalancerName"
  tags = {
    Environment = "tsp-cluster-${terraform.workspace}"
    Owner       = "ladymarg"
  }
}