# Injector

This sub-project explores dropping view controllers in favor of trees describing view hierarchies.

## `HostViewController`

A `HostViewController` is host to a `Node` tree. When the tree is set on the host, a view hierarchy is
created and replaces the host's view hierarchy.

This experiment does not address layout or interaction.

iOS's existing view controllers will not be immediately adaptable to this strategy. If view controllers
were treated as nodes using a navigation controller or a tab bar controller would be no different than 
using a label.

## Elemental

In Elemental, view controllers are brought into the tree along with views; both are represented as 
cases of nodes (which for the case of this experiment are called `Dots`).

A `UITabBarController` is represented as a `Tab` node. A `UINavigationController` is a `Navigator` node.
Each of these representes a node into which other nodes can be embedded.

This experiment only exposes the layout and interaction intrinsic to the nodes themselves and how
they relate to subnodes.

Using an enum representation to switch between views and controllers seems to be a bad choice.
A node needs to be able to be one or the other. But it matters which one it is. A label cannot be 
trivially added to a tab bar controller. A shim is necessary.

Possible solutions: if a controller is expected, but a view is found, generate and inject a shim.
if a view is expected, but a controller is found, inject the controller's view and call the correct 
view controller containment API methods.

