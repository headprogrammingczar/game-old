module Game.UI.Save where

import Game.Imports
import Game.UI.Base
import Game.Data.Save
import System.Posix.Files
import System.FilePath hiding (FilePath)

-- show a window to load game; return True if game was loaded
loadAction :: GameRef -> IO Bool
loadAction gp = do
  dialog <- fileChooserDialogNew Nothing Nothing FileChooserActionOpen [("Open", ResponseAccept), ("Cancel", ResponseReject)]
  fileChooserSetLocalOnly dialog True
  response <- dialogRun dialog
  case response of
    ResponseAccept -> do
      uri' <- fileChooserGetFilename dialog
      widgetDestroy dialog
      case uri' of
        Just uri -> readState gp uri
        _ -> return False
    _ -> do
      widgetDestroy dialog
      return False

-- save game over where it was loaded from
saveOverAction :: GameRef -> IO ()
saveOverAction gp = do
  path <- saveGamePath <$> readIORef gp
  writeState gp path
  return ()

-- show window to save game
saveAction :: GameRef -> IO ()
saveAction gp = do
  dialog <- fileChooserDialogNew Nothing Nothing FileChooserActionSave [("Save", ResponseAccept), ("Cancel", ResponseReject)]
  fileChooserSetDoOverwriteConfirmation dialog True
  fileChooserSetLocalOnly dialog True
  path <- takeDirectory . saveGamePath <$> readIORef gp
  when (path /= "") $ do
    fileChooserSetCurrentFolder dialog path
    return ()
  response <- dialogRun dialog
  uri' <- fileChooserGetFilename dialog
  widgetDestroy dialog
  case uri' of
    Just uri -> writeState gp uri
    Nothing -> putStrLn "this error message needs to be improved"
  return ()

