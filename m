From: 'Maxime Ripard' <maxime.ripard@free-electrons.com>
Date: Tue, 16 Jul 2013 15:46:16 +0000
Subject: Re: [PATCH 3/3] fb: backlight: HX8357: Add HX8369 support
Message-Id: <20130716154616.GK3125@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3MHXEHrrXKLGx71o"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373902022-20439-4-git-send-email-maxime.ripard@free-electrons.com>
 <003601ce81c8$c2573320$47059960$@samsung.com>
In-Reply-To: <003601ce81c8$c2573320$47059960$@samsung.com>
To: linux-arm-kernel@lists.infradead.org


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jingoo,

On Tue, Jul 16, 2013 at 11:04:09AM +0900, Jingoo Han wrote:
> On Tuesday, July 16, 2013 12:27 AM, Maxime Ripard wrote:
> >=20
> > From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >=20
> > Add support for the Himax HX8369 controller as it is quite similar to t=
he
> > hx8357.
> >=20
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Hi Maxime Ripard,
>=20
> I reviewed this patch with Himax HX8369 datasheet.
> I cannot find any problems. It looks good.
>=20
> However, if possible, please add comment on huge delays such as
> msleep(120), msleep(100), etc.

Right. I'll send a follow-up patch if this is merged right away, or
merge the comments in the next iteration of the patches.

> Acked-by: Jingoo Han <jg1.han@samsung.com>

Thanks for taking the time to review this!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5WrHAAoJEBx+YmzsjxAgmxsP/jqpdhyeGU8YY/k9BlSFHmDh
iZeH16Ri2Awb6aJKDjYGLfR7IHMXwgSgX4mgCZMYOm46l3nqkHs2tTIkVQ54p6sT
eWkTcqo95/vTtl/MKEiWSl4zjEyEgBgX2HKkosoVePls5m0suxbb3dMeNXoU5CN7
ZEIWf8NiZesnpdd+3tMl/mY7n2lcX5X0wYookluDKQARRfSkKuTZYioTY5SvXl2i
2QVYOZ3gi4A3fGJlsyumO8ow/hOBH1OQ4DxV7tRdC9AWMwsbsG/Li3fqqnDfRCTA
k5NUfbWrJi7bRzy0n3oYJizKdD/jOxOgSNZHJX3oP9LPj2b3ads34D1fTa/WwQ1o
eJ8vzFnCdnIgXpXRf0jrNiih9XSyS+h0CMHwYTAGwErdqDvL9dLeioQryO0rW6Du
eQCgYrmGX3667UzDgOV0w4JRgmAtqYpJadCPAgrbnSYieCaV/AFadHH2SoOG/Pa5
JwE5o2yKX310SN4r/NDReEbyEMCGTaq1Gp/96lppKX4pflqdzGICKFFlwU36w5Mv
Ey1erO05YpO0p8MjLH1ogLNlQ6MiPKGQcaTyV94TbAYXAUUnVmnJvZau5Dcaq1vD
C672KwFqmvO/LxKCu+5JmPehT4AjL4iHeSA13tEXrhwj3bF+HL9vch7prE5voINJ
kqTWOw/ZYfbG2lMh+gdo
=sha7
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--
