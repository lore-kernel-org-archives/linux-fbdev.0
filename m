From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Aug 2015 13:07:12 +0000
Subject: [GIT PULL] fbdev fixes for 4.2-rc7
Message-Id: <55C9F380.9080908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oTalM7FsiSicGs9sostnA0QE6eB9eRB8t"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--oTalM7FsiSicGs9sostnA0QE6eB9eRB8t
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit f7644cbfcdf03528f0f450f3940c4985b2291f=
49:

  Linux 4.2-rc6 (2015-08-09 15:54:30 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.2

for you to fetch changes up to 2a17d7e80f1df44d6b94c3696d5eda44fe6638a8:

  fbcon: unconditionally initialize cursor blink interval (2015-08-10 17:=
20:32 +0300)

----------------------------------------------------------------
fbdev fixes for 4.2

* Fix display regression on Versatile boards
* Fix OF node refcount bugs on omapdss
* fix WARN about clock prepare on pxa3xx_gcu
* Fix mem leak in videomode helpers
* Fix fbconsole related boot problem on sun7i-a20-olinuxino-micro

----------------------------------------------------------------
Christian Engelmayer (1):
      video: Fix possible leak in of_get_videomode()

Jyri Sarha (2):
      OMAPDSS: Fix node refcount leak in omapdss_of_get_next_port()
      OMAPDSS: Fix omap_dss_find_output_by_port_node() port refcount decr=
ement

Linus Walleij (1):
      fbdev: select versatile helpers for the integrator

Robert Jarzmik (1):
      video: fbdev: pxa3xx_gcu: prepare the clocks

Scot Doyle (1):
      fbcon: unconditionally initialize cursor blink interval

 drivers/video/console/fbcon.c          | 3 ++-
 drivers/video/fbdev/Kconfig            | 2 +-
 drivers/video/fbdev/omap2/dss/dss-of.c | 4 +++-
 drivers/video/fbdev/pxa3xx-gcu.c       | 4 ++--
 drivers/video/of_videomode.c           | 4 +---
 5 files changed, 9 insertions(+), 8 deletions(-)


--oTalM7FsiSicGs9sostnA0QE6eB9eRB8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyfOAAAoJEPo9qoy8lh71u9gQAJ/xJQ9UgZsr+RPit1yvZJQL
w949OxL6pe5b1iIFc1eKNkC29rTXlYxrtojW+AD9yjhSAV33Kw8443eqsjOWLUbL
B/RoPrCZbLA2UXDpCDIRY/BUGsu09MDuKxxVBCfzNbvmowrrgbfJ+Knh+yoK/iT6
U/Y/mDw9z712muAHNaphcNea8DF3cAhHUxYcypp6Sgi1qZxPeiZ1LVwJWTweCfnz
Om/LZNMM2gJ+YFcEUAooUbvmRFMZ+/nXFoFvio8HNht2ueacA/hjQLO/SGKLze2O
rRD70ue9j4wwG+AmZejT01Nsmd/wbUbJnWH6MMDYYQAQZc5Kbtsdr6yB61HB1qak
x3VX/6OkNxL+sUTTQU3r0tWF4tbUD++UJ7WXjoL288NvvmvRT4miRtI/AC7RyE8q
f8fUCSzu7x5DBvXYvQuI5AEy6HNJRQUi0ACY9IdK0/5FcRM8jeQ+NLbQF6wde3iP
aGTkWBsQ/OxFJJcIPyz77QYf93naNMiRTevOfajHgLj6IN+mjnLl0sM8O+13o//R
xqerW7uotDseTcg1hu+C//3n1XCzIFkkbO0L/UgkkjWWwk6FkivmEzWev5qwH6VC
tPM2SjnaLBHjPrPgWLHFyzWDtO3st7V7FynlZxOb+7Wd5v0az955xQSDrXd+X2/6
F3eAI/5Lw0KJm2Mhi7qj
=/kBL
-----END PGP SIGNATURE-----

--oTalM7FsiSicGs9sostnA0QE6eB9eRB8t--
