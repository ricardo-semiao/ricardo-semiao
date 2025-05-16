# Setting Up Windows

This document presents my workflow for setting up a Windows machine. Currently, it is not done, I am only adding some dump information here.



## Package Installers

Keep in mind this advice: "If you mix tools, test installations in a virtual machine or isolated environment to identify potential conflicts." (lets try it).

Winget vs Chocolatey params:

Chocolatey:

```
--log-file=VALUE
	Log File to output to in addition to regular loggers.
-s, --source=VALUE
	Source - The source to find the package(s) to install. Special sources 
	include: ruby, cygwin, windowsfeatures, and python. To specify more than 
	one source, pass it with a semi-colon separating the values (e.g. 
	"'source1;source2'"). Defaults to default feeds.
--version=VALUE
	Version - A specific version to install. Defaults to unspecified.
--ia, --installargs, --install-args, --installarguments, --install-arguments=VALUE
	InstallArguments - Install Arguments to pass to the native installer in 
	the package. Defaults to unspecified.
-o, --override, --overrideargs, --overridearguments, --override-arguments
	OverrideArguments - Should install arguments be used exclusively without 
	appending to current package passed arguments? Defaults to false.
--params, --parameters, --pkgparameters, --packageparameters, --package-parameters=VALUE
	PackageParameters - Parameters to pass to the package. Defaults to 
	unspecified.
```

Also note https://boxstarter.org/whyboxstarter.

Winget:

```
--locale	Specifies which locale to use (BCP47 format).
-o, --log	Directs the logging to a log file. You must provide a path to a file that you have the write rights to.
--custom	Arguments to be passed on to the installer in addition to the defaults.
--override	A string that will be passed directly to the installer.
-l, --location	Location to install to (if supported).
--ignore-security-hash	Ignore the installer hash check failure. Not recommended.
--allow-reboot	Allows a reboot if applicable.
```
