From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Nov 2015 10:38:27 +0000
Subject: Re: [PATCH] drivers/video/fbdev/i740fb: remove unused variable
Message-Id: <56543E23.9000302@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oiCkLUlMx2Qqm4liebxbxVVpabeF0GUdp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443870991-10836-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1443870991-10836-1-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

--oiCkLUlMx2Qqm4liebxbxVVpabeF0GUdp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/10/15 14:16, Sudip Mukherjee wrote:
> The value of d_best is always 0 and never changes.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/video/fbdev/i740fb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Thanks, queued for 4.5.

 Tomi


--oiCkLUlMx2Qqm4liebxbxVVpabeF0GUdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVD4jAAoJEPo9qoy8lh71A9MQAIWnNRqBO0wQ4CjGelnXGtgz
4EJzHMJJoja1v0HnOx+7+zwRzxGLVD9yhySNV1pWe5qFE/biHG9f6gDD1E/Fx0PG
rhpSiU1cD4YKLimyNnJyyIyrNnmELArzbd9zaz5/2RFNnIK9yfZa7sD/2J+nMUBX
oU4XQ/7RzwIAW5gnD+G2aKSAAeNQMgKrCRpgaC38alt72JU7hVWNdfFCZp1kgR1v
6RioYYqdbplsjPSnzqW+uLyBXlz33Gr6y30AZTUdx2Fzs+q/2tuht5BrxvxNpcj9
8p7uzl+yOBTCGl2FgGr/kGywQM+8xuZC2ozEEi1vGM7R1l1UmtU3tdfUVKOYK57E
UK3YBXdMOtrdmUXDcMOKifXQnflCJJtu9fmrsnEwCRVGkw7mpPPiOJqBJU4CxFHg
QpwLRBFk+IPhIQPbEWW9Cx6VHKuru4VAiOyWZgvIRPpRSYybNEq59Z5d4CCoGcz/
65IJjQjI+/qTOayORwdsH5EaSwSLECKKDwoMApaNtANTkTTMRVGgPNUaJSmsQCw2
A6f1WMcc8YkORqCV0EZ0YC/IgSM3bYAzDpg1l/XiRVwM74Sht945Nwfkn7Ao22rD
EGzo+FuwCD3z9KyzCryPkWzrDZNP3UhP8eP1mmOpA3N4RgCTByI0KuaW2lpgI7dO
LLadysUtzR/fAGZJ3OC7
=wNFN
-----END PGP SIGNATURE-----

--oiCkLUlMx2Qqm4liebxbxVVpabeF0GUdp--
