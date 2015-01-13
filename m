From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 11:43:43 +0000
Subject: Re: [PATCH 2/2] fbdev: ssd1307fb: check return value while setting offset
Message-Id: <54B504EF.4000809@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SgxtnFdlnkLLVHcgB9cb0tTaHKiLItvp3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420705079-3741-1-git-send-email-prabhakar.csengg@gmail.com> <1420705079-3741-3-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1420705079-3741-3-git-send-email-prabhakar.csengg@gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>

--SgxtnFdlnkLLVHcgB9cb0tTaHKiLItvp3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/01/15 10:17, Lad, Prabhakar wrote:
> this patch checks the return value of write command while
> setting the display offset.
>=20
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index 70e3ce8..a7ecaa6 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -342,7 +342,7 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_=
par *par)
> =20
>  	/* set display offset value */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_SET_DISPLAY_OFFSET=
);
> -	ret =3D ssd1307fb_write_cmd(par->client, 0x20);
> +	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x20);
>  	if (ret < 0)
>  		return ret;

Hrm, what's that supposed to do? If both calls to ssd1307fb_write_cmd()
return an error, they are anded, resulting in a garbage error code...

 Tomi



--SgxtnFdlnkLLVHcgB9cb0tTaHKiLItvp3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQTvAAoJEPo9qoy8lh718tIQAIRmfycemgx9Wd6ps2UMP//L
yym+wjko7E4MbmxA7ReqUdvngSCOivMaps71EQRzysorqnZD5HUSw1TOthbCEZi2
+h0npkW3yMKhNgU7lc8M5liG0VehCnTNYSc0ME023N0dbjJkh/CNBv/y/XjHKCmu
qYZLmmVldUWT8MLFNN3u5ij/mTOmznCKyfOM8GivQp234NDQfQ81oyeOsxiZ0zt6
lAsPa0odUyI2ZC+ZSecbG0dcC1218Hc0wQZ0h2L9wjXNtOPXRhZrR4vMu6+ZTb68
+67rzlPzZ2mcVLOcF+i0CO2nVSldy9hxLm2AKe3jQqWpfEqPA2guY6xbOKeC8RSp
U8IrZ2j9Rb7DhfSE16RyoGfA1aUzQAVfQIxFZvnfo/rV5VBjWlZ6ePD7V8Ms+hdk
uNNYMz+8BPdm+eIQuQoik5UOwcpHTLDS3idXRzk7tPs9WAU4h4dMd/BgmVMlIGC4
DVWUGoCiLu29fHvVV2oJhyjXcC8HsmluOCRO1moAT2A5zF7BRZLyzJNO1LPIemC+
MT3crZ2b8jbYtoRgq9zeJeemndZErevjPIYRTWar2ABz6JlHyAR33wtvGBzC2t1E
RxmuXV+M1eQ9UFgd5BWe6+8GWPtSIxt55x6FBUWQu5bRLbxJQ1NXHerVeh9MHpdD
6BC5EvhCjzNkh85NFtpz
=iq+G
-----END PGP SIGNATURE-----

--SgxtnFdlnkLLVHcgB9cb0tTaHKiLItvp3--
