module Game.Data.Save where

import Game.Imports
import System.Posix.Files
import System.FilePath hiding (FilePath)

-- write gp to file
writeState :: GameRef -> String -> IO ()
writeState gp file = do
  game' <- readIORef gp
  -- strip out pointlessness
  let game = game' {saveGamePath = ""}
  h <- openFile file WriteMode
  hPutStr h (show game)
  hClose h
  return ()

-- read gp from file
readState :: GameRef -> String -> IO Bool
readState gp file = do
  -- read game from file
  exists <- isRegularFile <$> getFileStatus file
  case exists of
    False -> return False
    True -> do
      game' <- reads <$> readFile file
      case game' of
        [(game', _)] -> do
          -- set the path we read from, so we remember where to save it to
          let game = game' {saveGamePath = file}
          writeIORef gp game
          return True

