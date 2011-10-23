module Game.UI.MainWindow.Layout where

import Game.Imports
import Game.UI.Base
import Game.UI.MainMenu

mainWindowLayout :: Window -> GameRef -> IO ()
mainWindowLayout window gp = do
  menu <- mainMenuToolbar gp
  box <- vBoxNew False 0
  button <- buttonNewWithLabel "End Turn"
  afterClicked button $ do
    endOfTurn gp
  boxPackEnd box button PackNatural 10
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

endOfTurn gp = do
  g <- readIORef gp
  let g' = g {turnCount = turnCount g + 1}
  writeIORef gp g'

