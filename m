From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:14:50 +0000
Subject: Re: [PATCH 04/26] matroxfb: constify local structures
Message-Id: <96950836-f512-c5fb-237f-3e1502764c1f@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="I6aGG9uGp4vcTTALtWXeBMVAQ9f2OtiH4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
 <1473599168-30561-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1473599168-30561-5-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--I6aGG9uGp4vcTTALtWXeBMVAQ9f2OtiH4
Content-Type: multipart/mixed; boundary="Gw50jiK0iI36FOs2AdHOgeiFWcdEXlGTm";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <96950836-f512-c5fb-237f-3e1502764c1f@ti.com>
Subject: Re: [PATCH 04/26] matroxfb: constify local structures
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
 <1473599168-30561-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1473599168-30561-5-git-send-email-Julia.Lawall@lip6.fr>

--Gw50jiK0iI36FOs2AdHOgeiFWcdEXlGTm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/16 16:05, Julia Lawall wrote:
> For structure types defined in the same file or local header files, fin=
d
> top-level static structure declarations that have the following
> properties:
> 1. Never reassigned.
> 2. Address never taken
> 3. Not passed to a top-level macro call
> 4. No pointer or array-typed field passed to a function or stored in a
> variable.
> Declare structures having all of these properties as const.
>=20
> Done using Coccinelle.
> Based on a suggestion by Joe Perches <joe@perches.com>.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
> The semantic patch seems too long for a commit log, but is in the cover=

> letter.
>=20
>  drivers/video/fbdev/matrox/matroxfb_g450.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued for 4.9.

 Tomi



--Gw50jiK0iI36FOs2AdHOgeiFWcdEXlGTm--

--I6aGG9uGp4vcTTALtWXeBMVAQ9f2OtiH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6ip6AAoJEPo9qoy8lh71vKgP/1i/MGtFPlAGlf+cx/7zNkkf
p7x70/UuQYkYwkDFrd9VpArEIB81h6l8zqhJ37uFg8mBcM9/YY3RCBhaspfCUEOP
uhz7Vgj12zJ5KIU6ElKrIor8dyyIwLsRO3FhsFy9S/lLfyXsqrlQzLyImISaH3Sc
najBlANAgEj+SeX05i1ZTpwVtzeoMWYdnxkXHjXoEaTUV5TUUhm18YeE85EQbqIL
KcaUWZm0I+rHHazHyBXKZ+cZeAUVtQk2kX9OXin4Y55al1GukD8v+mb6SlzZJQrd
e2rIon3XbY5GnpYj7uSKFWGE+EQWswsyVGWtqj2CVFSNdYK15MaqFq3UyoTGEyy0
JP1nMhCqsW3AMJ2a6Dm1ElKlotqUOvuUHOji24nPb1t0fBncqikrtBuo6C9W31kg
tMVDCiViIIgmbtjjrsDfhuWgWTNp3Xidb3jKlQdF0GmPiuyQRpwpuZIrXnJRM/A+
menWcQA4JZsgWrg7i+sJ0TusSvHMKjpE0ibTRN5OjGk9F6+iQa+oEqtUE+RNewuv
cxtMvLPtDVX5EcsRBtphgFYF8UzgoooR1AF9VJ2bET4+UDVJmi5P2quHdiLXAzLd
RLDj2Y4FueMHM5KZIWAAUkAQO7ZoZ+tjD1PoFS2WUVjQp+wtGBoFVnHSLIk//F1A
KbywoxsyC8AuEDB2me5g
=GIgV
-----END PGP SIGNATURE-----

--I6aGG9uGp4vcTTALtWXeBMVAQ9f2OtiH4--
