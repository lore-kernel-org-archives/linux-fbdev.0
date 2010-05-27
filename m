From: Baruch Siach <baruch@tkos.co.il>
Date: Thu, 27 May 2010 04:03:29 +0000
Subject: Re: [PATCH] fbdev: fix frame buffer devices menu
Message-Id: <20100527040329.GA14841@jasper.tkos.co.il>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274896477-6832-1-git-send-email-cascardo@holoscopio.com>
In-Reply-To: <1274896477-6832-1-git-send-email-cascardo@holoscopio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>

On Wed, May 26, 2010 at 02:54:37PM -0300, Thadeu Lima de Souza Cascardo wro=
te:
> Commit f601441916d1e19291d0b4f044b4a7551e2924d0 has inserted the symbol
> HAVE_FB_IMX, which does not depend on FB after the menuconfig FB. This
> breaks the menu, presenting most of the drivers outside of it, when
> using menuconfig.
>=20
> Moving the symbol to the start of the file, just like HAVE_FB_ATMEL,
> fixes the problem without breaking it for iMX25 configurations (tested
> with ARCH=3Darm, no build).
>=20
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
