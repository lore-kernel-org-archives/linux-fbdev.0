From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 07:43:08 +0000
Subject: Re: [PATCH 11/23] video: da8xx-fb: make io operations safe
Message-Id: <51CA9B8C.8060407@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2BBJJLWJEFHRKDWBDVUKH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-12-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-12-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2BBJJLWJEFHRKDWBDVUKH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> Replace __raw_readl/__raw_writel with readl/writel; this driver is
> reused on ARMv7 (AM335x SoC).

Why is this needed?

 Tomi



------enig2BBJJLWJEFHRKDWBDVUKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRypuQAAoJEPo9qoy8lh71LPUP+wWDZ59WN7fZhyqKHuh275Zp
NMBnvjXlI1hsJHAVJslkZ7iUO05pko//EXMrqdy91ZZ8/Y0YFDUAo+kpBseyQMY3
mEOU4GZOorG0t4xbp3x6qldb9j/EgeOIazsUrIi/U8i8UCMdmyKo2FO9QpSAhnWE
CvcqVfPPKD6PE20FY39W2aSpJ9yjT6z7bT1d+7aqU8L2itLRcL0xZgri+9fGZdpr
6JsKl0mSyHp4+816pGWjBuCb6RSNTs92G0hFbY4u9YSAmdeeKdwsf/TLe3OuGGr3
6IqsCwkWWsii4ynWfkC8OwUlOGRdDL7Qmqvsy9JXh5WssL2TUePHXc1H/2Ov9KT6
8AorBuHKhi8P2Br/6FLVbGwfV8f9RMo2n8HgqrLEK/YtRRhPTMVuhr99Ko7O+KVO
gR0iynZ1cPo2qKpB+isBbaERKpaHspg4YiQH14jFWXADe3GqwLDzgFW/62iP9sPG
7pq/NggEset0R4LTUVxop4/QV97wb5lbJ5DhCi/HYxyuK0WtHVvCf4nCaSnSX6Qb
bqmw53tmYkYeXfOd9jjC8EMfmePzxGeY9X+89XobCwolVe4XY34t4n4NYAY0/Lj0
RnzjWif7czyWqsO2WDb8ozNw0nLOUL8XQu1SELcMI14vmK5VKhqJUziy0+l1Nwm1
FfoEfPbnk+pZoONoI0gK
=U5BM
-----END PGP SIGNATURE-----

------enig2BBJJLWJEFHRKDWBDVUKH--
