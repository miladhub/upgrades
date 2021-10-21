module UpgradesDSL
  ( Res
  , Upgrade(..)
  , log
  , crash
  , upgrade
  ) where

import Control.Monad
import Control.Monad.State
import Control.Monad.Trans.Maybe
import Prelude hiding (log)

type Res = MaybeT (StateT [String] IO)

data Upgrade =
  Upgrade
    { num :: Int
    , run :: Res ()
    }

log :: String -> Res ()
log s = do
  logs <- get
  put (logs ++ [s])

crash :: Res ()
crash = mzero

eval :: Res a -> IO (Maybe a, [String])
eval r = (runStateT . runMaybeT) r []

runOne :: Upgrade -> Res Int
runOne u = do
  run u
  return (num u)

runAll :: [Upgrade] -> Res [Int]
runAll = traverse runOne

upgrade :: [Upgrade] -> IO (Maybe [Int], [String])
upgrade = eval . runAll
