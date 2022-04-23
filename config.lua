-- The original config was written by BTNGaming --
-- modified for this version

Config                            = {}

-- DrawDistance - Change this to adjust distance the marker can be seen (in GTA units which is something like meters)
Config.DrawDistance     = 10

-- MarkerType - marker number - Examples: https://docs.fivem.net/docs/game-references/markers/
Config.MarkerType       = 27

-- MarkerBounce - 1 = bouncing animation    0 = still.
Config.MarkerBounce     = 0

--MarkerRotate - 1 = yes, marker will slowly rotate    0 = no, marker will not rotate
Config.MarkerRotate		= 1

--MarkerFaceCamera - 1 = yes, will always face camera   0 = no, is locked to player's direction
Config.MarkerFaceCamera = 0

-- MarkerHeight - Change this to choose how high or low you want the marker to show up for the speaking person(s).
Config.MarkerHeight     = -.95

-- MarkerSize - Adjust these to choose the height/width/depth of your marker.
Config.MarkerSize       = { x = .95, y = .95, z = .95 }

-- MarkerColor - Adjust these numbers based on any RGB color scale to choose your marker and text color.
Config.MarkerColor      = { r = 50, g = 255, b = 50 }

-- ShowText - 1 = show who is talking text    0 = do not show text
Config.ShowText = 1

-- Text Placement on screen   0 = top center   1 = left
Config.TextPlacement 	= 0

-- Show player ID over head
Config.ShowId			= 1

-- Distance the ID overhead can be seen - usually a short distance as it is just for admin purposes mostly
Config.DrawIdDistance	= 3