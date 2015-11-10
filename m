From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Nov 2015 11:31:39 +0000
Subject: [GIT PULL] fbdev changes for 4.4
Message-Id: <5641D59B.40707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="prLGfJwnudTlsvr9ATWDGCUUCmvrjiGJt"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--prLGfJwnudTlsvr9ATWDGCUUCmvrjiGJt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev changes for 4.4.

 Tomi

The following changes since commit 1f93e4a96c9109378204c147b3eec0d0e8100f=
de:

  Linux 4.3-rc2 (2015-09-20 14:32:34 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.4

for you to fetch changes up to 08bfb453f0458dd353f37737d80475ff13868d9c:

  radeonfb: Deinline large functions (2015-10-08 12:24:12 +0300)

----------------------------------------------------------------
fbdev changes for 4.4

* omap: fix hdmi audio configuration issue
* ssd1307fb: add ssd1309 support
* tridentfb: support DDC
* gxt4500: enable support for non-PPC platforms

----------------------------------------------------------------
Andrzej Hajda (1):
      video/omap: remove invalid check

Denys Vlasenko (1):
      radeonfb: Deinline large functions

Jyri Sarha (1):
      OMAPDSS: hdmi: Reconfigure and restart audio when display is enable=
d

Olliver Schinagl (2):
      fbdev: ssd1307fb: alphabetize headers
      fbdev: ssd1307fb: add ssd1309 support

Ondrej Zary (7):
      fb_ddc: Allow I2C adapters without SCL read capability
      tridentfb: Add DDC support
      gxt4500: enable on non-PPC architectures
      gxt4500: fix 16bpp 565 mode
      gxt4500: fix color order
      gxt4500: Use arch_phys_wc_* for framebuffer
      gxt4500: enable panning

 .../devicetree/bindings/video/ssd1307fb.txt        |   3 +-
 drivers/video/fbdev/Kconfig                        |   7 +-
 drivers/video/fbdev/aty/radeon_base.c              | 133 ++++++++++++++-=

 drivers/video/fbdev/aty/radeonfb.h                 | 144 ++-------------=
-
 drivers/video/fbdev/core/fb_ddc.c                  |  28 ++--
 drivers/video/fbdev/gxt4500.c                      |  25 ++-
 drivers/video/fbdev/omap/omapfb_main.c             |   5 -
 drivers/video/fbdev/omap2/dss/hdmi.h               |   9 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  66 ++++++--
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  75 +++++++--
 drivers/video/fbdev/ssd1307fb.c                    |  21 ++-
 drivers/video/fbdev/tridentfb.c                    | 182 +++++++++++++++=
+++++-
 12 files changed, 506 insertions(+), 192 deletions(-)


--prLGfJwnudTlsvr9ATWDGCUUCmvrjiGJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWQdWbAAoJEPo9qoy8lh711w8P/2ngklCEpXUNNAQ19MNShwOR
aePKFxBXcvRDiWAnSCTkjmaX859fupffOWIjZlYvmTqqMF31WSPG+lAHFFoeV8Sx
YtyRslqcg2cnyK2IfLtyDwEoT20SOtmxn//StYBcu24W8h7X1FEuqQgpgDt/VRDZ
wkI+/63eFzfWD2/F+y/9+FHUtZleES5oU1V+R6dnMM4t3sZ5yvicV2Evy4cjYvjo
G5Fx62ywuGCDdre/60JkFTzAbmnjxE/9wegerXWjxDUC4rn/k/b75bHXc1hnsRpx
n/fQnjXjVYJ8Tu/eDMdKrwfKmRyCPXl+I05e1xWNCn1OeKexcSJRenyka5+vwAbt
jFE+hK+izJpgSQKwvTKzpjUGUdupgwAEj5BJPJvIikLFqByWrqP6WxsAjOoG6Uxe
Fe/GpE23V2yhm3FNtSe+oc28DCogTQj+8cFVhHmLVXjM2VOBoe5Vz92JUQIw4foL
Q1Rcb+TZDgrF8GzNAWb5JNOc9OVjMC+iEi0pDsW+rP653AJOrRj8qeMjINWhYfBk
dLefFzKN1hRmb49d403Y2TabcAQX3cVUgryOgvvwQGaJKcO8RIdJEWjTj+G/Qwmj
6+PVuoqfZTxIK/eS9/V1dJ6Mf1a4jYqG25NFcyWvidJZ4DAwHGzIe2BLiR+YLBc7
lw33HNA48K3jiMxGWRRT
=GyG0
-----END PGP SIGNATURE-----

--prLGfJwnudTlsvr9ATWDGCUUCmvrjiGJt--
