module Main where

import Prelude hiding (log)
import Upgrades

main :: IO ()
main = upgrade [u1, u2]

instance Console IO where
  write = putStrLn

u1 =
  Upgrade
    { num = 1
    , run = return ["foo", "bar"]
    }

u2 =
  Upgrade
    { num = 2
    , run = return ["baz"]
    }

