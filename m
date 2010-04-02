From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Fri, 02 Apr 2010 18:10:21 +0000
Subject: Re: [PATCH v2 1/5] fbdev: section cleanup in arcfb
Message-Id: <20100402181020.GA1834@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1270209574-31890-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1270209574-31890-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Hendrik,

[added stable@kernel.org to Cc: as
c2e13037e6794bd0d9de3f9ecabf5615f15c160b was requested to be added, too]

The whole series looks good
(aka. Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>).

On Fri, Apr 02, 2010 at 01:59:30PM +0200, Henrik Kretzschmar wrote:
> This patch fixes the sections in the arcfb driver, by moving:
>=20
> *	the variables arcfb_fix and arcfb_var from .init.data to .devinit.data
>=20
> *	arcfb_remove() from .text to .devexit.text

Maybe add: "This fixes the following warnings issued by modpost:" here?

Thanks
Uwe

> WARNING: drivers/video/built-in.o(.devinit.text+0x543): Section mismatch =
in reference from the function arcfb_probe() to the variable .init.data:arc=
fb_var
> The function __devinit arcfb_probe() references
> a variable __initdata arcfb_var.
> If arcfb_var is only used by arcfb_probe then
> annotate arcfb_var with a matching annotation.
>=20
> WARNING: drivers/video/built-in.o(.devinit.text+0x558): Section mismatch =
in reference from the function arcfb_probe() to the variable .init.data:arc=
fb_fix
> The function __devinit arcfb_probe() references
> a variable __initdata arcfb_fix.
> If arcfb_fix is only used by arcfb_probe then
> annotate arcfb_fix with a matching annotation.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
