From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Sun, 27 Nov 2016 21:37:30 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161127213730.GO11418@dell-m4800.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Manuel,

I've just patched next-20161125 with this set and given it a run.

Scrollback persistence works fine, just as in earlier versions.

This time I didn't forget to test clear operation.

The only important concern is that after logout, the scrollback is not
wiped by /bin/login or /sbin/agetty (not sure who of them is responsible
for that). What do you see on your workstations in this case?

I guess we need to do something of the following:
 - catch some control character sequences to wipe the scrollback
 - indicate (by some flag) some feature capability for this
 - request update in terminfo database or whatever, to let ncurses know
   that it is capable of scrollback wiping by some control charater
   sequences


Some useless notes follow.

I see the user experience is subpar to what I'm accustomed to (I use
Konsole and "Clear Scrollback and Reset" action, default shortcut is
Ctrl+Shift+K). The strange behaviour moments have nothing to do with
current patchset but are properties of vgacon, though. (I compared it
with another PC which runs without this patchset, and it looks like it
runs vgacon, too, however, I'm not sure how to ensure this at runtime.)

clear(1) doesn't wipe the scrollback at all, it is still reachable, all
of it.

echo -e "\e[3J" seems to wipe the scrollback, but if you do it several
times in a row, every time you (or at last I do) get your prompt a bit
lower, so after many times you end up with blank screen and the prompt
at the bottom of the screen.

Have you encountered this, or is it something specific to my setup (I
use bash prompt spanning to multiple lines, and calling "stty sane" from
inside every PS1 evaluation. I can share the config if you request it).
