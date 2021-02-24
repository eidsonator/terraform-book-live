output "dns_name" {
    value = "${module.webserver_cluster.alb_dns_name}"
}