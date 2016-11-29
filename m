From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Tue, 29 Nov 2016 16:35:02 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1480437302.2848.8.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
         <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
         <20161127213730.GO11418@dell-m4800.home> <1480368499.29156.12.camel@gmx.de>
         <20161129100115.GA20034@stationary.pb.com>
In-Reply-To: <20161129100115.GA20034@stationary.pb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrey,

On Di, 2016-11-29 at 10:01 +0000, Andrey Utkin wrote:
> Regarding logout scrollback clearing not working for me. ncurses-6.0-rc1
> which I tested it with is the latest available in Gentoo portage, please
> confirm whether I need any newer version, or should I tune something
> else. I'd appreciate if you also tested your patch with gentoo setup.
Are you sure ncurses is involved at all?
My Debian agetty(8) manpage says:

       -J,--noclear
              Do not clear the screen before prompting for the login name (the
              screen is normally cleared).

And digging into the source code of agetty shows these lines [1]:

static void termio_clear(int fd)
{
	/*
	 * Do not write a full reset (ESC c) because this destroys
	 * the unicode mode again if the terminal was in unicode
	 * mode.  Also it clears the CONSOLE_MAGIC features which
	 * are required for some languages/console-fonts.
	 * Just put the cursor to the home position (ESC [ H),
	 * erase everything below the cursor (ESC [ J), and set the
	 * scrolling region to the full window (ESC [ r)
	 */
	write_all(fd, "\033[r\033[H\033[J", 9);
}

So I guess that agetty relies on on switching the console for flushing
the scrollback buffer and we'd had to add the \E[3J sequence here.

Note that up until now I just had a look at the theory (manpage and
source code). I'd need some days to find time to show at runtime that
this really is the reason why the buffer is not flushed.

Bye,

Manuel

[1] https://github.com/karelzak/util-linux/blob/master/term-utils/agetty.c#L1175


