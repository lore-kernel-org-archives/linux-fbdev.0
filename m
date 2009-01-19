From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC 2.6.28 1/2] gpiolib: add set/get batch v4
Date: Mon, 19 Jan 2009 18:25:36 +0100
Message-ID: <20090119172536.GA12407@pengutronix.de>
References: <12321862383405-git-send-email-jayakumar.lkml@gmail.com> <20090119100342.GA16400@pengutronix.de> <45a44e480901190619i18749c75jaa2d4606da251921@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45a44e480901190619i18749c75jaa2d4606da251921@mail.gmail.com>
Sender: linux-embedded-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-embedded@vger.kernel.org

Hi Jaya,

> >> +[OPTIONAL] Spinlock-Safe GPIO Batch access
> > Is it really spinlock safe in general?  Or only if gpio_cansleep(gp=
io)
> > if false for each gpio to get or set?
>=20
> You are correct to raise this issue. It is only spinlock safe if
> chip->cansleep is false. Initially, I wasn't sure what to do. The
> original gpio set/get_value() just does;
>         WARN_ON(extra_checks && chip->can_sleep);
> and it is documented as:
>=20
> "
> Spinlock-Safe GPIO access
> -------------------------
> <snip>
> return zero.  Also, using these calls for GPIOs that can't safely be =
accessed
> without sleeping (see below) is an error.
> "
>=20
> I will change this in the batch code to return an error if can_sleep
> is detected on any involved gpio_chip.
Wait, I got it wrong.  I thought gpio_set_value might sleep if
chip->cansleep is true, but there are extra API functions for
cansleep-chips.  So I'd do it the same way as for the non-batch
functions and just WARN_ON(extra_checks && chip->cansleep) for each
involved chip.

Later it might make sense to add the _cansleep variants.

Best regards
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
