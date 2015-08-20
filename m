From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 10:55:46 +0000
Subject: Re: [PATCH v1, TRIVIAL] Fix pxafb nonstd field documentation and add errata info
Message-Id: <55D5B232.9090006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GrQ3twevuHkPpEcKJT75SqPONxb2of19w"
List-Id: <linux-fbdev.vger.kernel.org>
References: <55C64864.6070405@tul.cz>
In-Reply-To: <55C64864.6070405@tul.cz>
To: linux-arm-kernel@lists.infradead.org

--GrQ3twevuHkPpEcKJT75SqPONxb2of19w
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 08/08/15 21:20, Petr Cvek wrote:

> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2d98de5..8f485ec 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1893,6 +1893,11 @@ config FB_PXA_OVERLAY
>  	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
>  	default n
>  	depends on FB_PXA && (PXA27x || PXA3xx)
> +	---help---
> +	  Using the overlay 2 and YUV420 mode on a PXA27x C0 chip revision wi=
ll
> +	  hang the LCD until the next SoC restart (errata E24).

Shouldn't the driver handle this? It should not allow the combination to
be used.

 Tomi


--GrQ3twevuHkPpEcKJT75SqPONxb2of19w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1bIyAAoJEPo9qoy8lh71R9sQAII2h9HFBSfThSAwRTTtoyMS
KPqTeeuP1+08FO+MevjtY6+tjVFFLTXsOGpXsbxd9dkLKvSRMJVwvceLcLas55Jm
sHfbuib3q9PyI/EL9zv5X9UFh2ihVBppPSMQFWaj6AzKHkJDMVBpOMvP3geDC8O3
jG4SqvxMmReNJRD9sNKtI6Dwei72uGc7NN9Pwz5bNtBZhi7QaRX77fqkc3p1jXgT
klrmjmlB089mSSpgmkcT4BqvXnEHnDJyXpb7GEXQsNXTsrjg/NDXZTlSMYgx8LTK
/+hSoFVBULWD+LU/5/zkSg3KNf6oDo7xSUg6/69KsL3FqSNehb7JD/6rCNSf8zIt
twj6YPZxSDpLWISUmcUoo/oF5p5aqglMZ6BPwskPQlF06jPwSga54+yWgm9Dzy8R
kYUwktYZw++XVI9smVS+WYMn/puUMB/MKGFFo1xbZ7MmTd1n2/onBrqHn+EPYo5C
/IkAi+kdJFZC/E+U0qcg4fJhjq5VCC2Cc3wEo0ZHC2l4OWodZ08dHH8Mj22vDFYo
cLx0cVYEtq731RAmw9dBgCmpIR/Fq2l4AzreYsY8/lAZ58mvUnkInScAwWV7m7R8
MJn8rU4lqQ2S6BkqwcUjO7xIky4dXwnP4PlyAVPVgzdgRi6IFtEk8VSDATNluDjN
4haTW9npIs60LqG5pwef
=zDst
-----END PGP SIGNATURE-----

--GrQ3twevuHkPpEcKJT75SqPONxb2of19w--
