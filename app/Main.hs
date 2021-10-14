module Main where

import Upgrades
import Prelude hiding (log)

main :: IO ()
main = do
  r <- upgrade [u1, u2]
  putStrLn $ show r

u1 = Upgrade {
  num = 1,
  run = do
    log "did this"
    log "did that"
  }

u2 = Upgrade {
  num = 2,
  run = do
    log "attempting upgrade"
    crash
  }

