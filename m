From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Nov 2016 08:34:00 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
Message-Id: <f95e05ef-e8e0-c5f4-9635-ae392c1812a3@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1OQagS6A7P9p0H2p2xherdwPoqfknN8Hg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--1OQagS6A7P9p0H2p2xherdwPoqfknN8Hg
Content-Type: multipart/mixed; boundary="d1mEsk97ApILrpClL8IQcuu3GTFWVbLJq";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Amit Pundir <amit.pundir@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Message-ID: <f95e05ef-e8e0-c5f4-9635-ae392c1812a3@ti.com>
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>

--d1mEsk97ApILrpClL8IQcuu3GTFWVbLJq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/10/16 09:46, Linus Walleij wrote:
> The CLCD does not come up on Versatile Express as it does not
> (currently) have a syscon node for controlling the block apart
> from the CLCD itself. Make sure the .init() function can bail
> out without an error making it probe again.
>=20
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/=
fbdev/amba-clcd-versatile.c
> index 19ad8645d93c..d909b7dda14d 100644
> --- a/drivers/video/fbdev/amba-clcd-versatile.c
> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
> @@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>  					     &clcd_id);
>  	if (!np) {
>  		dev_err(dev, "no Versatile syscon node\n");
> -		return -ENODEV;
> +		/* Vexpress does not have this */
> +		return 0;
>  	}
>  	versatile_clcd_type =3D (enum versatile_clcd)clcd_id->data;

Actually, the above doesn't look correct. If this is not an error, then
the driver shouldn't print an error.

Shall I just remove the print?

 Tomi


--d1mEsk97ApILrpClL8IQcuu3GTFWVbLJq--

--1OQagS6A7P9p0H2p2xherdwPoqfknN8Hg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYGaT4AAoJEPo9qoy8lh71CxQP/RbMfiPrXb1OvXWpYD+0vvCZ
o9L/Rs9D6HumtlH8VmfPlJGk59FbYYvuG2KemQQCuIDQ3DF9JJ95WRCtkX+50mBC
SOEpOm0pENCWisMEFDH3BJyIHP7XaYmiO5SGmRYPd9tgUi8ERHWtlMgOawoEBiOs
4Tr1FScw84WH+CoeatWgAIisWSsBYBZKQsGwQVEn2+3ZTIG5T1OloMndFbbiytE6
o71pzguWJB3wMI0CXBE0pLJHsRfbwGQVDyAO0UyPCtEiP5pQ8qVPLz8wzOr1eMwj
5K2q59DepIQyWcTSn0elSGHo0X0GWzCqOLnjx8V0L5bKD1ff1loaO8rg/tZFGP69
NMhnKFZbQ2hGNGtB96e/5LK8aZAwWopvlR0VCj19cd2cUkpO3E/deFzbtJR+ILXy
brcziXyfFQFy34eF/V/PBOCDJkWyiOK4+fSMFfow+b/CDl+6pT/Ap1WvqtJ3MOAE
4DnSY95mgAzr9hi7i8nf7qhv3RXVLqL2rekFD9q6JV284MDoZdFUYfDgxh9T2RCm
0qwIElU9MnmRXxN2/lC4Q2Zv4DcdkB/BFoTbBqBzwPYnFsdwcdG30zIzYgOenSGP
amRjkctx619dh5rLHe1k3YihqBZqRtOj9TTPbmOss1qpw8QEMBooYHLj2aHghuvH
+chR4oIRDFBAYjtGxmUa
=pESn
-----END PGP SIGNATURE-----

--1OQagS6A7P9p0H2p2xherdwPoqfknN8Hg--
