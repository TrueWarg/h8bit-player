{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module UiKit.ListItem where

import           Control.Lens
import           Data.Default
import           Data.Text        (Text, pack)
import           Data.UUID        (UUID, nil)
import           Monomer
import           Types            (ClickEvent (..))
import qualified UiKit.Color      as Color
import qualified UiKit.Typography as Typography

data BasicProps =
  BasicProps
    { _basicUID      :: UUID
    , _basicTitle    :: Text
    , _basicSubtitle :: Text
    , _basicIconRes  :: Text
    }
  deriving (Eq, Show)

type ItemEnv = WidgetEnv BasicProps ClickEvent

type ItemNode = WidgetNode BasicProps ClickEvent

instance Default BasicProps where
  def =
    BasicProps
      { _basicUID = nil
      , _basicTitle = ""
      , _basicSubtitle = ""
      , _basicIconRes = ""
      }

makeLensesWith abbreviatedFields 'BasicProps

itemRowKey :: BasicProps -> Text
itemRowKey props = "basicPropsRow" <> (pack $ show $ props ^. uID)

basic :: ItemEnv -> BasicProps -> ItemNode
basic wenv props = widgetTree
  where
    itemKey = itemRowKey props
    icon =
      image_ (props ^. iconRes) [fitFill] `styleBasic`
      [width 32, height 32, radius 12]
    textBody =
      box_ [alignCenter] $
      vstack
        [ Typography.body1 (props ^. title)
        , Typography.body1 (props ^. subtitle) `styleBasic`
          [textColor Color.white01]
        ]
    body = hstack [icon, spacer, textBody] `styleBasic` [padding 12]
    widgetTree = box_ [onClick ClickEvent, alignCenter] body
