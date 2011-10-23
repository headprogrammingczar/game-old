module Game.UI.Actions.New where

import Game.Imports
import Game.UI.Base

newGame :: GameRef -> IO ()
newGame gp = do
  -- right now, do nothing
  -- eventually, we will generate a random map and set up lots of other stuff, which might end up being expensive to compute
  return ()

