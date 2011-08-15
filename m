From: Wolfram Sang <w.sang@pengutronix.de>
Date: Mon, 15 Aug 2011 21:26:59 +0000
Subject: Re: [PATCH] video/atmel_lcdfb: Fix build failure/typo for avr32
Message-Id: <20110815212659.GA18198@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313429190-29275-1-git-send-email-peterhuewe@gmx.de>
 <201108151931.27607.laurent.pinchart@ideasonboard.com>
 <201108151943.08347.PeterHuewe@gmx.de>
In-Reply-To: <201108151943.08347.PeterHuewe@gmx.de>
To: Peter =?iso-8859-15?Q?H=FCwe?= <PeterHuewe@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2011 at 07:43:07PM +0200, Peter H=FCwe wrote:
> Am Montag 15 August 2011, 19:31:27 schrieb Laurent Pinchart:
> > Thanks for the patch. I've already submitted the same patch
> > (https://patchwork.kernel.org/patch/990792/) nearly a month ago to the
> > linux- fbdev mailing list. Paul, can you please pick it up ?
>=20
> Ah okay, didn't see it. I usually look on the lkml if the problem was alr=
eady=20
> fixed lately but somehow missed your patch.
>=20
> Since you've done exactly what my patch did you get my=20
> Reviewed-by: Peter Huewe <peterhuewe@gmx.de>

This bug was spotted during the review phase, too:

https://patchwork.kernel.org/patch/878382/

Dunno if the wrong patch was picked up or the follow up patch never came ar=
ound.
Doesn't matter:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5JjyMACgkQD27XaX1/VRvG2ACeMJPv7Le8EpjUYxqDtAEJSh6G
N+sAoIi5n0uGTWQTQVTKdfb3f/tN5dn+
=3LSh
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
