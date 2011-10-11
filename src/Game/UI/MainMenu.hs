module Game.UI.MainMenu where

import Data.Function
import Control.Monad
import Game.Imports
import Game.UI.Base
import Game.Data.Save

fileMenu :: GameRef -> IO MenuItem
fileMenu gp = do
  file <- menuItemNewWithLabel "File"
  filemenu <- makeMenu [("Frobnify", frobnify), ("Save", saveAction gp), ("Quit", mainQuit)]
  menuItemSetSubmenu file filemenu
  return file

makeMenu :: [(String, IO ())] -> IO Menu
makeMenu pairs = do
  menu <- menuNew
  forM_ pairs $ \row -> do
    let (name, act) = row
    item <- menuItemNewWithLabel name
    afterActivateLeaf item act
    menuShellAppend menu item
  return menu

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

frobnify = do
  idleDo (frobnify' 0)
  return ()

frobnify' n = do
  print n
  idleDo (frobnify' (n + 1))

