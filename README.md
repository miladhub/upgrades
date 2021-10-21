# upgrades

It should work like this:

* the caller should read which upgrades have been already executed (or the last one) and pass this info on
* all upgrades that are found after that, are queued for execution
* each upgrade can produce logs that will be written on DB
* after each upgrade, its number is persisted on DB

This does not attempt to "catch all" after each upgrade, which is virtually impossible.
It is necessary that each upgrade be idempotent.

data Upgrade =
  Upgrade
    { num :: Int
    , run :: IO [String]
    }

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


main = fetch >>= runAll

runAll :: [Upgrade] -> IO ()
runAll us = do 
  logs <- concat <$> (sequence $ runOne <$> us)
  writeLogs logs

fetch :: IO [Upgrade]
fetch = undefined

writeLogs :: [String] -> IO ()
writeLogs = undefined

runOne :: Upgrade -> IO [String]
runOne = undefined
