From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 2.6.28 1/2] gpiolib: add set/get batch v4
Date: Mon, 19 Jan 2009 11:03:42 +0100
Message-ID: <20090119100342.GA16400@pengutronix.de>
References: <12321862383405-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759251AbZASKE2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12321862383405-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

Hi Jaya,

On Sat, Jan 17, 2009 at 05:57:17PM +0800, Jaya Kumar wrote:
> Hi friends,
>=20
> This is v4 of batch support for gpiolib. Thanks to David Brownell, Er=
ic Miao,
> David Hylands, Robin, Ben, Jamie and others for prior feedback. The p=
ost for
> v3 summarized the previous discussion. Since then the changes I've ma=
de are:
> - split the patches into generic and arch specific
IMHO this should be three patches: "gpiolib", "pxa" and "am300epd".
Well, ...

> +[OPTIONAL] Spinlock-Safe GPIO Batch access
Is it really spinlock safe in general?  Or only if gpio_cansleep(gpio)
if false for each gpio to get or set?

> +static int __generic_gpio_set_batch(struct gpio_chip *chip, unsigned=
 offset,
> +					u32 values, u32 bitmask, int width)
IMHO a better name is __gpio_set_batch_generic (or
__gpiolib_set_batch_generic?), YMMV.

> +int __gpio_set_batch(unsigned gpio, u32 values, u32 bitmask, int bit=
width)
Sometimes your width parameter is called bitwidth, sometimes width.  I'=
d
like to have that consistant.

While talking about this parameter.  I don't really like it, because yo=
u
can calculate it from bitmask.  In an earlier mail you write:

	bitwidth (needed to iterate and map to chip ngpios) could be
	calculated from bitmask, but that involves iteratively counting
	bits from the mask, so we would have to do 800*600 bit counts.
	Unless, we do ugly things like cache the previous bitwidth/mask
	and compare against the current caller arguments. Given that the
	bitwidth would typically be a fixed value, I believe it is more
	intuitive for the caller to provide it, ...

I think it's easier than that.  bitwidth is just fls(bitmask) which
should be efficient enough not to bother the programmer.  If bitmask is
constant it's even the compiler that does the work here.

BTW, I wonder why the argument to fls has type int and not unsigned.

Best regards,
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
