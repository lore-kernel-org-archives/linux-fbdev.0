From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Aug 2011 21:29:05 +0000
Subject: Re: [PATCH] video/atmel_lcdfb: Fix build failure/typo for avr32 defconfig
Message-Id: <201108152329.06329.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313429190-29275-1-git-send-email-peterhuewe@gmx.de> <201108151943.08347.PeterHuewe@gmx.de> <20110815212659.GA18198@pengutronix.de>
In-Reply-To: <20110815212659.GA18198@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Peter =?iso-8859-15?q?H=FCwe?= <PeterHuewe@gmx.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday 15 August 2011 23:26:59 Wolfram Sang wrote:
> On Mon, Aug 15, 2011 at 07:43:07PM +0200, Peter H=FCwe wrote:
> > Am Montag 15 August 2011, 19:31:27 schrieb Laurent Pinchart:
> > > Thanks for the patch. I've already submitted the same patch
> > > (https://patchwork.kernel.org/patch/990792/) nearly a month ago to the
> > > linux- fbdev mailing list. Paul, can you please pick it up ?
> >=20
> > Ah okay, didn't see it. I usually look on the lkml if the problem was
> > already fixed lately but somehow missed your patch.
> >=20
> > Since you've done exactly what my patch did you get my
> > Reviewed-by: Peter Huewe <peterhuewe@gmx.de>
>=20
> This bug was spotted during the review phase, too:
>=20
> https://patchwork.kernel.org/patch/878382/
>=20
> Dunno if the wrong patch was picked up or the follow up patch never came
> around. Doesn't matter:

I've sent a v3 but v2 was picked up. I've then sent a fix on top of v2, but=
 it=20
hasn't made it through (yet).

> Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Regards,

Laurent Pinchart
