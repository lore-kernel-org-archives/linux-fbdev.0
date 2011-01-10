From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Mon, 10 Jan 2011 09:39:46 +0000
Subject: Re: [PATCH] video: imx: Update the manufacturer name
Message-Id: <20110110093946.GA24920@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294590818-5001-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1294590818-5001-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello Fabio,

On Sun, Jan 09, 2011 at 09:19:18PM -0200, Fabio Estevam wrote:
> 2011/1/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > On Sun, Jan 09, 2011 at 02:33:38PM -0200, Fabio Estevam wrote:
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >> =A0drivers/video/Kconfig | =A0 =A02 +-
> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >> index 55dc6fb..0ac30ef 100644
> >> --- a/drivers/video/Kconfig
> >> +++ b/drivers/video/Kconfig
> >> @@ -414,7 +414,7 @@ config FB_SA1100
> >> =A0 =A0 =A0 =A0 Y here.
> >>
> >> =A0config FB_IMX
> >> - =A0 =A0 tristate "Motorola i.MX LCD support"
> >> + =A0 =A0 tristate "Freescale i.MX LCD support"
> > do you have an explanation why this is wrong? =A0Was it a copy&paste
> > error? =A0If it used to be correct I'd prefer to keep Motorola in there.
>=20
> The reason is that there exists no "Motorola i.MX" anymore.
>=20
> Freescale is the company that manufactures the i.MX processors
> currently, not Motorola.
>=20
> Motorola used to manufacture i.MX devices until 2004. After the
> spin-off in 2004, Freescale continued as the i.MX manufacturer.
>=20
> Also, if you look at the first submission of the i.MX framebuffer
> driver from Sascha (imxfb: Add Freescale i.MX framebuffer driver -
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h|2f891cb64b0b9c8d389da97c221ee4288f1307)
> it contains the correct name there ,so this patch makes the driver
> selection consistent.
If you add (a maybe shortend version of) this to the commit log it would
be fine for me.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
