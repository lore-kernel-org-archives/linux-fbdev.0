From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 15 Apr 2013 19:47:38 +0000
Subject: Re: [PATCH v3 2/2] video: imxfb: Add DT support
Message-Id: <20130415194738.GE1906@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365157876-1757-1-git-send-email-mpa@pengutronix.de>
 <1365157876-1757-3-git-send-email-mpa@pengutronix.de>
 <20130408075742.GR20693@game.jcrosoft.org>
 <20130414143132.GD27394@pengutronix.de>
 <20130415124321.GB15139@game.jcrosoft.org>
 <20130415151316.4d49e9b2@e6520eb>
In-Reply-To: <20130415151316.4d49e9b2@e6520eb>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 15, 2013 at 03:13:16PM +0200, Eric B=E9nard wrote:
> Hi,
>=20
>=20
> I didn't follow the thread but dmacr is not specific to our boards :
> $ grep -rn dmacr arch/arm/mach-imx/
> arch/arm/mach-imx/mach-mx27_3ds.c:446:	.dmacr		=3D 0x00020010,
> arch/arm/mach-imx/mach-mx21ads.c:231:	.dmacr		=3D 0x00020008,
> arch/arm/mach-imx/mach-mxt_td60.c:210:	.dmacr		=3D 0x00020010,
> arch/arm/mach-imx/eukrea_mbimx27-baseboard.c:192:	.dmacr		=3D 0x00040060,
> arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c:165:	.dmacr		=3D 0x0004006=
0,
> arch/arm/mach-imx/mach-mx27ads.c:241:	.dmacr		=3D 0x00020010,
> arch/arm/mach-imx/mach-pca100.c:351:	.dmacr		=3D 0x00020010,
> arch/arm/mach-imx/pcm970-baseboard.c:185:	.dmacr		=3D 0x00020010,
> arch/arm/mach-imx/mach-mx25_3ds.c:173:	.dmacr		=3D 0x00020010,

The reference manual has this about the dmacr register:

The dynamic mode is recommend, and also the TM and HM reset value are
recommend in the dynamic mode. The same recommendation is for the
graphic DMA control.

So maybe we should ask whether the boards really have to change this
value or if the reset value is suitable for all.

Sascha

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
