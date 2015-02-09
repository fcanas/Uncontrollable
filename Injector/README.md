# Injector

This sub-project explores dropping view controllers in favor of trees describing view hierarchies.

## `HostViewController`

A `HostViewController` is host to a `Node` tree. When the tree is set on the host, a view hierarchy is
created and replaces the host's view hierarchy.

This experiment does not address layout or interaction.