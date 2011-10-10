module Game.UI.Base where

import Game.Imports

safeDestroy :: (WidgetClass self) => self -> ConnectId self -> IO ()
safeDestroy w destroyid = do
  signalDisconnect destroyid
  widgetDestroy w

idleDo :: IO a -> IO HandlerId
idleDo act = do
  idleAdd (act >> return False) priorityDefaultIdle

