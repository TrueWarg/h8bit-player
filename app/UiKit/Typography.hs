module UiKit.Typography where

import           Data.Text (Text)
import           Monomer

body1 txt = label txt `styleBasic` [textFont "Regular", textSize 14]

caption1 txt = label txt `styleBasic` [textFont "Regular", textSize 12]
