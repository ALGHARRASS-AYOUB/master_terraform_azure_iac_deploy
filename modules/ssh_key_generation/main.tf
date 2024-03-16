# creation de la clé ssh pour la vm

resource "tls_private_key" "azure_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}