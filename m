From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 18 Mar 2015 17:38:05 +0000
Subject: Re: [PATCHv4 02/10] fbdev: ssd1307fb: Allocate page aligned video memory.
Message-Id: <20150318173805.GU4638@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0rpW5bEisVBStM29"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-3-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-3-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--0rpW5bEisVBStM29
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 06:11:50PM +0100, Thomas Niederpr=FCm wrote:
> Currently the videomemory is allocated by kmalloc, making it a memory
> region that is not necessarily page aligend. This leads to problems
> upon mmap call, where the video memory's address gets aligned to the
> next page boundary. The result is that the userspace program that issued
> the mmap call is not able to access the video memory from the start to
> the next page boundary.
>=20
> This patch changes the allocation of the video memory to use
> __get_free_pages() in order to obtain memory that is aligned
> to page boundaries.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--0rpW5bEisVBStM29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCbf9AAoJEBx+YmzsjxAgc/QQAI0MT2zaNSG993YVqd20/9DM
ktIacRncdLBUcfxUJy3E43bPLXl3l/Tuz/oIqw36HvQBPx9118AQVWropvQqgIUr
PYXkEXXgxfB38/EmcpuHzCO2iCw22e9IbSYk0wehGxUjpSuVqPGn7hr3KNbaUDGd
LC70h50TecAgvzv5+etr8IwVXI6AQ/al9UVHu+R2FGA5nLp9imKBxsWZRoS65pTo
+FwCPZSFhbte4KYzRIAjyOPnPn6HrqdtE1ji9saTRUsxjmsoYNo1wflJBijbn6e9
oXbs8wNCTMKvrm8Ud9Dzr/xagtgJTAyCwpCq90ZvtcrszSNA5ZI4Z/morO/7Vql6
C/17URq+FldB9ZPfZYN9n1+V1YTg+Y4eNCzJXqBNHQRUmYvDs5C7UkZRkrIRv3kQ
eF00y+zSl6wX87bk1zUjdNmANA1j6L58LloRhr8FzwuUQM/i+eplpjjVCbbw+m4w
G9aCY2JxuWXvy7HbiI0oeJw+s+xlh5xT4keNlEVwgqKKGrLmWm00bYPsIePcPnS3
SlRZwiXJSToslPXy1ff6gDJjG7rCh4DIJm8Mm9pgw3fwpU0IY229WVN/iT/66CE7
ZycNwjJxA2vDtmbKD6qOuqecw+2mWxUlH41UCG0UmoEmZGSrkRDu5PYrfoHTJAsb
51GK7cM/FqeW+7laE+8k
=kNaK
-----END PGP SIGNATURE-----

--0rpW5bEisVBStM29--
