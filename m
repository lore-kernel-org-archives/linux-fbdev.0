From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 11 Feb 2015 09:35:54 +0000
Subject: [GIT PULL] fbdev changes for 3.20
Message-Id: <54DB227A.8090409@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GweXTj9K07Q2xgcOBHN4vI2r1vCE1nQhP"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--GweXTj9K07Q2xgcOBHN4vI2r1vCE1nQhP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev changes for 3.20.

 Tomi

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d1861=
15:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-3.20

for you to fetch changes up to d6c2152b3efd73be265f426b5a1bb50ec436d999:

  Merge branches '3.20/fbdev' and '3.20/omapdss' into for-next (2015-02-0=
4 12:44:11 +0200)

----------------------------------------------------------------
fbdev changes for v3.20

* omapdss: add DRA7xxx SoC support
* fbdev: support DMT (Display Monitor Timing) calculation

----------------------------------------------------------------
Arnd Bergmann (2):
      fb: via: turn gpiolib and i2c selects into dependencies
      video/mmpfb: allow modular build

Asaf Vertz (1):
      fbdev: vgastate: remove trailing whitespaces

David Ung (4):
      video: fbdev: Add additional vesa modes
      video: fbdev: Check Standard Timing against DMT
      video: fbdev: Validate mode timing against monspec
      video: fbdev: Fix sparse warning messages

Geert Uytterhoeven (2):
      console/dummy: Move screen size selection from CPP to Kconfig
      video: Drop superfluous "select VT_HW_CONSOLE_BINDING"

Lad, Prabhakar (2):
      fbdev: ssd1307fb: drop unused function ssd1307fb_write_data()
      fbdev: ssd1307fb: set default height if not found in DT node

Mans Rullgard (1):
      video: fbdev: fix sys_copyarea

Marek Belisko (2):
      video: omapdss: Add opa362 driver
      Documentation: DT: Add documentation for ti,opa362 bindings

Mathias Krause (1):
      atyfb: mark DMI system id table as __initconst

Peter Meerwald (1):
      omapfb: Return error code when applying overlay settings fails

Prabhakar Lad (1):
      fbdev: ssd1307fb: return proper error code if write command fails

Qiang Chen (1):
      video: ocfb: Fix data type warning

Rasmus Villemoes (1):
      fbdev: omap2: Fix typo in tvc_probe_pdata

Scot Doyle (1):
      fbcon: Remove unused vblank cursor code

Sudip Mukherjee (5):
      fbdev: geocode: remove unneeded NULL check
      fbdev: geocode: remove unneeded NULL check
      fbdev: savage: remove unused variable
      video: vt8500lcdfb: remove unneeded continue
      video: hgafb: remove unneeded comparison

Tomi Valkeinen (16):
      fbdev: fix CVT vertical front and back porch values
      OMAPDSS: Add enum dss_pll_id
      OMAPDSS: PLL: add dss_pll_wait_reset_done()
      OMAPDSS: constify port arrays
      OMAPDSS: OMAP5: fix digit output's allowed mgrs
      OMAPDSS: encoder-tpd12s015: Fix race issue with LS_OE
      OMAPDSS: add define for DRA7xx HW version
      Doc/DT: Add DT binding doc for DRA7xx DSS
      OMAPDSS: DSS: Add DRA7xx base support
      OMAPDSS: Add functions for external control of PLL
      OMAPDSS: Add Video PLLs for DRA7xx
      OMAPDSS: DISPC: Add DRA7xx support
      OMAPDSS: DISPC: program dispc polarities to control module
      OMAPDSS: HDMI: Add DRA7xx support
      OMAPDSS: DPI: DRA7xx support
      Merge branches '3.20/fbdev' and '3.20/omapdss' into for-next

 .../devicetree/bindings/video/ti,dra7-dss.txt      |  69 +++++
 .../devicetree/bindings/video/ti,opa362.txt        |  38 +++
 drivers/video/console/Kconfig                      |  16 +-
 drivers/video/console/dummycon.c                   |   5 +-
 drivers/video/console/fbcon.c                      |   4 -
 drivers/video/fbdev/Kconfig                        |   5 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   9 +-
 drivers/video/fbdev/core/fbcvt.c                   |   6 +-
 drivers/video/fbdev/core/fbmon.c                   | 103 ++++----
 drivers/video/fbdev/core/modedb.c                  | 111 ++++++++
 drivers/video/fbdev/core/syscopyarea.c             | 137 +++++-----
 drivers/video/fbdev/geode/gx1fb_core.c             |   6 +-
 drivers/video/fbdev/geode/gxfb_core.c              |   6 +-
 drivers/video/fbdev/geode/lxfb_core.c              |   6 +-
 drivers/video/fbdev/hgafb.c                        |   3 +-
 drivers/video/fbdev/mmp/Makefile                   |   4 +-
 drivers/video/fbdev/mmp/fb/Kconfig                 |   2 +-
 drivers/video/fbdev/ocfb.c                         |   2 +-
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/connector-analog-tv.c |   2 +-
 .../fbdev/omap2/displays-new/encoder-opa362.c      | 285 +++++++++++++++=
