module Main where

import Prelude hiding (log)
import Upgrades

main :: IO ()
main = do
  r <- upgrade [u1, u2]
  print r

u1 =
  Upgrade
    { num = 1
    , run =
        do log "did this"
           log "did that"
    }

u2 =
  Upgrade
    { num = 2
    , run =
        do log "attempting upgrade"
           crash
    }
