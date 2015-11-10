From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Nov 2015 11:38:58 +0000
Subject: Re: [PATCH 0/3] Hisilicon graphic driver
Message-Id: <5641D752.6060302@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="i3XJjfMv99jsHwtiWRBq3bGFmOAwrF8iP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BLU437-SMTP248CA33D65A31EAE12675CC32B0@phx.gbl>
In-Reply-To: <BLU437-SMTP248CA33D65A31EAE12675CC32B0@phx.gbl>
To: linux-fbdev@vger.kernel.org

--i3XJjfMv99jsHwtiWRBq3bGFmOAwrF8iP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/11/15 15:54, Rongrong Zou wrote:
> From: Rongrong Zou <rongrongchau@163.com>
>=20
> Hi1710 chip have a graphic modue with 2d acceleration, this driver supp=
ort
> the graphic module.

I'm not merging new fbdev drivers if there are no special reasons for it
(fb for non-MMU platforms is the only reason I know).

Instead, please write a DRM driver.

 Tomi


--i3XJjfMv99jsHwtiWRBq3bGFmOAwrF8iP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWQddSAAoJEPo9qoy8lh71mTIP/iP2ZmtHJoLmswtsWuLYO599
qcuxbz5nvhqX9btwaPYTZZMqR/JKbSGdn5gIlSBG8QCxKX4NsUwxs0hMW5jeBSLm
P7MxkS3zOV7c6FEnrNqVmMqOqK1aKyqH2uVub2SXduNwb/H4ngut6s5gOhnyx+VQ
vcTXd89ZaF4Aw0t/9lqCLsJzd69yyrLvctEj3UsAwbuzmnRNdfxYI96XUfheGmt1
jgjq5Evo+YBK2d6XTeAzqCYofuIvhm/TVDuZJ/daPDIJpFnCGLg15FPMCbCUpUEp
j0wZH0P5CkJLToNWZssnAG9bTa59h8FstJy9tjjgzF8CICNfEXrbueQa+eqVH1xw
MoU7tK3QJthBHgF8hWz+P1UwsBUotPNdqBLCNzZBmys6wf4YzvhZTKmxFs/zqLHY
vjzrBwfnL+znMqp6vhc9FLK5BCbWr+wAs/MuoUM2gX6aWoa3IUgxAVQJNsL5MQ3k
en0P0XFayh/tr3Qtmy+BQUQ7ozgHXhVLnBcmum9eZPSpgPGcK5CvnJS6gHs62EVQ
j7kpDokKcIqtjnTZKjRfSNsvmea3165ob63DLDZOgPoLq+5bceXZUlDGcb+kznbk
LUCVKWLarDBwQQoDW0LcJVzZvJTMNqNtVbCj1lpgWuPxkpTyijMHBVsyPLzV0yM6
tkCzkLA7/iH0CHksyLNW
=MJ6E
-----END PGP SIGNATURE-----

--i3XJjfMv99jsHwtiWRBq3bGFmOAwrF8iP--
