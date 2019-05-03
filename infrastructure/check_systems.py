#!/usr/bin/env python3
from pathlib import Path
import digitalocean

# Get the key
with open(str(Path.home())+"/.digitalocean/api.key",'r') as r:
    token = r.read()[:-1]

manager = digitalocean.Manager(token=token)
my_droplets = manager.get_all_droplets(tag_name="bug-bounty")

# loop through and display
for droplet in my_droplets:
    print(
        "Name:",
        droplet.name,
        "IP:",
        droplet.ip_address,
        "Status:",
        droplet.status
)
