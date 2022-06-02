module UiKit.FileDialogs where

import           Data.Text                   (Text)
import Graphics.UI.TinyFileDialogs

openSaveFileDialog :: Text -> Text -> [Text] -> Text -> IO (Maybe Text)
openSaveFileDialog = saveFileDialog

openSelectFileDialog ::
     Text -> Text -> [Text] -> Text -> Bool -> IO (Maybe [Text])
openSelectFileDialog = openFileDialog

openSelectFolderDialog :: Text -> Text -> IO (Maybe Text)
openSelectFolderDialog = selectFolderDialog
