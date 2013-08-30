From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 07:21:52 +0000
Subject: Re: [PATCH] drivers: video: i740fb: add 'default' processing contents for 'switch'.
Message-Id: <52204810.6020504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NutCEBgq74t59BkbfNVw5r4boIEvbJcNw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <51ECF12D.8060903@asianux.com>
In-Reply-To: <51ECF12D.8060903@asianux.com>
To: linux-fbdev@vger.kernel.org

--NutCEBgq74t59BkbfNVw5r4boIEvbJcNw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22/07/13 11:45, Chen Gang wrote:
> Need add related 'default' processing contents for 'switch', or may
> report 'wm' uninitialized warning.
>=20
> The related warning:
>=20
>   drivers/video/i740fb.c:662:26: warning: =91wm=92 may be used uninitia=
lized in this function [-Wmaybe-uninitialized]
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/video/i740fb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/i740fb.c b/drivers/video/i740fb.c
> index 6c48388..e82e767 100644
> --- a/drivers/video/i740fb.c
> +++ b/drivers/video/i740fb.c
> @@ -336,6 +336,9 @@ static u32 i740_calc_fifo(struct i740fb_par *par, u=
32 freq, int bpp)
>  				wm =3D 0x16110000;
>  		}
>  		break;
> +	default:
> +		wm =3D 0;
> +		BUG();
>  	}

I don't think you should use BUG there. BUG should be used when there's
not really a good way to continue. Here you could have just a WARN, and
return some default FIFO watermark value.

 Tomi



--NutCEBgq74t59BkbfNVw5r4boIEvbJcNw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIEgQAAoJEPo9qoy8lh71u+QP/2EPaZDtXcr6WnBmsby7mfed
SgI+pkaFj8gUGBqz7JVYlsfeIU9ktVX5V1zv6C+GvYxHTuLoIUBPeZAgzloqTMoI
m5Z+26PpK5sa5QOb9ca2LQK10Eb4jMnA0TgykRMBIv0RdeYZB8CKlYP4bhKJF9NO
bT9ltnxyQ0lTYsuev1nVpgTXew8dpLrdhE2fji7ZjybZdofnoN7TnDoYw0WRZDGy
4yslt2E7nk5pBPIvu1oOBS1L1ENaQR3QA+4xBvsBG+nsX2VBsGszpXhDOI/OFL6M
eIHcdZJW9j5PqRJ7gfB987gol1GlZ1t0FL6G2+rUA6bNyz4gw/ns3Vf5WohF+5Jo
tNL99XwpZBZCnm4yeraIz0oJocvZXa5Otif3xb3QyStVUzBoDG5SNa2ek1yalmae
+VzYBs2k3AeNSqUGdXmVBba8gqK1y7ncIeb33X4jL1wLwnECjFRDgaXhrBBbAYvb
drPuavaG0GzeVCKkccpIpYI/Q+RC21kDAZTqRvW27Hnc2wCcrBVU6f5UqFyaqNr3
Xpz14P3V7oYdFjRpHsGI5yNGgMp7keTfQBOrdj6irDFuSDktn8wN7bN72JMFKkfr
pcMy5gJULdyPKuk6SCCLSxdxq8DZQOcrF5D3tqiuxPL8FCDgBmdr4gV43WoM1QXl
72E8++uIIjEOXbrApU0/
=yuo4
-----END PGP SIGNATURE-----

--NutCEBgq74t59BkbfNVw5r4boIEvbJcNw--
