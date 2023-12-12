output "instance_details" {
  value = {
    for inst in aws_instance.example:
      inst.tags.Name => {
        "public_ip" = inst.public_ip
      }
  }
}