++++++
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |  57 +----
 drivers/video/fbdev/omap2/dss/Makefile             |   2 +-
 drivers/video/fbdev/omap2/dss/dispc.c              |  54 ++++
 drivers/video/fbdev/omap2/dss/dpi.c                |  26 ++
 drivers/video/fbdev/omap2/dss/dsi.c                |   1 +
 drivers/video/fbdev/omap2/dss/dss.c                | 219 +++++++++++++++=
-
 drivers/video/fbdev/omap2/dss/dss.h                |  22 ++
 drivers/video/fbdev/omap2/dss/dss_features.c       |   3 +-
 drivers/video/fbdev/omap2/dss/hdmi5.c              |   1 +
 drivers/video/fbdev/omap2/dss/hdmi_phy.c           |   1 +
 drivers/video/fbdev/omap2/dss/hdmi_pll.c           |   6 +
 drivers/video/fbdev/omap2/dss/omapdss-boot-init.c  |   1 +
 drivers/video/fbdev/omap2/dss/pll.c                |  10 +
 drivers/video/fbdev/omap2/dss/video-pll.c          | 211 +++++++++++++++=

 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |   7 +-
 drivers/video/fbdev/savage/savagefb.h              |  12 +-
 drivers/video/fbdev/ssd1307fb.c                    |  86 ++++---
 drivers/video/fbdev/vt8500lcdfb.c                  |   4 +-
 drivers/video/vgastate.c                           |  82 +++---
 include/linux/fb.h                                 |  12 +-
 include/video/omapdss.h                            |   1 +
 43 files changed, 1342 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/ti,dra7-dss.t=
xt
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt=

 create mode 100644 drivers/video/fbdev/omap2/displays-new/encoder-opa362=
=2Ec
 create mode 100644 drivers/video/fbdev/omap2/dss/video-pll.c


--GweXTj9K07Q2xgcOBHN4vI2r1vCE1nQhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2yJ6AAoJEPo9qoy8lh71sA4P/jXUVG11ZzZPE91JjrqAtmrw
l0S3FIFC4Nhy3jjzLYTKuMGrKazZrxO7gtBzZSUfXborDuKExnfbgSWFNl6LWS8j
EHW4BOkuPd3UqriC2VcUWm5mSH3yYIHhCK88i9jMDt2ZWQ+U0CmmX0QG8/ItHNdw
RvIl73M8vrr5OBpaU//ilyuNbR98MyoBIIC1CpVCzSoXEFwXOUF6BgStqzmsl0SC
+hJPI4/RDcc1LiBxk1rfccJk29ePV5GsSJfl0kv2X9fSHxSAlq92OVXIkaEXRjV1
71f5N7/0aZuyBtzsEQZJiVdkB1p6PIADLzbhTgFnLLNulBYBzs4ExdXzYovghrab
K/BHol4sFc5GteSAHz8UUuP2TEW6UTv2lttTcWWNWawSoP6joJmJOR7P6GxzE9rs
lPdf8BImUMpTo2mTEuGH3eW5WX7HY55otVBI7+GzXSVVfjOI9LKEGWqw8s1j8XzI
rKDPJ9pokWN7WwzT177ovv/i7XaeLTGwtPEEFNej+ibusO4ytq25kpxHbU2oKksN
E6oJDgxTZwk7nVJn1PLPejuu4tYLvCfyWecBRkTJqbiwxyB3SsNlxKvwc16FsCSZ
jOTg6FntqM9OGBbp4F+AmdAWnGlsT0MffN9/u+ncbIGTj2l9mNFUEUagWeHk0YTY
LcaWpFfwTQTDexEG1c1/
=blvg
-----END PGP SIGNATURE-----

--GweXTj9K07Q2xgcOBHN4vI2r1vCE1nQhP--
