From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 30 Sep 2013 16:43:36 +0000
Subject: Re: [PATCH 1/3] video: ssd1307fb: Remove redundant of_match_ptr
Message-Id: <20130930164335.GB2679@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380530733-9070-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380530733-9070-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 02:15:31PM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSao3AAoJEBx+YmzsjxAgMwYP/RmAzl03rKCKKgzwVvePJABS
3YqbWyFzGnICMMAn28+f88YbE8J8dGGRG7VKeI52QcKJiaDsTosr278ROGfOBhRW
7ElEiIwVgXrn42XHAu835Zd7aB2yJg/u7shFlosLFcODVStgTJUAvvWye2WuyvC6
jPrIQsZx/RBBN/nITDKg1TYRUbyMG67ZxDHeelvSeqxKT30ifKDS6LWHlWZJE14i
6fIzuc5/PyoGf+7Vypv5fzWKl673AIJ9TN386tNHXoMWFMmK+AZfQvMcsNQjmYXe
a0XOnRjMDPHHjuBfMUt3uSwnO2FMw07TAlKkV3Qxa7nFSSed5joF/c5pPvciKnUj
XTFADn4F0M5A8AoL54ffDzaDH7FSq11QWl+QNkTCzVU3+5wc3+Q3mmCJB2RS2ppT
jO42CCt4flR5eGDS8LCrsaTbVwMEBniwDH/duDgPajBij5ewYvaeZx/LSFXqBwZX
3TGCY8cm26VSUtvk1wfqtgcxdigRheu685of/2qHcz9h972nwa+wT/FalLgnreKo
zaoIxs4ogM1bP1ZQoKP852rm7ujm+CiCDFM3++cyUJTaRUZLdAl6EzqSXreANyay
a3s7kg6bQuPDI1tT4c6RgkHcBX3RPvk8SAQwI35DcLd0WDPLI2Qehxm+gYxTEswq
u/fefVpNGdTkDwdKwQo9
=/oQh
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
