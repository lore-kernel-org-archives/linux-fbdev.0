From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:24:20 +0000
Subject: Re: [PATCH] video: fbdev: use msecs_to_jiffies for time conversion
Message-Id: <54E72774.1070809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9aIvQTg4auGWjAA9AoLirGUciJomuBWsI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423214041-15818-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1423214041-15818-1-git-send-email-hofrat@osadl.org>
To: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--9aIvQTg4auGWjAA9AoLirGUciJomuBWsI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/02/15 11:14, Nicholas Mc Guire wrote:
> This is only an API consolidation and should make things more readable
> it replaces var * HZ / 1000 by msecs_to_jiffies(var).
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> Patch was only compile tested with viper_defconfig (implies CONFIG_FB_P=
XA=3Dm)
>=20
> Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)
>=20
>  drivers/video/fbdev/pxafb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index da2431e..d8b4743 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -1285,7 +1285,7 @@ static int pxafb_smart_thread(void *arg)
>  		mutex_unlock(&fbi->ctrlr_lock);
> =20
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		schedule_timeout(30 * HZ / 1000);
> +		schedule_timeout(msecs_to_jiffies(30));
>  	}
> =20
>  	pr_debug("%s(): task ending\n", __func__);
> @@ -1460,7 +1460,7 @@ static void pxafb_disable_controller(struct pxafb=
_info *fbi)
>  #ifdef CONFIG_FB_PXA_SMARTPANEL
>  	if (fbi->lccr0 & LCCR0_LCDT) {
>  		wait_for_completion_timeout(&fbi->refresh_done,
> -				200 * HZ / 1000);
> +				msecs_to_jiffies(200);

That will not compile.

 Tomi



--9aIvQTg4auGWjAA9AoLirGUciJomuBWsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yd0AAoJEPo9qoy8lh717ccP/A93bXC7sKOC+FI3vasQP3mm
TXIPtDdchw6RYXtuH8d5G7smvsWBjRc5OEy9I9Qzqcgzrc0N2Mlih2D+wni/pg1R
0JEiYzpQeZco3AOQOk9L5m51RpicxXVDO24ccPjQGncZ6WijYLjNdE/iVECfC4d8
1TLRKxFD3B9CbAMEAghp6BayGK9ZgC5Dt6txGcvFq7j/rwaQeA0bMYD1P89m1KdW
eIUvV3SLSrGDHGU/jhDnAfRO86lQbjSVOD0J19fDiTiVDflOws6M/GUDOMaPV7hs
oKYPXPBMlmHhEmaFmQdU/unlNW83HatM2vEucmyJZdZ+k1bR4YFjECTa4+EvLSPI
/F9XXrog7JX2JXL505Y5t/nFz67p7XAJdbjwPZUOHydDVf8J2ELw/Y95l88e1SKN
00j3SP2ikbmdAuHrfGAWw+lqkSbbjLLT+lIXb87la+WcZxrZn/g3HOqhj6QR+qQn
zGCEgWeTZRsMkmh2NdFYDIFWa7EUWpgtI6S3Vm6S1fVXB28ZLMNXmyIMWuPXY8L4
9sLvhKdVBVMC45F+if/BmUaQM2K9O/jxbhfJuMxRaiTqlv2Jyw4c9r4vdspm5wqf
BNX3ksz/uVqwfs0erU2pPT+DD+eiNylbtJnKehEbieP+89Kff9+r7kBZ4eHOqlwF
81h+PVSfZRjCv/gG3W1B
=Tvc6
-----END PGP SIGNATURE-----

--9aIvQTg4auGWjAA9AoLirGUciJomuBWsI--
