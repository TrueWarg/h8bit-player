{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}

module Main where

import           Control.Lens
import           Data.Default
import           Data.Text         (Text, unpack)
import           Monomer
import qualified Monomer.Lens      as L
import qualified StrRes
import           TextShow
import           UiKit.FileDialogs (openSelectFileDialog,
                                    openSelectFolderDialog)
import           UiKit.ListItem    as ListItem
import           UiKit.Typography

data AppModel =
  AppModel
    { _items  :: [ListItem.BasicProps]
    , _active :: ListItem.BasicProps
    , _files  :: [Text]
    }
  deriving (Eq, Show)

data AppEvent
  = Idle
  | SelectFiles
  | FilesSelected [Text]
  | SelectItem ListItem.BasicProps
  deriving (Eq, Show)

makeLenses 'AppModel

buildUI ::
     WidgetEnv AppModel AppEvent -> AppModel -> WidgetNode AppModel AppEvent
buildUI wenv model = widgetTree
  where
    witems =
      map (\item -> ListItem.basic wenv item (SelectItem item)) (model ^. items)
    widgetTree =
      vstack
        [ hstack
            [ mainButton StrRes.selectTracks SelectFiles
            , spacer
            , body1 $ mconcat $ model ^. files
            ]
        , vstack witems `styleBasic` [padding 10]
        ] `styleBasic`
      [padding 10]

handleEvent ::
     WidgetEnv AppModel AppEvent
  -> WidgetNode AppModel AppEvent
  -> AppModel
  -> AppEvent
  -> [AppEventResponse AppModel AppEvent]
handleEvent wenv node model evt =
  case evt of
    Idle                -> []
    SelectFiles         -> selectFiles
    FilesSelected paths -> [Model (model & files .~ paths)]
    SelectItem item     -> [Model (model & active .~ item)]

selectFiles =
  [ Task $ do
      sr <-
        openSelectFileDialog
          StrRes.selectTracks
          "./"
          ["*.wav", "*.ogg"]
          StrRes.wavOrOggFiles
          True
      case sr of
        Nothing    -> return Idle
        Just paths -> return $ FilesSelected $ paths
  ]

main :: IO ()
main = do
  startApp model handleEvent buildUI config
  where
    config =
      [ appWindowTitle "Player"
      , appWindowIcon "./assets/images/icon.bmp"
      , appTheme darkTheme
      , appFontDef "Regular" "./assets/fonts/Roboto-Regular.ttf"
      , appInitEvent Idle
      ]
    model =
      AppModel
        mocks
        (ListItem.BasicProps
           "1"
           "Title 1"
           "Subitlt 1"
           "./assets/images/icon.bmp")
        []

mocks :: [ListItem.BasicProps]
mocks = items
  where
    items =
      [ ListItem.BasicProps "1" "Title 1" "Subitlt 1" "./assets/images/icon.bmp"
      , ListItem.BasicProps "2" "Title 2" "Subitlt 2" "./assets/images/icon.bmp"
      , ListItem.BasicProps "3" "Title 3" "Subitlt 3" "./assets/images/icon.bmp"
      , ListItem.BasicProps "4" "Title 4" "Subitlt 4" "./assets/images/icon.bmp"
      , ListItem.BasicProps "5" "Title 5" "Subitlt 5" "./assets/images/icon.bmp"
      ]
