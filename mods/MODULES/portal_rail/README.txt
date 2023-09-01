Minetest mod : portal_rail
===================
See license.txt for license information.

Authors of source code
----------------------
BigBear (LGPLv2.1+)

Authors of media (textures, sounds)
----------------------------------------------------------
BigBear (CC BY-SA 3.0)

Description
-----------
Provides a rail type that will teleport cart and contents in one direction
(up, down, north, south, east or west) depending on the direction of travel.
The target location must have a rail at that position.  The 'direction'
depends on the location of the rail *after* the teleport rail if it is above,
then direction is up, if it is below then it is down. If it is on the flat
then it will be north, south east or west.  The distance teleported is fixed to
specific value (500 blocks by default, configurable in settings)

This is to make minecarts more useful for player transport by integrating
local minecart transport systems with long distance travel. It also avoids the
need for over-powered 'teleport' networks, and pop up menus.

