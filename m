From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Sat, 27 Mar 2010 14:21:13 +0000
Subject: Re: [PATCH 1/7] fbdev: section cleanup in arcfb
Message-Id: <20100327142113.GB15267@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1269671092-19948-1-git-send-email-henne@nachtwindheim.de>
In-Reply-To: <1269671092-19948-1-git-send-email-henne@nachtwindheim.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Henrik Kretzschmar <henne@nachtwindheim.de>
Cc: linux-fbdev@vger.kernel.org, Jaya Kumar <jayalk@intworks.biz>, Arnaud Patard <arnaud.patard@rtp-net.org>, James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org

On Sat, Mar 27, 2010 at 07:24:45AM +0100, Henrik Kretzschmar wrote:
> This patch fixes the sections in the arcfb driver.
>=20
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

... by moving arcfb_fix and arcfb_var to .devinit.data

Addionally it moves arcfb_remove to .devexit.text.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
