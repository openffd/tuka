# Tuka

A supposedly better implementation of the Modder gem.

## Installation

Add these lines to your ```~/.bash_profile```:
```
GS=http://149.28.95.12:8808
AFN=git@bitbucket.org:alphardcenter/tukafile-afn.git
FMD=git@bitbucket.org:alphardcenter/tukafile-fmd.git
```

Install the gem:

    $ sudo gem install tuka --source GS
    $ sudo gem install tuka --source GS -n usr/local/bin  # For Jeff

To update:

    $ sudo gem update tuka --source GS

Check the version of the gem by running:

    $ tuka version

## Usage Summary

First, ```cd``` to the root of your iOS project directory.

For ObjectiveC/Swift:
```
tuka init AFN
tuka generate-library  # gen-lib, gl
tuka generate-podfile  # gen-pod, gp
tuka add-receptor      # addr, ar
```

For Unity:
```
tuka init FMD
tuka generate-library  # gen-lib, gl
tuka generate-podfile  # gen-pod, gp
tuka add-receptor      # addr, ar
```

To automatically install everything after initiating a Tukafile:
```
tuka init [AFN/FMD]
tuka automatic         # install, auto, au
```

Just to update the library:
```
tuka update-lib        # ul
```
