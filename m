From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 13:21:25 +0000
Subject: Re: [PATCH linux-next] fb: make fp_get_options name argument const
Message-Id: <51CAEAD5.40601@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2JKGWVHFRFNQATEGAHBLU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371565386-23335-1-git-send-email-vincent.stehle@freescale.com>
In-Reply-To: <1371565386-23335-1-git-send-email-vincent.stehle@freescale.com>
To: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@freescale.com>
Cc: linux-next@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dave Airlie <airlied@redhat.com>, trivial@kernel.org

------enig2JKGWVHFRFNQATEGAHBLU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 18/06/13 17:23, Vincent Stehl=C3=A9 wrote:
> drm_get_connector_name now returns a const value, which causes the foll=
owing
> compilation warning:
>=20
>   drivers/gpu/drm/drm_fb_helper.c: In function =E2=80=98drm_fb_helper_p=
arse_command_line=E2=80=99:
>   drivers/gpu/drm/drm_fb_helper.c:127:3: warning: passing argument 1 of=
 =E2=80=98fb_get_options=E2=80=99 discards =E2=80=98const=E2=80=99 qualif=
ier from pointer target type [enabled by default]
>   In file included from drivers/gpu/drm/drm_fb_helper.c:35:0:
>   include/linux/fb.h:627:12: note: expected =E2=80=98char *=E2=80=99 bu=
t argument is of type =E2=80=98const char *=E2=80=99
>=20
> As fb_get_options uses its name argument as read only, make it const. T=
his
> fixes the aforementioned compilation warning.
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@freescale.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: trivial@kernel.org
> ---
>=20
>=20
> Hi,
>=20
> I remarked this warning while building linux-next with imx_v6_v7_defcon=
fig.
> Is changing fb_get_options prototype "permitted", please?

I don't see how changing the parameter to const could break anything, so
I've applied this to fbdev-3.11 branch.

 Tomi



------enig2JKGWVHFRFNQATEGAHBLU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyurVAAoJEPo9qoy8lh71HA0P/3+qcc/4Z+wuy2wvgcqNxyGs
5fkPwXzAHhBYAA3yqLUkl776dVElCr6rLQcq3+eBXrB9Uil1Dyw8vPVBXvN0hSFm
qV3Cnx9DGsz1WFBeM/ezibqtdwHeEsLMNI7jThdSDyFZDgChM2LXSrBwuoZwy8eX
aLlcG8o3GM/gOtswKdanW7oNaRfYB9ZXqLlaIEr+/zA+LhDpbBVtHDBaqIkIUrnT
QpUtsrt16pleIFMYPe52It9jdXBwCTx//Pg8wfzPropvMbEqVz8LjYlm2n3dHrsc
JedqRoZWRDPAnoY4esu6e4wcjQpDzLss0QObXxOD+5cp9RL6mwrjQi6BS3zN23PY
6Ht+bq57KFiZarto6dIcCP/2YOSNeHjGMf4m6pPImPJPITCOx0A6YpDn8qaqiYuR
HqZ8N+1L10G53QvVGp9DsBf0E988yToM13icPAQfhUIT912bS3WYo4XKJKBskmuy
F3NilZdNaGWHZjvqLoj3CJTRj76h8Zx+WfEm9sdqF1deF++91kzBxza4sPirAaQA
BAhQQJIoZu76Ha3Y0txq9IJIlLfnjnbJsyPyDfyyy0ZtZe/hNPbMUBYrqBiIBDng
XGL9rxAvmZ1OEpnqZeXLgpx4kYMdoDNWTVt+N5e8540A+E1buUGdgf6dPRJNuI2y
YYi9aDvezC2BqlQxgVVM
=rWMD
-----END PGP SIGNATURE-----

------enig2JKGWVHFRFNQATEGAHBLU--
