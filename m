From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 07 May 2015 11:00:26 +0000
Subject: Re: [PATCH v4] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <554B45CA.2010103@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WbjU6gf6bcrX8NXHjcCdFrwprRqipsE8L"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1428036665-14454-1-git-send-email-Ying.Liu@freescale.com>
In-Reply-To: <1428036665-14454-1-git-send-email-Ying.Liu@freescale.com>
To: Liu Ying <Ying.Liu@freescale.com>, linux-fbdev@vger.kernel.org
Cc: Peter Chen <peter.chen@freescale.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

--WbjU6gf6bcrX8NXHjcCdFrwprRqipsE8L
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/04/15 07:51, Liu Ying wrote:
> The LCDIF engines embedded in i.MX6sl and i.MX6sx SoCs need the axi clo=
ck
> as the engine's system clock.  The clock should be enabled when accessi=
ng
> LCDIF registers, otherwise the kernel would hang up.  We should also ke=
ep
> the clock enabled when the engine is being active to scan out frames fr=
om
> memory.  This patch makes sure the axi clock is enabled when accessing
> registers so that the kernel hang up issue can be fixed.
>=20
> Reported-by: Peter Chen <peter.chen@freescale.com>
> Tested-by: Peter Chen <peter.chen@freescale.com>
> Cc: <stable@vger.kernel.org> # 3.19+
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> ---
> v3->v4:
> * To address Tomi's comment, enable/disable the axi clock in
>   mxsfb_pan_display() directly instead of checking the host->enabled fl=
ag.
>=20
> v2->v3:
> * To address Tomi's comment, improve the commit message only.
>=20
> v1->v2:
> * Add 'Tested-by: Peter Chen <peter.chen@freescale.com>' tag.
> * Add 'Cc: <stable@vger.kernel.org> # 3.19+' tag.
>=20
>  drivers/video/fbdev/mxsfb.c | 68 +++++++++++++++++++++++++++++++++++--=
--------
>  1 file changed, 54 insertions(+), 14 deletions(-)

Thanks, queued for 4.2.

 Tomi



--WbjU6gf6bcrX8NXHjcCdFrwprRqipsE8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVS0XLAAoJEPo9qoy8lh715TwP/32FX3qGwbgEDOoYFBUU0LNC
9ib/vsNVQvxvTkS/bfC/VWbr9wOq2we5PYgC4knmxMVDVDwu6gohc4OkQ5+rlzwR
ENUTgqLkzmWQFNLMtzrv2hzysvLfqIxXpDDPSpW6jcL4LJ/yodVpNiYwO3qT+ngf
gfWQQ62RfsVski64QWyXDLrJfUkttGrB/NYjqeIeSd+xvIbHXQ2WklPS2PbflBFP
1Y5yLSSS74VlGgsiQ3oftzSAIgxCY5q49zzhPMhiU/OZKxwD9x6Ln20P03hU+Ifj
8TPdSAM4Ew0lNRtnA4V8RByJWbOcZ6xu5Y22/eT3y4USl1amrOV9JJge0Wt9Cm8O
JvRNGaFpxy4vT3ZnkeK+lM6lsbeLCqz8bqqUl+DYf969vb0M+syCKnwv6nrNXXvo
9f1sJD7aq7LylfqzeJ/CVYGyhf8fkbI8z9U5LemyGar/qRUzWyIp6cpvOB2QQy4M
O0CMDXBfye/mI6hAU1L2AUNof7R7/XjRfWvrOGIqIM5taVvL02fwELNyChkjXY9D
d7niZqPHGK5mgSk15vEE65o5b1C3hlIe6oN7hN1T+uZPNuxfVz8CkF7niUOSmjhD
uaDZ7hxgD8a7dm5QXxWVi/40buxbeDxwi067iVz2/v2NYxEeaFpUZfbax0878sBX
+4YNSr6mIzslTUjPOBZ2
=CHdK
-----END PGP SIGNATURE-----

--WbjU6gf6bcrX8NXHjcCdFrwprRqipsE8L--
