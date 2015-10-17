# What
This is a port of Gabriel Gambetta's demo of client-side prediction and server reconciliation
in networking. It uses the HaxeFlixel engine (4.0.0, commit a77081706b0c7457270ce9fb8a4285345240065b),
and HaxeNet (https://github.com/Ohmnivore/HaxeNet). I have included the original demo in the /doc directory,
in case its source location (http://www.gabrielgambetta.com/fpm_live.html) becomes inaccessible.

I use clumsy (https://github.com/jagt/clumsy) to simulate lag on my computer. It's awesome.

# Why
My previous attempts at multiplayer games were only playable on LAN because I didn't know how to
properly handle lag. Gabriel's demo taught me a lot on how to make multiplayer implementations playable
at high latencies.

# Note
* Windows-only
* Once you compile the client and server, drop the contents of the /ndll directory into both executables' directories
* Uses localhost and port 1337
* Run server, then run client and use left/right or a/d keys in client