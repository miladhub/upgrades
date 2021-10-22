{-# LANGUAGE FlexibleInstances #-}

import Upgrades
import Control.Monad.State
import Test.Hspec

type MockState = State [String]

instance Console MockState where
  write s = do
    xs <- get
    put (xs ++ [s])

getLogs :: [Upgrade MockState] -> [String]
getLogs us =
  snd $ runState (upgrade us) []

main :: IO ()
main = hspec $ do
  describe "Upgrades" $ do
    it "write logs" $ do
      getLogs [u1, u2] `shouldBe` ["foo", "bar", "baz"]

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

