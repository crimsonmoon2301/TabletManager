# TabletManager
A collection of scripts that help managing DIY distros with minimalistic installs for tablet users without the need of installing additional programs.


This is highly work in progress and the implementation currently works on systems running Gentoo Linux as the main distribution, and IWD for managing wireless daemons. At it's current state, it is possible to use these scripts for other distributions, but configuration is needed.

Possible TODO list:
1. Finish the main implementations of the scripts
2. Add other distro support, like Debian deriatives, or even Arch/Void
3. Overall better structure in general.

The core functionality:
1. A TUI based selection to do specific tasks, such as updating, managing networks.
2. Scripts to do the desired functionality. By default they are bash scripts, but in the future they may be made into bourne shell type of scripts, ensuring universal functionality outside of distributions that DON'T USE BASH.
