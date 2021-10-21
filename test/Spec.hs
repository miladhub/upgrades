{-# LANGUAGE FlexibleInstances #-}

import Upgrades
import Control.Monad.State
import Test.Hspec

u1 :: Upgrade MockState
u1 =
  Upgrade
    { num = 1
    , run = return ["foo", "bar"]
    }

u2 :: Upgrade MockState
u2 =
  Upgrade
    { num = 2
    , run = return ["baz"]
    }

type MockState = State [String]

writeMock :: String -> MockState ()
writeMock s = do
  xs <- get
  put (xs ++ [s])

instance Console MockState where
  write = writeMock

getLogs :: [Upgrade MockState] -> [String]
getLogs us =
  snd $ runState (upgrade us) []

main :: IO ()
main = hspec $ do
  describe "Upgrades" $ do
    it "write logs" $ do
      getLogs [u1, u2] `shouldBe` ["foo", "bar", "baz"]
