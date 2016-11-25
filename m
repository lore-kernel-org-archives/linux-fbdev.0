From: Martin Kaiser <martin@kaiser.cx>
Date: Fri, 25 Nov 2016 08:43:03 +0000
Subject: Re: [PATCH] video: imxfb: correct the bitmask for DMACR_HM/_TM
Message-Id: <20161125084303.GA14156@botnar.kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479801258-3765-1-git-send-email-martin@kaiser.cx>
 <20161122084214.fxn26mfur7wwlgs2@pengutronix.de>
 <20161123093113.GA10071@botnar.kaiser.cx>
 <20161123095052.u63j26ixgc54qhkd@pengutronix.de>
In-Reply-To: <20161123095052.u63j26ixgc54qhkd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>

Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):

> > ok, understood. I wasn't able to dig up an imx1 specification. Do you
> > know if it's publicly available?

> http://www.nxp.com/assets/documents/data/en/reference-manuals/MC9328MX1RM=
.pdf

Thanks.

> So you put the values to use in the device tree? Then the right thing to
> do is to check the device type in the driver and mask accordingly when
> the values are written to the hardware.

Device tree and platform data contain the entire register, not the
individual components. The macros are provided to build the register
value from the components, but nobody's using them.

> IMHO dropping the macros is the right thing to do.

Ok, I'll submit a patch for this.

Best regards,
Martin
