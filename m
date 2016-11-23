From: Martin Kaiser <martin@kaiser.cx>
Date: Wed, 23 Nov 2016 09:31:13 +0000
Subject: Re: [PATCH] video: imxfb: correct the bitmask for DMACR_HM/_TM
Message-Id: <20161123093113.GA10071@botnar.kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479801258-3765-1-git-send-email-martin@kaiser.cx>
 <20161122084214.fxn26mfur7wwlgs2@pengutronix.de>
In-Reply-To: <20161122084214.fxn26mfur7wwlgs2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Uwe, all,

Thus wrote Uwe Kleine-K=F6nig (u.kleine-koenig@pengutronix.de):

> For the MX1 which is also supported by this driver, the definitions are
> right.

ok, understood. I wasn't able to dig up an imx1 specification. Do you
know if it's publicly available?

> So this needs a more sophisticated patch. Also I wonder why the
> register definition is in include/linux/platform_data and not in the
> driver directly.

The DMACR_HM() and _TM() macros are meant to be used when we initialize
imx_fb_platform_data's dmacr component for a platform device. It's not
straightforward to distinguish between imx1 and imx21 at initialization
time.

We could modify imx_fb_platform_data to use different components for
dmacr_burst, dmacr_hm, dmacr_tm and calculate the dmacr register value
in the driver where is_imx1_fb() is available. Device tree is also using
a single dmacr entry, it's probably not a good idea to do this
differently for platform devices...

We could also define DMACR_HM_IMX1(), DMACR_HM_IMX21(), ...

Or we could just remove the macros, they are not used by any boards in
the mainline kernel. If we don't want to break proprietary board
definitions, we could at least add a comment that the macros are
incorrect for imx21.

Thoughts?

Best regards,
Martin
