From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Nov 2015 10:46:14 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <56543FF6.2050807@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bDhXVAa061n4fdPI335Xb2luuENHenFDH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
To: linux-fbdev@vger.kernel.org

--bDhXVAa061n4fdPI335Xb2luuENHenFDH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/11/15 08:27, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> If diu_ops is not implemented on platform, kernel will access a null
> pointer. we need to check this pointer in diu initialization.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>=20
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl=
-diu-fb.c
> index b335c1a..288b5e4 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -479,7 +479,10 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_p=
ort(const char *s)
>  			port =3D FSL_DIU_PORT_DLVDS;
>  	}
> =20
> -	return diu_ops.valid_monitor_port(port);
> +	if (diu_ops.valid_monitor_port)
> +		port =3D diu_ops.valid_monitor_port(port);
> +
> +	return port;
>  }
> =20
>  /*
> @@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device *=
pdev)
>  	unsigned int i;
>  	int ret;
> =20
> +	if (!diu_ops.set_pixel_clock)
> +		return -ENODEV;
> +
>  	data =3D dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),=

>  				   &dma_addr, GFP_DMA | __GFP_ZERO);
>  	if (!data)
>=20

Thanks, queued for 4.5.

 Tomi


--bDhXVAa061n4fdPI335Xb2luuENHenFDH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVD/2AAoJEPo9qoy8lh71AFAQAKjSJWDDKtrtzlHUcZY2vZJK
yM/FDSK4u1E53sEerUWKolyyGnSLdqT4yPd2h7mA/tWuBsngvvXvfl1P8rnfPKLo
0584A8JkRVYOruCRxhfg9uN2kCCCgdQEddJGsYwEqf1DmJCS2oq0Ybbp4svfLXQ2
5LWgKg8V3HF8a2UFRKB2Z8vmmCHEokIymx4aKfVWiHmFlpYUlwSWDdWvrrbB6xBy
NcdTMPOKpt5Ja3MVX0VU3/k1lZs3O+qPF5XHGSR7dgEhILAgbB04mS5iiYNqxymC
K/qP9QUiefCaQmNo6ZOOR0qF53pTQVanoV9mbQt6jGjr4vsgcy/vfXWQGBrjFek7
Ds4amwdRvEP5oQLl+CRU8ZlTCVvxX4iTeKpijP2Fc6bXjWvLvSnbUoloFla+pKUw
NdHX7zLax+KTkqZxv5aS5h/ugQRk/bI1xInaKL7FfHmlRar9vUIysA7CZKmNXlYz
bpJqvlECtRmQQG/fy4AtT6S95uuQmnyc9uVmbHreOCMO6wtHIkjbjkP/QdYtrqDB
sakNBQsSXnqX7/eYXLnWj6tX3mKRf3SpGXxOsLP24dGHfw/mV6eQRMep/kLLLeyZ
DWifbHE5Nhrb9URSw//zhiV6ICo4Xj5vMhCBri/rggmelaRmXzHldvKrL55GEDA8
xBkGngld73HaF+CqLdeJ
=Nn/k
-----END PGP SIGNATURE-----

--bDhXVAa061n4fdPI335Xb2luuENHenFDH--
