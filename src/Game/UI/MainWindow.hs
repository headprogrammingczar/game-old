module Game.UI.MainWindow where

import Game.Imports
import Game.UI.MainMenu

runMainWindow :: GameRef -> IO ()
runMainWindow gp = do
  window <- windowNew
  mainWindowLayout window gp
  widgetShowAll window

mainWindowLayout :: Window -> GameRef -> IO ()
mainWindowLayout window gp = do
  menu <- mainMenuToolbar gp
  box <- vBoxNew False 0
  boxPackStart box menu PackNatural 0
  set window [containerChild := box]
  onDestroy window mainQuit
  return ()

mainMenuToolbar :: GameRef -> IO MenuBar
mainMenuToolbar gp = do
  menubar <- menuBarNew
  file <- fileMenu gp
  menuShellAppend menubar file
  return menubar

