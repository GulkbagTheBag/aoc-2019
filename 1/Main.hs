module Main where

import Text.Megaparsec (eof, manyTill, optional)
import Text.Megaparsec.Char (newline)

import Util

getFuelReq mass = mass `div` 3 - 2

getFullFuelReq mass =
  sum $ takeWhile (> 0) $ iterate getFuelReq (getFuelReq mass)

getFullFuelReqOnInputList inputList = sum $ fmap getFullFuelReq inputList

getFuelReqOnInputList inputList = sum $ fmap getFuelReq inputList

parsedInput = inputParser parseMasses "input.txt"

parseMasses = manyTill (parseMass <* optional newline) eof

parseMass = signedInteger

main :: IO ()
main = do
  putStr "The Final sum is: "
  print $ getFuelReqOnInputList parsedInput
  print $ getFullFuelReqOnInputList parsedInput
