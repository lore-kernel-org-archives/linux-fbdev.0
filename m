From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 24 Mar 2015 22:16:36 +0000
Subject: Re: [PATCHv5 09/11] fbdev: ssd1307fb: Add module parameter to set the initial contrast
Message-Id: <20150324221636.GE23664@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="maH1Gajj2nflutpK"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-10-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-10-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 10:23:56PM +0100, Thomas Niederpr=FCm wrote:
> This patch adds the module parameter "contrast" to determine the
> contrast value that is used to initialize the display. This
> setting applies to all instances of the driver.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>

Do we still need this patch given that the next one is doing the exact
same thing?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEeJEAAoJEBx+YmzsjxAgPmQP/18R9VClUoDfw8cQXSAWL/U0
4jld3wD9/H4MNSa/DVLdA9D44AtR07fdHwtCDFtNFtoGO79Avist0SYSquaVlsRA
wFECcYvWmusfr/xO+upiRL4NprY6+V4mHePuqLs7/t0kJh4R47nS6QS8iBgYTOGr
/9y0z3Rt7yCWo7xWSAwM/y87hSb1tBeGCUjhT9F2/K6lV9YAk1TBiErMmNfG8G3K
5+EQ8Kjlbfvi7x446QTIkKzEnidKqaazOlA5Hmp882a49gePoCoT6M+5/9okmt0m
FiJvjl5bS9t11Thdp59urZgls0jU+/DYzEB+W8SLDrBDiCrry5qTSCYietrrnJQi
e/ZoF9d7ffl0nYKKssLZRBZYkoJnjHoIun0k8yz34wFDQIP7K+iQNcPxkEY2rtUu
ZOZmyvPXE/50ui2lBdcbsTEatoR/KZGl4MWAODi5W212Shg424AbEfHZfFrgQsuS
ZzSrWDGDsasBYLk6xZ0EbgVKGLZQSZ1peGDpFYLzs+iBpgU3llCpQft0EkmjAf1o
BA7M2BiNMT4feoIcdf4hFT8kwl78VteL3ej4qz5ritp0s7yEak/KePCQ9P1+znZr
s32LiWHtKbbRKKNuFJ2Tp+Po6GkSc8kjvwTUsJgdgV/J2/qEJS3PEqIh7VbG+ZYL
7NSRtdHMICpcDyMik3yv
=q02B
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
