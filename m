From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 03 Jul 2015 08:16:23 +0000
Subject: [GIT PULL] fbdev fixes for 4.2
Message-Id: <559644D7.4000109@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RiTjTTSR14D65vbRj3M11Sm1rU4EUEegr"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--RiTjTTSR14D65vbRj3M11Sm1rU4EUEegr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit f778dad38a54ca5207d024b5ebe0e6d71b8bad=
83:

  Merge omapdss scaling fixes (2015-06-22 14:56:01 +0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.2

for you to fetch changes up to 0438ec90b17963662ef619b71c77c5c135b07014:

  OMAPDSS: fix probing if rfbi device is enabled (2015-07-02 15:20:10 +03=
00)

----------------------------------------------------------------
fbdev fixes for 4.2

* Fix display regression on TI AM4xxx boards

----------------------------------------------------------------
Tomi Valkeinen (1):
      OMAPDSS: fix probing if rfbi device is enabled

 drivers/video/fbdev/omap2/dss/dss.c | 9 +++++++++
 1 file changed, 9 insertions(+)


--RiTjTTSR14D65vbRj3M11Sm1rU4EUEegr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVlkTXAAoJEPo9qoy8lh71lQkP/0HgduuF0pQCzDqsbWF9DuXG
Uw6OEU/d+rjOS2RQC7xkJ1yRm1rzWRmsALC/WHxy4WOZNsZrvi1qAdYfRJ72suIm
N8uqG1Qt54prXWbnhSBTlmmu7TpxFlqVmKplIRDFupO89K6n4ndjrBvj+uxMRiYh
kLQo8TSRkgQ1CQ8fiWdwi4WNPTLj5Kl/D2cIezJvB+Zo8/GHNcPh79amOR0uL3Sm
QfjZ2p8tuPqUFnFd4TimLVOdzy7Ljv41FS6JGU/qa4ioog9Um83242HVwFyFPVZs
HpGyZHx+szbNnZY4MMCO0zvnXaCMx3tzvkP6Xo9HwTVz3LlISA5MpInEZJKaozxD
bx1R563E68Cq1L3b6VUGWGbCBiIT34K2+Oo2Ttb3Jp+1UVkMGtEg7kOKhtUpaxc9
tzKKmnkQCtjbZRNbCsOBqjU18PBU4l5T9Tcl4IBQWMWnXu+EwfNJKcP0yEOHYhpv
ajIJ7+qz5vhBGeAYok9sA7NlBfX2gHVDDlmKF1A3QX+Tohof/HDYCmOLByolrpQJ
nozSxoV18huK//D/zz1QVrHKVLy3oETJJfLEvA2Ij4QgzEJZJN+bYEwaW6oUVv8o
lQavuq0Xf6pWSgE8NWfmANZIV8mhS9fTphzh9nq/hufnv2dA4Q7Mt2yL9O8mYJ0v
tWrrvwn3AwY1N1v5WMv2
=69OE
-----END PGP SIGNATURE-----

--RiTjTTSR14D65vbRj3M11Sm1rU4EUEegr--
