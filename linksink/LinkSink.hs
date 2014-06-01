{-# LANGUAGE TemplateHaskell #-}
import System.Environment ( lookupEnv )
import Control.Applicative ( (<$>), (<*>) )
import Control.Monad.Trans.Maybe ( runMaybeT, MaybeT(..) )
import Control.Lens ( makeLenses )

-- Application-only authentication
--    https://dev.twitter.com/docs/auth/application-only-auth

data Auth = Auth { _authKey, _authSecret :: !String } deriving (Show, Eq)
$(makeLenses ''Auth)

getSecrets :: IO (Maybe Auth)
getSecrets = runMaybeT $ Auth <$> env "TWITTER_OAUTH_KEY" <*> env "TWITTER_OAUTH_SECRET"
  where env = MaybeT . lookupEnv
  
main :: IO ()
main = return ()
