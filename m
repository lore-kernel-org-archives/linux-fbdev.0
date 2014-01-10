From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:29:34 +0000
Subject: Re: [patch 1/2] video: mmp: delete a stray mutex_unlock()
Message-Id: <52CFD99E.1020108@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HntG3obQBVBbU3e4mA9oAn6hXuTFFhnl4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131114081918.GB8150@elgon.mountain>
In-Reply-To: <20131114081918.GB8150@elgon.mountain>
To: linux-fbdev@vger.kernel.org

--HntG3obQBVBbU3e4mA9oAn6hXuTFFhnl4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-14 10:19, Dan Carpenter wrote:
> We aren't holding the disp_lock so we shouldn't release it.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/mmp/core.c b/drivers/video/mmp/core.c
> index 84de263..c8d4265 100644
> --- a/drivers/video/mmp/core.c
> +++ b/drivers/video/mmp/core.c
> @@ -173,7 +173,7 @@ struct mmp_path *mmp_register_path(struct mmp_path_=
info *info)
>  		+ sizeof(struct mmp_overlay) * info->overlay_num;
>  	path =3D kzalloc(size, GFP_KERNEL);
>  	if (!path)
> -		goto failed;
> +		return NULL;
> =20
>  	/* path set */
>  	mutex_init(&path->access_ok);
> @@ -219,11 +219,6 @@ struct mmp_path *mmp_register_path(struct mmp_path=
_info *info)
> =20
>  	mutex_unlock(&disp_lock);
>  	return path;
> -
> -failed:
> -	kfree(path);
> -	mutex_unlock(&disp_lock);
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(mmp_register_path);
> =20
>=20

Queued for 3.14.

 Tomi



--HntG3obQBVBbU3e4mA9oAn6hXuTFFhnl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9meAAoJEPo9qoy8lh71flgQAKpX0aVdTKKyp04sZY31bWSi
kBIezgGiyL/Li6JSBEqueabolWh29TRrNkQHXSD/hddq10BaDewSyHCKYlMbQvda
QpjFECOFCCsO8JI/MWNy0Euhv16sUV82UPoNdLDaGBBk8LOZKoGPeK7j6c0px854
TVnzVQ04jJ7i3sWXBrIbrr47KHUgVQs4HeBH6186n3TZBUyOOUHEmhbBx+sloNN7
wcXxdsb0/byYoV6bpGxKteQ+/pB19RdSuWpfu5pO3NzNiplrNGVaeK3PD/3jC/P4
IgoZUcOfuCFWUNJfx+GXkJsBd5cTI8HE5nX2LCg3Xv0vhO2ohtcdHMNRTbBI8tyN
1CQquAkXWjthLEWQtzsmkDupcapGIUrgxD1fUZVwqez49dKUPhuKTCvLg8BXnANf
nh+EiayCqyl2AIQAFIMx30BDqqAs5E/YnIt/bl6JAyJOFheqv/oFqlDGfhpqxNu8
pCEBTD+5fo0cKzKhLRMmHLXU0Obb5wO7i9m9xMv8z5lRGm4HNkDD5JyN0J9YKeIN
WVpw6xHUOibRRzU4T2vLY42wxqczufpeJO1jS78wAKVfk5fkrTXgTVl+3omYbcrD
hs21YV+3O3GHsPNyeFgzitfc9RWqNf5QhLR81rdbdbK45O8NT9PmaueCbJwSaA40
065Nb5QEXDAaCCusLLbY
=57m4
-----END PGP SIGNATURE-----

--HntG3obQBVBbU3e4mA9oAn6hXuTFFhnl4--
