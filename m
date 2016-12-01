From: Andrey Utkin <andrey_utkin@fastmail.com>
Date: Thu, 01 Dec 2016 21:31:40 +0000
Subject: Re: [PATCH v7 0/3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20161201213140.GF27009@dell-m4800.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161123173340.GA24872@angband.pl>
 <1480265509-20922-1-git-send-email-manuel.schoelling@gmx.de>
 <20161127213730.GO11418@dell-m4800.home>
 <1480368499.29156.12.camel@gmx.de>
 <20161129100115.GA20034@stationary.pb.com>
 <1480626203.7664.7.camel@gmx.de>
In-Reply-To: <1480626203.7664.7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, gregkh@linuxfoundation.org, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 01, 2016 at 10:03:23PM +0100, Manuel Sch=F6lling wrote:
> Hi Andrey,
>=20
> On Di, 2016-11-29 at 10:01 +0000, Andrey Utkin wrote:
> > On Mon, Nov 28, 2016 at 10:28:19PM +0100, Manuel Sch=F6lling wrote:
> > Regarding logout scrollback clearing not working for me. ncurses-6.0-rc1
> > which I tested it with is the latest available in Gentoo portage, please
> > confirm whether I need any newer version, or should I tune something
> > else. I'd appreciate if you also tested your patch with gentoo setup.
>=20
> I finally setup gentoo

Wow, what a big undertaking.

> running agetty (util-linux-2.26.2) and patching
> the file term-utils/agetty.c with
>=20
> static void termio_clear(int fd)
> {
> 	/*
> 	 * Do not write a full reset (ESC c) because this destroys
> 	 * the unicode mode again if the terminal was in unicode
> 	 * mode.  Also it clears the CONSOLE_MAGIC features which
> 	 * are required for some languages/console-fonts.
> 	 * Just put the cursor to the home position (ESC [ H),
> 	 * erase everything below the cursor (ESC [ J), and set the
> 	 * scrolling region to the full window (ESC [ r)
> 	 */
> -	write_all(fd, "\033[r\033[H\033[J", 9);
> +	write_all(fd, "\033[3J\033[r\033[H\033[J", 13);
> }
>=20
> solves the issue with the scrollback buffer after log out.
> Let me know if you agree that this is the right way to go and I will
> send a patch to the maintainer of util-linux.

I believe you that this works and you must know better than me whether
this solution is correct. Besides that, I'd suggest updating that large
block comment before the updated write_all() call to describe the new
action you're doing. Please CC me in your discussion with util-linux
maintainers.

Also I'd suggest coming back in a while, to set this feature enabled by
default. I wonder how many years to wait gracefully until "stable"
distros update util-linux to ensure secure scrollback wiping. 3? 5?

> Thanks again for spending all this time to test the patch!

Thank you very much for your time and effort in bringing this useful
feature!

I give all sorts of my approval on this patchset:
Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
