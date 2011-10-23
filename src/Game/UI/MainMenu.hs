module Game.UI.MainMenu where

import Game.Imports
import Game.UI.Base
import Game.UI.Save

fileMenu :: GameRef -> IO MenuItem
fileMenu gp = do
  file <- menuItemNewWithLabel "File"
  filemenu <- makeMenu [("Frobnify", frobnify 0), ("Save", saveAction gp), ("Quit", mainQuit)]
  menuItemSetSubmenu file filemenu
  return file

frobnify n = idleDo $ do
  print n
  frobnify (n + 1)

