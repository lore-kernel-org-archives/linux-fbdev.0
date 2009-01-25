From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 2.6.28 1/3] gpiolib: add batch set/get
Date: Sun, 25 Jan 2009 12:20:24 +0100
Message-ID: <20090125112024.GA28213@pengutronix.de>
References: <123287728936-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <123287728936-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

Hello Jaya,

On Sun, Jan 25, 2009 at 05:54:47PM +0800, Jaya Kumar wrote:
> - split the patches into generic, arch specific and am300epd
I would swap the order to have:

	generic
	am300epd
	pxa specific

This way the tree of the second commit is a test case for the generic
implementation.

> - adjusting the API to remove width (note, the actual API call where
>   width was dropped is in the arch specific code, not here.)
Nevertheless I would document the "generic" per arch specific
implementation in gpio.txt.  For the functions like __gpio_get_value yo=
u
can just do

	#define gpio_get_value(gpio) __gpio_get_value(gpio)

but for your batch functions you need something like

	#define gpio_set_batch(startpin, mask, values) \
		({ u32 __mask =3D mask; __gpio_set_batch(startpin, __mask, fls(__mask=
), values);})

Maybe better use/recommend an inline function?

> Cc: David Brownell <david-b@pacbell.net>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: linux-arm-kernel@lists.arm.linux.org.uk
> Cc: linux-fbdev-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-embedded@vger.kernel.org
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Note you didn't Cc: me.

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
