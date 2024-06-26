packer {
  required_plugins {
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
  }
}

source "virtualbox-iso" "latch-up-workshop-vm" {
  format = "ova"
  vm_name = "latch-up-workshop-vm"
  boot_command = [
    "<wait5>c<wait>",
    "set gfxpayload=keep<enter><wait>",
    "linux /casper/vmlinuz <wait>",
    "autoinstall quiet fsck.mode=skip <wait>",
    "net.ifnames=0 biosdevname=0 systemd.unified_cgroup_hierarchy=0 <wait>",
    "ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" <wait>",
    "---<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<wait><enter><enter>"
  ]
  boot_wait              = "1s"
  cpus                   = 4
  disk_size              = 32768
  guest_os_type          = "Ubuntu_64"
  headless               = true
  http_directory         = "./http"
  iso_checksum           = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_url                = "https://old-releases.ubuntu.com/releases/22.04/ubuntu-22.04.3-live-server-amd64.iso"
  guest_additions_url    = "https://download.virtualbox.org/virtualbox/7.0.14/VBoxGuestAdditions_7.0.14.iso"
  guest_additions_sha256 = "0efbcb9bf4722cb19292ae00eba29587432e918d3b1f70905deb70f7cf78e8ce"
  memory                 = 8192
  gfx_controller         = "vmsvga"
  gfx_vram_size          = 128
  gfx_accelerate_3d      = true
  shutdown_command       = "sudo shutdown -h now"
  ssh_password           = "latchup"
  ssh_port               = 22
  ssh_read_write_timeout = "600s"
  ssh_timeout            = "120m"
  ssh_username           = "latchup"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--cpu-profile", "host"],
  ]
  vrdp_bind_address = "0.0.0.0"
  vrdp_port_max     = 6000
  vrdp_port_min     = 5900
}

build {
  sources = ["source.virtualbox-iso.latch-up-workshop-vm"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y ubuntu-desktop-minimal",
      "sudo apt-get remove -y --autoremove gnome-initial-setup"
    ]
  }

  provisioner "file" {
    source      = "vminfo.json"
    destination = "/home/latchup/vminfo.json"
  }
  
  provisioner "file" {
    source = "workshop.md"
    destination = "/home/latchup/workshop.md"
  }

  provisioner "shell" {
    env = {
    }
    scripts = [
      "workshop_setup.sh",
    ]
  }
}
