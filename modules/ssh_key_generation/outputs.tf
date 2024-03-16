output "public_ssh_key" {
  value = "${tls_private_key.azure_ssh_key.public_key_openssh}"
  sensitive = true
}

output "private_ssh_key" {
  value = "${tls_private_key.azure_ssh_key.private_key_pem}"
  sensitive = true
}

