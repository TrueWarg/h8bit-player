{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import           Control.Lens
import           Data.Default
import           Data.Text      (Text)
import           Data.UUID      (UUID, nil)
import           Monomer
import qualified Monomer.Lens   as L
import           TextShow
import           UiKit.ListItem as ListItem

data AppModel =
  AppModel
    { _clickCount :: Int
    , _props      :: ListItem.BasicProps
    }
  deriving (Eq, Show)

data AppEvent
  = AppInit
  | AppIncrease
  deriving (Eq, Show)

makeLenses 'AppModel

item ::
     (WidgetModel sp, WidgetEvent ep)
  => ALens' sp ListItem.BasicProps
  -> WidgetNode sp ep
item props = composite "item" props ListItem.basic (\_ _ _ _ -> [])

buildUI ::
     WidgetEnv AppModel AppEvent -> AppModel -> WidgetNode AppModel AppEvent
buildUI wenv model = widgetTree
  where
    widgetTree =
      vstack [item props, item props, item props, item props] `styleBasic`
      [padding 10]

handleEvent ::
     WidgetEnv AppModel AppEvent
  -> WidgetNode AppModel AppEvent
  -> AppModel
  -> AppEvent
  -> [AppEventResponse AppModel AppEvent]
handleEvent wenv node model evt =
  case evt of
    AppInit     -> []
    AppIncrease -> [Model (model & clickCount +~ 1)]

main :: IO ()
main = do
  startApp model handleEvent buildUI config
  where
    config =
      [ appWindowTitle "Player"
      , appWindowIcon "./assets/images/icon.bmp"
      , appTheme darkTheme
      , appFontDef "Regular" "./assets/fonts/Roboto-Regular.ttf"
      , appInitEvent AppInit
      ]
    model =
      AppModel
        0
        def
          { _basicUID = nil
          , _basicTitle = "Title"
          , _basicSubtitle = "Subitlt"
          , _basicIconRes = "./assets/images/icon.bmp"
          }
