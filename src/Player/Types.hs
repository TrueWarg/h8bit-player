module Player.Types where

type Megabyte = Float

type PID = String

data Status
  = Play
  | Pause
  | Stop
  deriving (Show)

data Event
  = EvPlay
  | EvPause
  | EvStop
  | EvResume
  deriving (Show)

data Track =
  Track
    { filePath :: FilePath
    , duration :: Float
    , size     :: Megabyte
    , name     :: Maybe String
    , album    :: Maybe String
    , author   :: Maybe String
    }

data PlayList =
  PlayList
    { playListName :: String
    , trackPaths   :: [FilePath]
    }

data Playback =
  Playback
    { pid           :: PID
    , trackDuration :: Float
    , position      :: Int
    }

data Player =
  Player
    { playLists :: [PlayList]
    , tracks    :: [Track]
    , status    :: Status
    , playback  :: Maybe Playback
    }
