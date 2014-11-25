From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 25 Nov 2014 12:34:19 +0000
Subject: Re: [PATCH v3 0/2] dt-bindings: simplefb: Drop the advice about using a specific path for nodes
Message-Id: <5474774B.7080408@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="27PVP15wm3OlnjjolfnQfkRqWpFf2irNd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org

--27PVP15wm3OlnjjolfnQfkRqWpFf2irNd
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 18/11/14 13:10, Hans de Goede wrote:
> Hi Tomi,
>=20
> So it turns out we needed a v3, as I mistakenly went with "sunxi," as v=
endor
> prefix for the allwinner specific properties, but the registered vendor=
 prefix
> for allwinner is "allwinnner,", this version fixes this.
>=20
> Changes in v3: Use proper "allwinnner," for the compatible string and v=
endor
> specific properties.
>=20
> Changes in v2: Changed the simplefb-sunxi bindings to use a single
> sunxi,pipeline string property instead of a sunxi,pipeline int and a
> sunxi,output string property.
>=20
> This patch set is all acked up, and a fix to the binding changes you've=

> already queued for 3.19, so please queue these 2 patches for 3.19.

The discussions about this have continued in the earlier version of this
series. Is this series still ok for everyone?

The series looks fine to me, and has Grant's acks, so I'll merge it
tomorrow to fbdev tree if no one objects (and my comment for the patch 2
about sunxi/allwinner was just my ignorance).

 Tomi



--27PVP15wm3OlnjjolfnQfkRqWpFf2irNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdHdLAAoJEPo9qoy8lh715YAP+wT3w8lODi+f760uAuzrQPKJ
6oMTPzYwpZufXZZi9yD9jvXzVf1wn6m6v9UbbTP/9XLE8MlbaEj+aXoto8vUHPI9
316n5MSp6Z3JbgkYeaenECZSjcpp1WbafE37UQtS1fArDlaCRVMjVDhPALKvaEaj
W6VMVnm3oxZ7C8/oB2+nEVIu8Q2laU+8AXGt4VOH2Gp+UFo2uLJqGAxdoo5w01W8
obYolfKruwcTFVPf/aJsWZcefuphD84DUMb+pdddXqLlSr0aqAdMfWHA5mmPCsI2
ePlAfKhgs3abkah+H5Z/HTTTJinNihjV4nanhbUCLWbHkGiLsJJVaEuTER3vxSg0
Q5fGqr75zBdDYTdDbgchH5AhbA7qYZDYK0JYvNkYb6/xcBu8tzfdlkgrnDIT9yTm
MrxzYcK49vBByhlvbVARIPnzrF83EzQD9KOpkKKByWAwEP4QKL2+O5TvcY8B6rAm
gstNar9WL5/nS3BxXYnj2MuR1SktVr0YykLLlpmh1YpkI7fcyR6vPtHQW+Qoj5/z
GJIYcSITzv2L44pqPwiF3gtqFqf55xzaRt2Buljk5mTXI11KAkyh+9clNcFrPXW7
6uS8iAlQngJZ0dJZmgMUOWS+2ZPQr9Y0TNWQ0kmvJTqylmFscjftJ7PffrnKvBzP
MA2CSjIkxNs2EzsQ1nvN
=TUCo
-----END PGP SIGNATURE-----

--27PVP15wm3OlnjjolfnQfkRqWpFf2irNd--
