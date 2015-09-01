From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Sep 2015 10:39:55 +0000
Subject: Re: [PATCH 04/11] fbdev: ssd1307fb: fix error return code
Message-Id: <55E5807B.1020505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WQjJdL9WnSuKeIGk6MMGVIcFRFVxTwPSu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
 <1440288682-12732-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1440288682-12732-5-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--WQjJdL9WnSuKeIGk6MMGVIcFRFVxTwPSu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 23/08/15 03:11, Julia Lawall wrote:
> Propagate error code on failure.  Also changed %ld to %d in dev_err to =
use
> ret variable rather than putting two calls to PTR_ERR.
>=20
> A simplified version of the semantic match that finds the first problem=
 is as
> follows: (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> identifier ret; expression e1,e2;
> @@
> (
> if (\(ret < 0\|ret !=3D 0\))
>  { ... return ret; }
> |
> ret =3D 0
> )
> ... when !=3D ret =3D e1
>     when !=3D &ret
> *if(...)
> {
>   ... when !=3D ret =3D e2
>       when forall
>  return ret;
> }
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/video/fbdev/ssd1307fb.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1=
307fb.c
> index 3e153c0..1611215 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -656,8 +656,9 @@ static int ssd1307fb_probe(struct i2c_client *clien=
t,
>  	bl =3D backlight_device_register(bl_name, &client->dev, par,
>  				       &ssd1307fb_bl_ops, NULL);
>  	if (IS_ERR(bl)) {
> -		dev_err(&client->dev, "unable to register backlight device: %ld\n",
> -			PTR_ERR(bl));
> +		ret =3D PTR_ERR(bl);
> +		dev_err(&client->dev, "unable to register backlight device: %d\n",
> +			ret);
>  		goto bl_init_error;
>  	}

Thanks, queued for 4.3.

 Tomi


--WQjJdL9WnSuKeIGk6MMGVIcFRFVxTwPSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5YB7AAoJEPo9qoy8lh714U4P/ipuS1aXhcDcCZ1RVDE2aJiX
QD0ndvGgMDILPtp3VcWflI73LpIM+v6fPvSgZt3DYBADm1Rh6ur1Jt4AFVu4LJBF
hcpzZqqd1+NdVpzETLWJrXBf+wTxD0zjjYuirU0S5KjANgxmajxqwBw02IEtLkuD
tlEJiZzdPq0YZhim28FD5f+HF9vsafvn5+gRst5kgqMiVuZNqwbYRJtDLCaK933H
BBRTjLMdRf4KDhj2OYNIO8h17GROQwlPL26CPxf2X+bqXOO4cmVonaRAgdMbrT7D
3sCTBPbMUL5YjEnKDW/cctHNqWNslcEwohdMPxJoWvKsqGyGqGxwfRgG1OHnjS9n
8zClGfxOv1BWq6Sc3B1iQMboENcx0tEFl5RVgO+KQdLPAgO48jo9hg/OZm7gB+U6
ZHwShR+AV272EC9j2s95KgBnbbMBCut7rfx5jcPdsZfOJ0NytoAAbbkmWKYB42qm
6CIMygCJydte+oar55ZS656525xIsQtIGWsAzNlZnsT4hD/BWVNpqesmyhnfxHHZ
6t38+9aN9qPTNJYRgGXRMCt05ah0CBo8e/ginniAqGEiDmoqYIbKcHIgWqKfrhfd
Vp0prTTZZJ6JyICSs66OeNJ+Xzrn6td2D7rINtSRKpqHFSbYcbMuUdlvSUuc7y1l
qLtn8zzPjgtg696lo5g4
=9Ed+
-----END PGP SIGNATURE-----

--WQjJdL9WnSuKeIGk6MMGVIcFRFVxTwPSu--
