module Game.UI.Base where

-- annoying gtk bullshit goes here

import Game.Imports

-- disconnect destroy signal, then destroy
safeDestroy :: (WidgetClass self) => self -> ConnectId self -> IO ()
safeDestroy w destroyid = do
  signalDisconnect destroyid
  widgetDestroy w

-- perform action once - useful for backgrounding long actions without introducing indent creep
idleDo :: IO a -> IO ()
idleDo act = do
  idleAdd (act >> return False) priorityDefaultIdle
  return ()

makeMenu :: [(String, IO ())] -> IO Menu
makeMenu pairs = do
  menu <- menuNew
  forM_ pairs $ \row -> do
    let (name, act) = row
    item <- menuItemNewWithLabel name
    afterActivateLeaf item act
    menuShellAppend menu item
  return menu

