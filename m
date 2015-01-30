From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jan 2015 07:40:58 +0000
Subject: Re: [PATCH v2] fbdev: ssd1307fb: return proper error code if write command fails
Message-Id: <54CB358A.7080205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WljsMuhkqfPB3B8ibPANcxvme8rKMVpu6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421348737-4606-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1421348737-4606-1-git-send-email-prabhakar.csengg@gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>

--WljsMuhkqfPB3B8ibPANcxvme8rKMVpu6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/01/15 21:05, Lad, Prabhakar wrote:
> From: Prabhakar Lad <prabhakar.csengg@gmail.com>
>=20
> this patch fixes ssd1307fb_ssd1306_init() function to return
> proper error codes in case of failures.
>=20
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  Changes for v2:
>  a: Added new line as per Maxime's suggestion.
>=20
>  drivers/video/fbdev/ssd1307fb.c | 67 ++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 53 insertions(+), 14 deletions(-)
>=20

Thanks, queued for 3.20.

 Tomi



--WljsMuhkqfPB3B8ibPANcxvme8rKMVpu6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzWKAAoJEPo9qoy8lh71xOsP/2D3KF5nJ8je+z//ROVntxbH
61FbulCUNb/8WGqIR4tSLYDB2ZoWNCk4E3wL8RKLrQ2xP4lhpWKkb0i6Eog5rYqG
LEdoDDE8Tfr7I9+Uai/SFBWRn4nQ7UI4OybhnU9uwpdb534+LeI9cw8rNpvsfJMI
k0aRwUFKRn1uOXfQzdvnktvIsHELlcU/OFT9ruRZ0vpdggdxApUeho4NkjaqGVF9
gR+6m0ISO+7Mb7stktKY89l7LYYK/9pHXWF3I1eRuW2lkIW5gZ0gNK8QC2zKVRmx
rNrg9mvlirg7jfbHizmOmbJdVADTnURhJYlokemmbkmKZ6cDuqo7QQX1+nJvSiEd
7AkEw/ILxEDehDuF854QaIk+GlBmuIhd3vDjGgMrarORTZO4bcWQzrTAW7Mbxqf4
UzBMcuP6JSU/2/lC1oG7EX0wCG7QOyrhsj0iYU+UukjipLnSf0pNSh2XySHKGNrN
CC3hSlIXw3A25rUfVXv3c2QCQwh9coPNJ7jyhQVnV2MX/XgRh7sfK7XFzB9NTUMK
YSA71OZnPF2sQkX6td9x3TTmkl1S4JOtZO0lQVCLP1VxFwYYqQFiOAY6Il81tGeR
SxLJ6XvE+bHk2o2UNmQeMcMDYbveqoEsLxz4lT5/vLVSd6JQdRBB3CioE63hnQfk
jvE0B03mUhlR6v8DcPHY
=01dx
-----END PGP SIGNATURE-----

--WljsMuhkqfPB3B8ibPANcxvme8rKMVpu6--
