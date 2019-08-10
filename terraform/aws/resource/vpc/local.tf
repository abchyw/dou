locals {
    availablility_zones = [
      "ap-northeast-1a",
      "ap-northeast-1c"
    ]

    subnet_count = length(local.availablility_zones)
}