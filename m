From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 06 Apr 2011 18:37:31 +0000
Subject: Re: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
Message-Id: <20110406183731.GH13963@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110406173151.GA7592@nataf.siach.name>
In-Reply-To: <20110406173151.GA7592@nataf.siach.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 06, 2011 at 08:31:51PM +0300, Baruch Siach wrote:
> Hi Uwe,
>=20
> On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K=F6nig wrote:
> > All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> > so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> > depend on ARCH_MX1 or ARCH_MX2.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
>=20
> Sascha has already sent a patch for this. See=20
> http://article.gmane.org/gmane.linux.ports.arm.kernel/109067.
yeah, this looks more complete. Thanks for pointing that out.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
