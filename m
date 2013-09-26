From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 10:35:54 +0000
Subject: Re: [PATCH 01/15] video: atmel_lcdfb: Remove redundant dev_set_drvdata
Message-Id: <52440E0A.8080609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pq9Pp0nXg9Rh7gA4Icj3cKw8CUPebt4KP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379658744-17113-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379658744-17113-2-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--pq9Pp0nXg9Rh7gA4Icj3cKw8CUPebt4KP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 09:32, Sachin Kamat wrote:
> Driver core sets driver data to NULL upon failure or remove.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/atmel_lcdfb.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 34e934d..70052e7 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -1318,7 +1318,6 @@ static int __init atmel_lcdfb_probe(struct platfo=
rm_device *pdev)
>  	return 0;
> =20
>  reset_drvdata:
> -	dev_set_drvdata(dev, NULL);
>  	fb_dealloc_cmap(&info->cmap);
>  unregister_irqs:
>  	cancel_work_sync(&sinfo->task);
> @@ -1379,7 +1378,6 @@ static int __exit atmel_lcdfb_remove(struct platf=
orm_device *pdev)
>  		atmel_lcdfb_free_video_memory(sinfo);
>  	}
> =20
> -	dev_set_drvdata(dev, NULL);
>  	framebuffer_release(info);
> =20
>  	return 0;
>=20

I had to modify this one as follows. Are you fine with it?

commit 8d84d1223dbbaceb5cbf25b597e48a59c36b8c91
Author: Sachin Kamat <sachin.kamat@linaro.org>
Date:   Fri Sep 20 12:02:10 2013 +0530

    video: atmel_lcdfb: Remove redundant dev_set_drvdata
   =20
    Driver core sets driver data to NULL upon failure or remove.
   =20
    Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
    Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index df05550..3f7d6dc 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1089,7 +1089,7 @@ static int __init atmel_lcdfb_probe(struct platform=
_device *pdev)
 	ret =3D register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(dev, "failed to register framebuffer device: %d\n", ret);
-		goto reset_drvdata;
+		goto free_cmap;
 	}
=20
 	/* add selected videomode to modelist */
@@ -1105,8 +1105,6 @@ static int __init atmel_lcdfb_probe(struct platform=
_device *pdev)
=20
 	return 0;
=20
-reset_drvdata:
-	dev_set_drvdata(dev, NULL);
 free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 unregister_irqs:
@@ -1167,7 +1165,6 @@ static int __exit atmel_lcdfb_remove(struct platfor=
m_device *pdev)
 		atmel_lcdfb_free_video_memory(sinfo);
 	}
=20
-	dev_set_drvdata(dev, NULL);
 	framebuffer_release(info);
=20
 	return 0;



--pq9Pp0nXg9Rh7gA4Icj3cKw8CUPebt4KP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRA4KAAoJEPo9qoy8lh71k4EP/AvFU3Wi08dRoYdySK7Ivvab
MQtnpoJFYy7lNOBN1nMw0Gtnt3h15IQo1QyHhQ3wr7dUZP6q9BsujvLDWq+yRDK/
RmmDML0+LVQyQT/Bv5zbDJ3gGonfPfpd4v3iCjgAmzXV3q7/sHSlAJbL0JBNvFaU
b0+GRioEU+Zc6dgzn5Yo1N29im9Iz1MhuH54oHjG89oAfR1PSip0gL6NUZRrcn4k
gOa9K3/6xpL8Spi6lpmXVeyBgl+EmAqlB1qpm3gM0l/jEXXQFyfLFekPhwi8u+A9
3zaYGH+Ti1jOM50aumlWoHZlI1Wx9tYxow3CRfx+AmZc8pkMB92b3SP86qOBtXwR
4Y8KZmO1ieOFVp/x4z8a0yjNJuzGJTDAahgLOtt3F+3++BL06MZzUkwKGJ9exlbN
ot17g/GrYDpYSP/8CDFFhZYk76zpZo9245M33Z4q0ru3VV3vb+R0T5wdDY6Xl4Je
vsNM6n+LfUWXdLAEHRO9O2Pw8G55kzlOe8C7JGKA5eejh3Pr1mb2f7pNB9Qnw3wb
syKfxgxaihP2GiSnsoD3ZTYyMv2/sxzK9IJdZlIbmL7xyEHSdYz6RqodWm5SBrfI
yUcedMRzZx5hOzB6m0dYy9O6jMn6vbprQ/+BV7HkxYYA7opw+oaK2vHYWwGyr2sl
O/vCZ+Z4SpbUSaqj/lNI
=ModF
-----END PGP SIGNATURE-----

--pq9Pp0nXg9Rh7gA4Icj3cKw8CUPebt4KP--
