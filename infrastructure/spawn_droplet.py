#!/usr/bin/env python3
from pathlib import Path
import digitalocean

# Get the key
with open(str(Path.home())+"/.digitalocean/api.key",'r') as r:
    token = r.read()[:-1]

# Set SSH keys
manager = digitalocean.Manager(token=token)
keys = manager.get_all_sshkeys()

# Create the droplet
droplet_name = input('What would you like to name the droplet?> ')
droplet = digitalocean.Droplet(
    token=token,
    name=droplet_name,
    region='sfo2',
    image='ubuntu-18-04-x64',
    size_slug='1gb',
    ssh_keys=keys
)
droplet.create()

# Tag the droplet
tag = digitalocean.Tag(token=token, name="bug-bounty")
tag.create()
tag.add_droplets([droplet.id])
print("Droplet " + droplet_name + " created!")
