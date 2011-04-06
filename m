From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 06 Apr 2011 18:40:22 +0000
Subject: Re: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
Message-Id: <20110406184022.GI13963@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110406163805.GA11820@linux-sh.org>
In-Reply-To: <20110406163805.GA11820@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 07, 2011 at 01:38:13AM +0900, Paul Mundt wrote:
> On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K??nig wrote:
> > All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> > so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> > depend on ARCH_MX1 or ARCH_MX2.
> >=20
> > Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > should this go via Sascha's or Paul's tree?
> >=20
> There shouldn't be anything it conflicts with in my tree, so it can go
> via either. Most of the imx changes have bypassed the fbdev tree, so I'm
> unaware if there are outstanding patches in Sascha's tree at the moment
> or not. I can of course take it though.
I currently collect imx patches for Sascha because he is busy doing
other stuff.  Can I have your ack for the patch that Baruch pointed out?
Then I'd take it for the imx tree.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
