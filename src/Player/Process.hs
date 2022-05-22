module Player.Process where

import           Player.Types (PID, Playback)

play :: PID -> Int -> IO ()
play pid position = error "Not Implemented"

stop :: PID -> IO ()
stop pid = error "Not Implemented"

pause :: PID -> IO (Playback)
pause pid = error "Not Implemented"

resume :: Playback -> IO ()
resume playback = error "Not Implemented"
