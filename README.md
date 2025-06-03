# GitOps

In the past we have used UIs for modifying what our application does, what resources are required, how they are configured. These UIs are excellent for discoverability, exploring, prodding and poking at them to gain insight into how something works, they have generally been terrible for auditing (who, did what, when) and replication.

To that end we have circled back to code as the descriptor of what should be, along with using Version Control Systems for keeping track of how things changes as well as allowing us to discuss these changes before they are applied. This is what we call GitOps.

In essence GitOps is the standardization around how things are described, how we version control these description and the tooling for taking that description and applying it to the world (Terraform, Kubernetes, Nix).

## Goal

Setup a Terraform module that takes a Git repository reference and applies it to itself (updates itself).
