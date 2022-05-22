module Player.Storage where

import           Player.Types (PlayList, Snapshot)

saveSnapshot :: Snapshot -> IO ()
saveSnapshot snapshot = error "Not Implemented"

readLastSnapshot :: IO (Snapshot)
readLastSnapshot = error "Not Implemented"

savePlayList :: PlayList -> IO ()
savePlayList list = error "Not Implemented"

deletePlayList :: String -> IO ()
deletePlayList name = error "Not Implemented"

addTrackToPlayList :: FilePath -> String -> IO ()
addTrackToPlayList trackPath playListName = error "Not Implemented"

deleteTrackToPlayList :: FilePath -> String -> IO ()
deleteTrackToPlayList trackPath playListName = error "Not Implemented"
