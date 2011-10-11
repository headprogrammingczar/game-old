module Game.UI.StartWindow where

import Game.Imports
import Game.UI.Base
import Game.UI.MainWindow
import Game.Data.Save

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
  afterClicked loadButton $ do
    loaded <- loadGame gp
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

newGame :: GameRef -> IO ()
newGame gp = do
  runMainWindow gp

loadGame :: GameRef -> IO Bool
loadGame gp = do
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

quitGame :: IO ()
quitGame = mainQuit

