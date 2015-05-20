From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 20 May 2015 08:50:38 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <555C4ADE.6030400@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TG4V95O0DOnDlORHXwIUfXW0EA3ha2shF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
To: linux-fbdev@vger.kernel.org

--TG4V95O0DOnDlORHXwIUfXW0EA3ha2shF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 14/05/15 17:26, Luis R. Rodriguez wrote:

> Tomi,
>=20
> Any chance you can consider this series again? I realize you say you ar=
e
> not familiar with MTRR but given its prevalence use on framebuffer devi=
ce
> drivers and since you are a framebuffer subsystem maintainer I think it=
s
> perhaps fair to ask one of you become familiar with this stuff, or ask
> questions if there are any. If its of any help this patch which adds
> ioremap_uc() already got merged and the logic to phase MTRR is describe=
d
> there too:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit=
/?id=3De4b6be33c28923d8cde53023e0888b1c5d1a9027
>=20
> That patch won't even be needed on this series, this series happens to =
be
> straight forward: if you just ioremap_nocache() once and use mtrr_add()=

> then conver over to ioremap_wc() and use arch_phys_wc_add(). If it alre=
ady
> used ioremap_wc() just convert over from mtrr_add() to arch_phys_wc_add=
()
>=20
> Not sure if you will get an Acked-by by x86 folks on this series as the=
y
> are busy, but I'm adding bp and hpa just in case.

These are now queued for 4.2. Sorry it took so long. I've been away and
my bandwidth for the fbdev maintainership has been rather limited lately.=


 Tomi


--TG4V95O0DOnDlORHXwIUfXW0EA3ha2shF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXEreAAoJEPo9qoy8lh71jycP/jFvSCb3jiSQsOE7Pu6slTps
JZQQl9zih639nDJaPGWe2NOjsAWAY7XAQKib6qlqCwtLU8uV3xyvVirlklHn/oQD
vbEyNej8DoT7W1+wNBTsZMLnKObZQlQ24Y8Ufv5gEJWhF3mO+fpLYPOywQsrsVI3
VFNiP3zKSkP5Ok2RFNw/2jflT/qLE+wn3V17URAdeXMkV2jShqire3JEd0WPR4qA
2q9z6xWMqfo/jQJxpSaIwhrrcepqu3SGxanKDGxuXOI8sS8nJjVe9invmjw3pV5I
xIsgp2ZxcFbXRhqFdvXFdzdIoaPhAJA05WC3Xffvmr0Gk6KXvei6Nht7/LoNA1jj
WT/1DJEq85tKdHpGTD1OM1zvtxwpLn5VHqMtX1yx4Rhc89Smf+6rEjaFlpJwL44l
GYYnC2XxwZLnYOslJY23OiToJCLAP/2JJb1ez/Tu8oYnl7XWmJalZED2YeYCNx+v
aYik9PgWE0rVvqcBWkSDETqFV7lfolBcjGC6konXT0D+LJyNnix2ZRrnhBxtYWRa
L2E+bBMpyivXejOfT8NXL+on8dqFgNr8vkPQ/jx8T+yRplzXHpLRVJ3Bz8tsbz7B
uD07xz8PYDyj1nVGnH7Bxy88Yw2nENUsm0x8cm1+aanTGs68FTL++uBpmZ1FFol0
3Vd7QI7Cy5BKjYjYuIVx
=Vg2g
-----END PGP SIGNATURE-----

--TG4V95O0DOnDlORHXwIUfXW0EA3ha2shF--
