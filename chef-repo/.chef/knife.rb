local_mode true
cookbook_path    ["cookbooks", "site-cookbooks"]
knife[:automatic_attribute_whitelist] = [
  "fqdn/",
  "os/",
  "os_version/",
  "hostname",
  "ipaddress/"
]
