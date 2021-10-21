{-# LANGUAGE GADTs #-}

module Upgrades (Upgrade(..), upgrade, Console(..)) where

import Control.Monad (forM_)

class Monad m => Console m where
  write :: String -> m () 

data Upgrade m where
  Upgrade ::
    { num :: Int                           
    , run :: m [String]
    } -> Upgrade m

upgrade :: Console m => [Upgrade m] -> m ()
upgrade us = do 
  logs <- concat <$> (sequence $ runOne <$> us)
  writeLogs logs

writeLogs :: Console m => [String] -> m ()
writeLogs xs = forM_ xs write

runOne :: Console m => Upgrade m -> m [String]
runOne = run

