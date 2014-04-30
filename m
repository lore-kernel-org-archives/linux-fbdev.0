From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Apr 2014 11:02:49 +0000
Subject: Re: [PATCH V2] video: pxa3xx-gcu: use devm_ioremap_resource()
Message-Id: <5360D859.5090606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mk2vr5Ne5HH83jDcwtQfMi0EaPTcngtlq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <008201cf52e6$7314ea60$593ebf20$%han@samsung.com>
In-Reply-To: <008201cf52e6$7314ea60$593ebf20$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--mk2vr5Ne5HH83jDcwtQfMi0EaPTcngtlq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/04/14 07:53, Jingoo Han wrote:
> Use devm_ioremap_resource() because devm_request_and_ioremap() is
> obsoleted by devm_ioremap_resource().
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Changes since v1:
> - remove unnecessary error message, because devm_ioremap_resource()
>   already prints one in all failure cases.

Thanks, queued for 3.16.

 Tomi



--mk2vr5Ne5HH83jDcwtQfMi0EaPTcngtlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYNhZAAoJEPo9qoy8lh71qsUQAIEiMdASy4cUXLt+NB4AjDVJ
yAosH6lHGzhK4K2xSly+81IzvyTySnhCSKri7A4ewJRfNPYLVI971Zr84zgaoRGC
WHIDP/wUi9moxUm+naoVRaYNnr101InJ34fFTmBjdOYq1dZY2dAKaDjTEftGCMho
qyIXkby/Cgf/2HgtPmM74CGn4A/m62XL+xfVBfL/8i4qcUBIT+CvYZ+lgbvJkFP7
ioNxhzLsKpBQaCxX6ly64IhAC1wMzJl4saZyDF/WNkGY75IMphXNBTG7irUMdfge
IxMM+sd3qs2/7wHCiJMabK81r0t9Dzc6hm2XEgDWsE4so/Fzy4hEWlFz+kn1SKZk
xU0ECTzmFw5XSEFj35ZD/QtI32kbuSNYRQJeoxsRQLhx09PXg+ZgoMfQrYirbDD0
k6TykN9PVKLsks5E9GbZ7qX289RMFWLGqB8OoRG9Swjtu01eUthFccpfAVonkz0s
08wX8/6D9dHL/YaSox/UFextl4U6rrK4FZdR8DHFAGMl3DeJb5bBRuRX3WDUTe5B
iL8WF8P2CD1LTdDKtBunoNl6bXtDYlzmVM2bZARef4C5iRvcUyiOtBmI+B/4djeG
Iy4JuiIbm+vXg7zcA3hxtKwVXTwnDAjzIY552oB68PCcZF1/3gXr1V+bcsAT6N/d
9afAjaQLJt859I3vph7/
=qtiL
-----END PGP SIGNATURE-----

--mk2vr5Ne5HH83jDcwtQfMi0EaPTcngtlq--
