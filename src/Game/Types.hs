module Game.Types where

import Data.IORef

type GameRef = IORef Game

data Game = Game {
  saveGamePath :: String,
  turnCount :: Int
} deriving (Show, Read)

newEmptyGame :: IO GameRef
newEmptyGame = do
  newIORef Game {saveGamePath = "", turnCount = 0}

