# Matt's .bashrc
My .bashrc files for Linux and Cygwin (Windows). This should be compatible with bash on most common UNIX systems, and I've tested it on my installation of Fedora 25 (using i3 as a window manager) and Cygwin on Windows 10. 

![Example gnome-terminal instance on i3](/img/example.png?raw=true)
![Example gnome-terminal instance on i3 in a working environment](/img/example-full.png?raw=true)

# Features

A list of information provided in the prompt, from left to right, is as follows:

* Username and hostname
* Jobs running in the background
* Command number in bash history and since starting this session
* If applicable, battery charge % and time remaining
* The version of bash
* The current time
* The last command executed, with all aliases expanded
* The runtime of the last command executed
* The exit status of the last command executed
* The current working directory
* The git branch in which work is currently being done
* The user privelege (either $ or #)

# Design Choices
The obvious design choice made is that my preference is to have the prompt provide as much information as possible without regard to space. This runs counter to a lot of what I've seen in the GNU/Linux enthusiast community, but I like it. It has come in handy fairly frequently to have all commands timed by default, to be able to see my full working path, to see the history number of the past few commands for the bash `!` syntax, etc. 

The brightly colored boxes may seem aggressive, but I find it much easier to find my place. When `cat`ing a large file and scrolling back in the history, it can be hard to find your place. Even worse, when debugging the compilation of a program, one can accidentally miss the prompt when scrolling back and attempt to fix errors which have already been fixed! As such I found it useful to add an extremely colorful block as a note that the last command entered was here.

Just before the prompt, I display a random unicode character. This is completely just for fun.

