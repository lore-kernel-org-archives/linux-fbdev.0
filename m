From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Nov 2013 14:51:04 +0000
Subject: Re: [PATCH 2/2] framebuffer: Fix int cast to pointer warnings
Message-Id: <5294B558.6030106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NEABQGswI9TBhb4DBeX8u8ewMvc2JsJGs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <c94f3e342947923f20d4c12932f382aa5200511b.1379641901.git.joe@perches.com> <1379646611.2021.7.camel@joe-AO722>
In-Reply-To: <1379646611.2021.7.camel@joe-AO722>
To: Joe Perches <joe@perches.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--NEABQGswI9TBhb4DBeX8u8ewMvc2JsJGs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-09-20 06:10, Joe Perches wrote:
> Casts of int to pointer need additional casts to (unsigned long)
> when compiled for x86-64 to silence the compiler.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/arkfb.c    | 2 +-
>  drivers/video/vt8623fb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
> index b13f3f2..26fd4e4 100644
> --- a/drivers/video/arkfb.c
> +++ b/drivers/video/arkfb.c
> @@ -1016,7 +1016,7 @@ static int ark_pci_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
> =20
>  	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
> =20
> -	par->state.vgabase =3D (void __iomem *) vga_res.start;
> +	par->state.vgabase =3D (void __iomem *)(unsigned long)vga_res.start;
> =20
>  	/* FIXME get memsize */
>  	regval =3D vga_rseq(par->state.vgabase, 0x10);
> diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
> index 7e97c53..281d41b 100644
> --- a/drivers/video/vt8623fb.c
> +++ b/drivers/video/vt8623fb.c
> @@ -731,7 +731,7 @@ static int vt8623_pci_probe(struct pci_dev *dev, co=
nst struct pci_device_id *id)
> =20
>  	pcibios_bus_to_resource(dev, &vga_res, &bus_reg);
> =20
> -	par->state.vgabase =3D (void __iomem *) vga_res.start;
> +	par->state.vgabase =3D (void __iomem *)(unsigned long)vga_res.start;
> =20
>  	/* Find how many physical memory there is on card */
>  	memsize1 =3D (vga_rseq(par->state.vgabase, 0x34) + 1) >> 1;

What's the warning? I'm not seeing anything on my machine when compiling
these two.

 Tomi



--NEABQGswI9TBhb4DBeX8u8ewMvc2JsJGs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlLVYAAoJEPo9qoy8lh71+YoQAK2AHykk8wH0bxBHZsyEt9RA
gKip3nc3Cgq3hGo96g12t39JQiznhtuxbhE2BknllHbxC5D5spi3mr27wb8KdIxG
qGJ8q16t9bcDD3/aMmtdf3sADqdboEVYpKkEBQSXoc/GbDJDXc73o+OfnsggA8vL
r3+M8epaQByrIgMXqIB4B7tTVXJBxxyerYEqqF+lqTkrfq8WftjqZHPVTCHK/rPG
CLVIReNIGVPnPbmGJz8QQipJ50FYOxZ0QePyg90NT+2AiLwdHk+f81WABpkxWFnz
ZcJLrtELxPoTRZPeN+o8WByv7FlwywIcQoTwkSl67HgBIiPGDpP9xtVfEI7x4FDl
VZqCTq+f5arkMXynx5ntdxbCzPX3ec340P+HevjHxp7W2Of+eFV0QdWQTAQpmltm
5ta5fWkGEd8Jg3DIrE1gUjm0M4SzG5hbbHokDRxxtUoDqLvp48xb5iA9wDxD6zn7
04vuVJND0bLV9N+wbKkowr/rB6ZqqCi1rqjqte+62UDD6MM5sLm8TAWZnsAISNt5
5xHnEhGwhTsrlpRuHAUfuMrFD8xZZsAQy9adGm/C7+kyKnylrNfkZdOhaDf+imIp
Yu4dXzw/PErmggf1YPkLgzLG7JEeIVCB/RRvFwlprvMh3rJ0e1G4EUMGD4P6pGNx
+u4p4m7LEb5mMgtR/icG
=Eciw
-----END PGP SIGNATURE-----

--NEABQGswI9TBhb4DBeX8u8ewMvc2JsJGs--
