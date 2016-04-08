{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}
-- This is the main configuration file for Propellor, and is used to build
-- the propellor program.
module Main where

import Propellor
import Propellor.Types.MetaTypes
import Propellor.Types.Core
import qualified Propellor.Property.File as File
import qualified Propellor.Property.Apt as Apt
import qualified Propellor.Property.Apt.PPA as PPA
import qualified Propellor.Property.Cron as Cron
import qualified Propellor.Property.User as User

main :: IO ()
main = defaultMain hosts

-- The hosts propellor knows about.
hosts :: [Host]
hosts =
  [ mybox
  ]


--ppas :: Property DebianLike
--ppas :: Property DebianLike -> Property (DebianLike)
ppas ps = ps
    & PPA.addPpa (PPA.PPA "hvr" "ghc")
    & PPA.addPpa (PPA.PPA "webupd8team" "sublime-text-3")
    & PPA.addPpa (PPA.PPA "stefansundin" "truecrypt")
    & PPA.addPpa (PPA.PPA "webupd8team" "java")



-- An example host.
mybox :: Host
mybox = host "desktop.kco.io" $ props
  & osBuntish "wily" "amd64"
  & PPA.addPpa (PPA.PPA "hvr" "ghc")
  & PPA.addPpa (PPA.PPA "webupd8team" "sublime-text-3")
  & PPA.addPpa (PPA.PPA "stefansundin" "truecrypt")
  & PPA.addPpa (PPA.PPA "webupd8team" "java")
  & Apt.installed packages
  & Cron.runPropellor (Cron.Times "30 * * * *")






packages :: [Apt.Package]
packages = devPackages ++ otherPackages


devPackages :: [Apt.Package]
devPackages = [
    "ghc-7.10.3"
  , "cabal-1.24"
  , "sublime-text-installer"
  , "emacs"
  , "git"
  , "gitk"
  , "gitg"
  , "virtualbox"
  , "virtualbox-guest-additions-iso"
  , "filezilla"
  , "oracle-java8-installer"
  , "guake"
  ]



otherPackages :: [Apt.Package]
otherPackages = [
    "vlc", "gimp", "gimp-data", "gimp-plugin-registry", "gimp-data-extras", "flashplugin-installer", "synaptic"
  , "p7zip", "p7zip-full", "p7zip-rar", "unity-tweak-tool", "indicator-multiload", "curl", "wget"
  , "gparted", "dkms", "php5-curl", "php5-json", "phpunit", "mcrypt", "ssmtp", "mailutils"
  , "mpack", "truecrypt", "nautilus-open-terminal", "linux-headers-generic", "build-essential"
  , "tp-smapi-dkms", "thinkfan moc", "unace", "unrar", "zip", "unzip", "p7zip-full"
  , "p7zip-rar", "sharutils", "rar", "uudeview", "mpack", "arj", "cabextract"
  , "file-roller", "libxine1-ffmpeg", "mencoder", "flac", "faac", "faad", "sox"
  , "ffmpeg2theora", "libmpeg2-4", "uudeview", "libmpeg3-1", "mpeg3-utils", "mpegdemux", "liba52-dev"
  , "mpeg2dec", "vorbis-tools", "id3v2", "mpg321", "mpg123", "libflac++6", "totem-mozilla"
  , "icedax", "lame", "libmad0", "libjpeg-progs", "libdvdcss2", "libdvdread4", "libdvdnav4"
  , "libswscale-extra-2", "ubuntu-restricted-extras", "ubuntu-wallpapers*"
  ]