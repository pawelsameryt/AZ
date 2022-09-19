variable "location" {
    type = string
    default = "westus2"
}

variable "prefix" {
    type = string
    default = "ps"
}

variable "ssh-source-address" {
    type = string
    default = "*"
}
