module NaiveLens where

import Control.Lens

data Ship = Ship
 { _name :: String
 , _numCrew :: Int
 } deriving (Show)


-- lens :: (s -> a) -> (s -> b -> t) -> Lens s t a b
-- lens :: (s -> a) -> (s -> a -> s) -> Lens' s a

-- The getter fn, with a type (s -> a),
-- Here that transforms to (Ship -> Int)

getNumCrew :: Ship -> Int
getNumCrew = _numCrew

-- The setter fn has a type (s -> a -> s)
-- Here that means (Ship -> Int -> Ship)

setNumCrew :: Ship -> Int -> Ship
setNumCrew ship newNumCrew = ship {_numCrew = newNumCrew}

numCrew :: Lens' Ship Int
numCrew = lens getNumCrew setNumCrew


-- Repeat this for name

getShipName :: Ship -> String
getShipName = _name

setShipName :: Ship -> String -> Ship
setShipName ship newName = ship {_name = newName}

name :: Lens' Ship String
name = lens getShipName setShipName

-- Modifying

-- There isn't much to modifying, it just gets the value first
-- applies the provided function over it and then sets it back
-- it can be implemented using the getters & setters we already have
