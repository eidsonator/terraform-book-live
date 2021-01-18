output "dns_name" {
    value = "${module.webserver-cluster.alb_dns_name}"
}