{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE OverloadedStrings      #-}
{-# LANGUAGE TemplateHaskell        #-}

module UiKit.ListItem where

import           Control.Lens
import           Data.Default
import           Data.Text        (Text, pack)
import           Monomer
import           Types            (ClickEvent (..))
import qualified UiKit.Color      as Color
import qualified UiKit.Typography as Typography

data BasicProps =
  BasicProps
    { _basicUID      :: Text
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
      { _basicUID = ""
      , _basicTitle = ""
      , _basicSubtitle = ""
      , _basicIconRes = ""
      }

makeLensesWith abbreviatedFields 'BasicProps

itemRowKey :: BasicProps -> Text
itemRowKey props = "basicPropsRow" <> (props ^. uID)

basic ::
     (WidgetModel s, WidgetEvent e)
  => WidgetEnv s e
  -> BasicProps
  -> e
  -> WidgetNode s e
basic wenv props clickEvent = widgetTree
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
    widgetTree = box_ [onClick clickEvent, alignCenter] body
