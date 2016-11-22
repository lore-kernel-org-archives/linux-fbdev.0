From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 22 Nov 2016 08:42:14 +0000
Subject: Re: [PATCH] video: imxfb: correct the bitmask for DMACR_HM/_TM
Message-Id: <20161122084214.fxn26mfur7wwlgs2@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479801258-3765-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1479801258-3765-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Martin Kaiser <martin@kaiser.cx>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 22, 2016 at 08:54:18AM +0100, Martin Kaiser wrote:
> The HM and TM fields in the LCDC DMA Control Register are 7 bits wide.
> Use the correct mask to allow setting all possible bits.
>=20
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>=20
> This bug was discovered on a board that uses DMACR_TM(16). We ended up
> with TM=3D0 in the register, the upper three bits were filtered out.
>=20
> The LCD DMA Control Register is described in section 33.3.16 of the
> IMX25 reference manual.

For the MX1 which is also supported by this driver, the definitions are
right. So this needs a more sophisticated patch. Also I wonder why the
register definition is in include/linux/platform_data and not in the
driver directly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
