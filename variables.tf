variable "location" {
  description = "Ubicación de la VM"
  default     = "East US"
}

variable "vm_size" {
  description = "Tamaño de la VM"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Nombre de usuario de la VM"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Contraseña de la VM (No recomendado en producción)"
  default     = "Tupassword.123456"
}

variable "suscripcion" {
  description = "suscripcion id"
  default     = "a3996526-94a8-46ec-a6e3-8b462b18596b"
}