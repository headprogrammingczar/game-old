module Game.Types where

import Data.IORef

type GameRef = IORef Game

{-

saveGamePath = path to file loaded from, or ""
isLiveGame = True if game is ready to play; if False, game quits

-}
data Game = Game {
  saveGamePath :: String
} deriving (Show, Read)

newEmptyGame :: IO GameRef
newEmptyGame = do
  newIORef Game {saveGamePath = ""}

