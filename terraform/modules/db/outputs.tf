output "db_external_ip1" {
  value = "${google_compute_instance.db.*.network_interface.0.access_config.0.nat_ip}"
}

#output "balancer_external_ip" {
#  value = "${google_compute_forwarding_rule.reddit-ft.ip_address}"
#}
