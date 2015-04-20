From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 20 Apr 2015 12:39:25 +0000
Subject: [GIT PULL] fbdev changes for 4.1
Message-Id: <5534F37D.5000609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9rujAAmu0pEDVqdFP4phMEoU5n1aPvtLS"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--9rujAAmu0pEDVqdFP4phMEoU5n1aPvtLS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev changes for 4.1.

 Tomi

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff5=
39:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.1

for you to fetch changes up to 6b75b54c841a18ef114704aa5cf2cdf43487b0ae:

  Merge omapdss topic branch for fbdev 4.1 (2015-04-20 12:09:31 +0300)

----------------------------------------------------------------
fbdev changes for v4.1

* Small fixes and improvements to various fbdev drivers

----------------------------------------------------------------
Dan Carpenter (1):
      fbdev: pm3fb: cleanup some confusing indenting

Geert Uytterhoeven (1):
      fbdev: sh_mobile_lcdc: Fix destruction of uninitialized mutex

Grygorii Strashko (1):
      omapdss: extend pm notifier to handle hibernation

Javier Martinez Canillas (1):
      OMAPDSS: Correct video ports description file path in DT binding do=
c

Lad, Prabhakar (1):
      fbdev: via/via_clock: fix sparse warning

Laurent Pinchart (1):
      video: fbdev: sh_mobile_lcdcfb: Fix ROP3 sysfs attribute parsing

Nicholas Mc Guire (2):
      video: fbdev: use msecs_to_jiffies for time conversions
      hyperv: hyperv_fb: match wait_for_completion_timeout return type

Sanjeev Sharma (1):
      video: fbdev: make of_device_id array const

Sudip Mukherjee (1):
      fbdev: sm501fb: use memset_io

Tomi Valkeinen (15):
      OMAPDSS: fix AM43xx minimum pixel clock divider
      OMAPDSS: HDMI5: Increase DDC SDA-HOLD time
      OMAPDSS: fix paddr check for TILER addresses
      OMAPDSS: TFP410: fix input sync signals
      OMAPDSS: DISPC: remove OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES
      OMAPDSS: DISPC: explicit handling for sync and de levels
      OMAPDSS: change signal_level & signal_edge enum values
      OMAPDSS: DISPC: change sync_pclk_edge default value
      OMAPDSS: DISPC: fix div by zero issue in overlay scaling
      OMAPDSS: DISPC: lock access to DISPC_CONTROL & DISPC_CONFIG
      OMAPDSS: setup default fifo thresholds
      OMAPDSS: Add support for MFLAG
      OMAPDSS: workaround for MFLAG + NV12 issue
      OMAPDSS: disable VT switch
      Merge omapdss topic branch for fbdev 4.1

 .../devicetree/bindings/video/ti,omap-dss.txt      |   4 +-
 drivers/gpu/drm/omapdrm/omap_connector.c           |   2 +-
 drivers/video/fbdev/hyperv_fb.c                    |   6 +-
 drivers/video/fbdev/imxfb.c                        |   2 +-
 .../video/fbdev/omap2/displays-new/connector-dvi.c |   2 +-
 .../fbdev/omap2/displays-new/encoder-tfp410.c      |  11 ++
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  |   2 +-
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   |   2 +-
 .../omap2/displays-new/panel-sony-acx565akm.c      |   2 +-
 .../omap2/displays-new/panel-tpo-td028ttec1.c      |   2 +-
 .../omap2/displays-new/panel-tpo-td043mtea1.c      |   2 +-
 drivers/video/fbdev/omap2/dss/core.c               |   4 +
 drivers/video/fbdev/omap2/dss/dispc.c              | 147 +++++++++++++++=
++++--
 drivers/video/fbdev/omap2/dss/display.c            |   2 +-
 drivers/video/fbdev/omap2/dss/dsi.c                |   2 +-
 drivers/video/fbdev/omap2/dss/dss.c                |   3 +
 drivers/video/fbdev/omap2/dss/dss_features.c       |   2 +-
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |   2 +-
 drivers/video/fbdev/omap2/dss/rfbi.c               |   2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |   4 +-
 drivers/video/fbdev/pm3fb.c                        |   6 +-
 drivers/video/fbdev/pxafb.c                        |   6 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |  15 ++-
 drivers/video/fbdev/sm501fb.c                      |   2 +-
 drivers/video/fbdev/via/via_clock.c                |   2 +-
 include/video/omapdss.h                            |   7 +-
 26 files changed, 193 insertions(+), 50 deletions(-)


--9rujAAmu0pEDVqdFP4phMEoU5n1aPvtLS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVNPOcAAoJEPo9qoy8lh7129cP/0sWeWInlt1oohXYp5JYjb0A
Mdr2ouI3vCDbjcpUFIbBEbbyPlAEJ5V5TjXDygwmUht7xSlpH5iyd0ixT3WAOZwf
Va3qx91bQ3nAw3yPDaWpwFcuFbowm1hl+bWujLUrWQ+KROb78sBHiB6v1RJEIU3l
zZgRAj11pouo69Dl0GBq1DLtzJ/Enld0FStriyG8YoAXFpDkCRpnEeu/O0FLBsQ1
8R18lJm7y7WvFzSHNP+I6IiBa+sIvakZR+uiRDvsxvhHMh0Nld4J1Y4ckeWeHrHZ
l6Vxvc6Ef3wWWPEqhYF4FrxSaUx27Lr7e/71l0q0vl0h3Y1arYX9d0bEuk3Fh2C/
RZGNYtn8CuzWMBET5isiycncSME6UoHY5lsLQhGqPPCAVGcGV5ggLHG2U4qw4/8B
2v1lUJxtmYYKOM0hA0udlcF3Zl31pIF61k+uhT2N8kalJzHzJy6Wemr8xCYJPFa3
9sMWSW7VWyInYonFWzo64ESbsVP5Oxm5f7MwWoReNCqe/mkRYAv5CtB3lJ/Nl4b4
UEb7yBvIWcmTsXDcnR4xEMbgvCEyswKBoheaMgkEK1nXSbyk9kPufdUk+Pl87SGO
MDGehyGb5iwotynzrefqEfCwnUskIfc2BZJKPUlHyJOrwrJJexq4HX/jQSJTcN5+
JULXqdDxgF57k9iIUKCQ
=peyt
-----END PGP SIGNATURE-----

--9rujAAmu0pEDVqdFP4phMEoU5n1aPvtLS--
