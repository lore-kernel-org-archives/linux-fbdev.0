From: Adam Borowski <kilobyte@angband.pl>
Date: Sun, 27 Nov 2016 23:15:48 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161127231548.GA29376@angband.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
 <20161127213730.GO11418@dell-m4800.home>
In-Reply-To: <20161127213730.GO11418@dell-m4800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 27, 2016 at 09:37:30PM +0000, Andrey Utkin wrote:
> I've just patched next-20161125 with this set and given it a run.
> 
> Scrollback persistence works fine, just as in earlier versions.
> 
> This time I didn't forget to test clear operation.
> 
> The only important concern is that after logout, the scrollback is not
> wiped by /bin/login or /sbin/agetty (not sure who of them is responsible
> for that). What do you see on your workstations in this case?

If you're on Debian or a derivative, that's clear_console.  It uses a
switch-vt-then-back hack which obviously doesn't work with scrollback
persistence.  Reported as https://bugs.debian.org/845177 -- I'll molest the
maintainer if the patch doesn't get applied soon, so we can have the fix in
time for stretch (then Ubuntu zesty).

Because of a sad lack of a time machine, old systems will use clear_console
with that hack until they die, that's why
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT defaults to n; in a few years it'll
be ok to flip it.

> I guess we need to do something of the following:
>  - catch some control character sequences to wipe the scrollback

\e[3J

>  - indicate (by some flag) some feature capability for this

Terminfo calls this flag "E3".

>  - request update in terminfo database or whatever, to let ncurses know
>    that it is capable of scrollback wiping by some control charater
>    sequences

Already there for quite a while.

> clear(1) doesn't wipe the scrollback at all, it is still reachable, all
> of it.

It does for me on the console.  The man page says:

# clear clears your screen if this is possible, including its scrollback
# buffer (if the extended "E3" capability is defined).  clear looks in the
# environment for the terminal type and then in the terminfo database to
# determine how to clear the screen.

Because of its reliance on terminfo, you need to have TERM=linux in your
environment; also, screen/tmux obviously breaks this.

> echo -e "\e[3J" seems to wipe the scrollback, but if you do it several
> times in a row, every time you (or at last I do) get your prompt a bit
> lower, so after many times you end up with blank screen and the prompt
> at the bottom of the screen.

Yeah, none of \e[J subcommands move the cursor at all.  As you use echo
without -n, you move two lines lower, and even with -n the command you typed
takes a line.  You want to move the cursor explicitly, add "\e[H".


Meow!
-- 
The bill declaring Jesus as the King of Poland fails to specify whether
the addition is at the top or end of the list of kings.  What should the
historians do?
