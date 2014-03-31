module Propellor.Property.Cmd (
	cmdProperty,
	cmdProperty',
	scriptProperty
) where

import Control.Applicative
import Data.List

import Propellor.Types
import Utility.Monad
import Utility.SafeCommand
import Utility.Env

-- | A property that can be satisfied by running a command.
--
-- The command must exit 0 on success.
cmdProperty :: String -> [String] -> Property
cmdProperty cmd params = cmdProperty' cmd params []

-- | A property that can be satisfied by running a command,
-- with added environment.
cmdProperty' :: String -> [String] -> [(String, String)] -> Property
cmdProperty' cmd params env = Property desc $ do
	env' <- addEntries env <$> getEnvironment
	ifM (boolSystemEnv cmd (map Param params) (Just env'))
		( return MadeChange
		, return FailedChange
		)
  where
  	desc = unwords $ cmd : params

-- | A property that can be satisfied by running a series of shell commands.
scriptProperty :: [String] -> Property
scriptProperty script = cmdProperty "sh" ["-c", shellcmd]
  where
	shellcmd = intercalate " ; " ("set -e" : script)