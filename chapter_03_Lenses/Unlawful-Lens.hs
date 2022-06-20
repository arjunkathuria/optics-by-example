{-# LANGUAGE TemplateHaskell #-}

import Control.Lens
import Control.Lens.Unsound (lensProduct)

type UserName = String

type UserId = String

data Session = Session
  { _userId :: UserId,
    _userName :: UserName,
    _createdAt :: String,
    _expiresAt :: String
  }
  deriving (Show, Eq)

makeLenses ''Session

-- This Lens is still lawful, since the focuses of the lenses involved are disjoint
userInfo :: Lens' Session (UserId, UserName)
userInfo = lensProduct userId userName

session :: Session
session = Session "USER-1234" "Izuku Midoriya" "21-06-2022" "21-07-2022"

alongsideUserId :: Lens' Session (Session, UserId)
alongsideUserId = lensProduct id userId

alongsideUserId' :: Lens' Session (UserId, Session)
alongsideUserId' = lensProduct userId id

newSession :: Session
newSession = session {_userId = "USER-4200"}

{-

It fails the first law, you get back what you set (Set-Get) Law.

λ> view alongsideUserId (set alongsideUserId (newSession, "USER-6969") session)

(Session {_userId = "USER-6969", _userName = "Izuku Midoriya", _createdAt = "21-06-2022", _expiresAt = "21-07-2022"},"USER-6969")

\^Here, the later "USER-6969" overwrites the one set in newSession, "USER-4200"
just because it came after

-------

When we do it in reverse, we can see the overwrite reverses as-well

λ> view alongsideUserId' (set alongsideUserId' ("USER-6969", newSession) session)

("USER-4200",Session {_userId = "USER-4200", _userName = "Izuku Midoriya", _createdAt = "21-06-2022", _expiresAt = "21-07-2022"})

now, the "USER-4200" overwrites the set from "USER-6969"
--

This violates the first law, we don't get exactly what we set back
when we try to view it after setting

-}
