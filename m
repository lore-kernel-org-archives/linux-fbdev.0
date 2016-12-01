From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Thu, 01 Dec 2016 21:03:23 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1480626203.7664.7.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
         <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
         <20161127213730.GO11418@dell-m4800.home> <1480368499.29156.12.camel@gmx.de>
         <20161129100115.GA20034@stationary.pb.com>
In-Reply-To: <20161129100115.GA20034@stationary.pb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrey,

On Di, 2016-11-29 at 10:01 +0000, Andrey Utkin wrote:
> On Mon, Nov 28, 2016 at 10:28:19PM +0100, Manuel Sch=C3=B6lling wrote:
> Regarding logout scrollback clearing not working for me. ncurses-6.0-rc1
> which I tested it with is the latest available in Gentoo portage, please
> confirm whether I need any newer version, or should I tune something
> else. I'd appreciate if you also tested your patch with gentoo setup.

I finally setup gentoo running agetty (util-linux-2.26.2) and patching
the file term-utils/agetty.c with

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
-	write_all(fd, "\033[r\033[H\033[J", 9);
+	write_all(fd, "\033[3J\033[r\033[H\033[J", 13);
}

solves the issue with the scrollback buffer after log out.
Let me know if you agree that this is the right way to go and I will
send a patch to the maintainer of util-linux.

Thanks again for spending all this time to test the patch!

Have a good weekend!

Manuel


