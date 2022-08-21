{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.GI.Base
import qualified GI.Gtk as GTK
import Data.Time
import qualified Data.Time.Zones as Zones
import qualified Data.Time.Zones.All as Zones
import qualified Data.Text as T 

convTime :: Zones.TZ -> UTCTime -> LocalTime
convTime z t = Zones.utcToLocalTimeTZ z t 

ppTime :: String -> [Char]
ppTime = fst . splitAt 5 . unwords . take 5 . tail . words 

main :: IO ()
main = do
    t <- getCurrentTime
    GTK.init Nothing

    win <- new GTK.Window [#title := "Float"]
    on win #destroy GTK.mainQuit
    #resize win 640 480
    msg <- new GTK.Label [#label := dubaiTime t]    
    #add win msg    
    
    #showAll win

    GTK.main

dubaiTime t = T.pack $ ppTime . show $ convTime (Zones.tzByLabel Zones.Asia__Dubai) t

