module Main where

import Text.Megaparsec (eof, manyTill, optional)
import Text.Megaparsec.Char (newline)

import Util

getFuelReq :: Int -> Int
getFuelReq mass = (mass `div` 3) - 2

getFuelReqOnInputList :: [Int] -> Int
getFuelReqOnInputList inputList = do
  let listMapped = map getFuelReq inputList
  sum listMapped

parsedInput :: [Int]
parsedInput = inputParser parseMasses "input.txt"

parseMasses :: Parser [Int]
parseMasses = manyTill (parseMass <* optional newline) eof

parseMass :: Parser Int
parseMass = signedInteger

main :: IO ()
main = do
  putStr "The Final sum is: "
  print $ getFuelReqOnInputList parsedInput
