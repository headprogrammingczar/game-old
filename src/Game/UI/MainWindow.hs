module Game.UI.MainWindow where

import Game.Imports
import Game.UI.MainWindow.Layout

runMainWindow :: GameRef -> IO ()
runMainWindow gp = do
  window <- windowNew
  mainWindowLayout window gp
  widgetShowAll window

