resource "aws_instance" "main" {

  instance_type = var.aws_instance_type

  # Use the correct AMI based on the region
  ami = var.aws_ami

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = var.sg_instance_group_ids

  associate_public_ip_address = "true"

  key_name = var.aws_key_pair

  root_block_device {
    encrypted = true
  }

  availability_zone = var.availability_zone

  user_data         = <<EOT
#!/bin/bash -xe
sleep 10
DEVICE=/dev/$(lsblk -d --noheadings -o NAME | tail -1)
FS_TYPE=$(file -s $DEVICE | awk '{print $2}')
MOUNT_POINT=/mnt/home

# If no FS, then this output contains "data"
if [ "$FS_TYPE" = "data" ]
then
    echo "Creating file system on $DEVICE"
    mkfs -t ext4 $DEVICE
fi

mkdir $MOUNT_POINT
mount $DEVICE $MOUNT_POINT
cp -rfp /home/* $MOUNT_POINT/

UUID_VAR=$(blkid -s UUID -o value $DEVICE)

echo "UUID=$UUID_VAR /home ext4 defaults,nofail  0 2" >> /etc/fstab
reboot
EOT

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_ebs_volume" "data" {
  availability_zone = var.availability_zone
  size              = 100
  #encrypted = true
  type = "gp3"
  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_volume_attachment" "ebs_data" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.main.id
}