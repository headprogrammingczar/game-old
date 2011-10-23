import Game.Imports
import Game.UI.StartWindow

main = do
  initGUI
  state <- newEmptyGame
  runStartWindow state
  mainGUI

