import Control.Lens

-- Implement the `conditional` Lens from the "is it a Lens" exercise

-- Based on the value of the first element, it either focuses
-- the second element for True
-- the third element if False

conditional :: Lens' (Bool, a, a) a
conditional = lens getter setter
  where
    getter (bool, x, y) =
      case bool of
        True -> x
        False -> y

    setter (bool, x, y) value =
      case bool of
        True -> (bool, value, y)
        False -> (bool, x, value)

-- ghci>> view conditional (True, 1::Int, 2)
-- ghci>> 1
--
-- ghci>> view conditional (False, 1::Int, 2)
-- ghci>> 2
--
-- ghci>> set conditional 69 (True, 1::Int, 2)
-- ghci>> (True, 69, 2)
--
-- ghci>> set conditional 69 (False, 1::Int, 2)
-- ghci>> (False, 69, 2)
