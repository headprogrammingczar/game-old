import Game.UI.StartWindow
import Game.Imports

main = do
  initGUI
  state <- newEmptyGame
  runStartWindow state
  mainGUI

