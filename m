From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Wed, 26 May 2010 19:02:15 +0000
Subject: Re: [PATCH] fbdev: fix frame buffer devices menu
Message-Id: <20100526190215.GA11764@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274896477-6832-1-git-send-email-cascardo@holoscopio.com>
In-Reply-To: <1274896477-6832-1-git-send-email-cascardo@holoscopio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Sascha Hauer <s.hauer@pengutronix.de>

Hello,

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
You're right,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
