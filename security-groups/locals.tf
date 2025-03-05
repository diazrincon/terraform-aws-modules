locals {
  prefix_list_ids = ["pl-0a1c0510a1c64e3a0"]
  allowed_external_cidr_blocks = [
    "64.226.135.0/24",    # Perimeter 81
    "64.226.136.0/24",    # Perimeter 81        
    "104.198.166.162/32", # MABL 1
    "35.184.236.163/32",  # MABL 2
    "34.132.2.128/28",    # MABL 3
    "34.31.138.224/27"    # MABL 4
  ]
}
