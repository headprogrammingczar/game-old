module Game.UI.StartWindow where

import Game.Imports
import Game.UI.Base
import Game.UI.MainWindow
import Game.Data.Save
import Game.UI.Save
import Game.UI.Actions.New
import Game.UI.Actions.Quit

runStartWindow :: GameRef -> IO ()
runStartWindow gp = do
  window <- windowNew
  startWindowLayout window gp
  widgetShowAll window

startWindowLayout :: Window -> GameRef -> IO ()
startWindowLayout window gp = do
  dieid <- onDestroy window mainQuit
  newButton <- buttonNewWithLabel "New Game"
  loadButton <- buttonNewWithLabel "Load Game"
  quitButton <- buttonNewWithLabel "Quit"
  box <- vButtonBoxNew
  afterClicked newButton $ do
    safeDestroy window dieid
    newGame gp
    runMainWindow gp
  afterClicked loadButton $ do
    loaded <- loadAction gp
    case loaded of
      False -> putStrLn "this error message needs improvement"
      True -> do
        safeDestroy window dieid
        runMainWindow gp
  afterClicked quitButton $ do
    widgetDestroy window
    quitGame
  containerAdd box newButton
  containerAdd box loadButton
  containerAdd box quitButton
  containerAdd window box
  return ()

