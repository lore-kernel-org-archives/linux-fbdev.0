From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 21 Apr 2016 14:53:15 +0000
Subject: [GIT PULL] fbdev fixes for 4.6
Message-Id: <5718E95B.8060009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="seref3BfSLJ3qrRrmplXbB4c2Mp5LoDKN"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--seref3BfSLJ3qrRrmplXbB4c2Mp5LoDKN
Content-Type: multipart/mixed; boundary="h6vjMj3Ut8p93TqCU26t667aeLXOtPci7"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <5718E95B.8060009@ti.com>
Subject: [GIT PULL] fbdev fixes for 4.6

--h6vjMj3Ut8p93TqCU26t667aeLXOtPci7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull these two fbdev fixes for 4.6.

 Tomi

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547=
c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.6

for you to fetch changes up to 4dacad61514494f2eba9e60d5b4aa71971dac6a1:

  omapfb: panel-sharp-ls037v7dw01: fix check of gpio_to_desc() return val=
ue (2016-04-18 12:18:37 +0300)

----------------------------------------------------------------
fbdev fixes for 4.6

* ARM CLCD: fix regression on multiplatform kernels
* panel-sharp-ls037v7dw01: fix possible NULL deref

----------------------------------------------------------------
Linus Walleij (1):
      video: ARM CLCD: runtime check for Versatile

Vladimir Zapolskiy (1):
      omapfb: panel-sharp-ls037v7dw01: fix check of gpio_to_desc() return=
 value

 drivers/video/fbdev/amba-clcd.c                           | 15 ++++++++-=
------
 .../fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c | 12 ++++-----=
---
 2 files changed, 12 insertions(+), 15 deletions(-)


--h6vjMj3Ut8p93TqCU26t667aeLXOtPci7--

--seref3BfSLJ3qrRrmplXbB4c2Mp5LoDKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXGOlbAAoJEPo9qoy8lh71uh8P/iPPxTd03bhfBEq2ISfLuzmk
LW6rfGhOPobs+t2UCOPLQcFlhIC3nmEssbacSJCepw0nkhVGbG1yJ3BayVfkYkUb
Um1q060atEdoPeRTUPky9Dvhwyphb1iWR5ykYJiL1SM9ixEzzKqOJY0nMfkEXTZs
mGvF5ypjLnSreEReZHdzGtz0OO4H7yltYajGuz6mJit1gpbmgDxwAMRHTfhxac9c
3vqH7QnbzB7d4r/NorfM0gcMLC6JEu/O0H8ZepMuA7cUYWQHV+h4tlnqrqLuqvB/
Zgb56+riu0DBiR8ajurA5wP9vSGtRpMxGNFhvQyxtiU5pn0Fqh0Q+IHMD8w+v198
C/+dfVudnOSPkFbd+JjfY4mbNeKcM3tz9Yp7tlyP20AtLY5Vqz17WsHQLYbN14ll
AD/zSb0I+BMAjUKWKa6lQggBf6ir2DYssCdp+7UCOkNN//PxSNRzNCQ8Eo6/auoD
wgyZancUygmAqL8ZUkZ8NqrLBfWAyOGkPm8pcoo0KBw4KXlw7Wk9yyYJ8sUe3s42
N0j/jk6bIhLDGGjuAkmm1y7wntba7BId7mU4I/xv7A2UNj2yOC7lMMOPSL93uadD
KCE08Nk17idtjv0qDHPlEzQWAUiwwtv23ZL27BYtjnznY5/28FN0Y/t7nBcJbbM8
qmJ2nQ9j6ayuLJ6s2qNW
=T3Qf
-----END PGP SIGNATURE-----

--seref3BfSLJ3qrRrmplXbB4c2Mp5LoDKN--
