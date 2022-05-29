module UiKit.Theme where

import           Monomer
import           Monomer.Core.Themes.BaseTheme
import qualified UiKit.Color                   as Color

dark :: Theme
dark =
  baseTheme
    darkThemeColors
      { btnMainBgBasic = Color.blue01
      , btnMainBgHover = Color.blue02
      , btnMainBgFocus = Color.blue03
      , btnMainBgActive = Color.blue04
      , btnMainBgDisabled = Color.blue05
      , btnMainText = Color.white
      , slMainBg = Color.gray01
      }
