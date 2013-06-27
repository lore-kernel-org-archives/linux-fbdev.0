From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 27 Jun 2013 09:03:14 +0000
Subject: [GIT PULL] various small fbdev changes for 3.11
Message-Id: <51CBFFD2.3040908@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2RJMGAWRIQELQGXOXKERT"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

------enig2RJMGAWRIQELQGXOXKERT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The following changes since commit ffa3fd21de8ab0db7962b612d4c6e17c0d88e9=
c2:

  videomode: implement public of_get_display_timing() (2013-05-28 14:42:5=
2 +0300)

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git tags/fbdev-3.11-2

for you to fetch changes up to 464d8a54a0ca7827a2278e2122e5eb22462ae044:

  video: i740fb: Make i740fb_init static (2013-06-27 11:57:30 +0300)

----------------------------------------------------------------
Various fbdev changes for 3.11

* xilinxfb updates
* Small cleanups and fixes to multiple drivers

----------------------------------------------------------------
Borislav Petkov (1):
      uvesafb: Correct/simplify warning message

Dan Carpenter (1):
      fbmem: return -EFAULT on copy_to_user() failure

Fabio Estevam (1):
      video: of_display_timing.h: Declare 'display_timing'

Jingoo Han (2):
      video: remove unnecessary platform_set_drvdata()
      video: replace strict_strtoul() with kstrtoul()

Lars-Peter Clausen (1):
      fbdev: bfin-lq035q1-fb: Use dev_pm_ops

Michal Simek (7):
      video: xilinxfb: Fix OF probing on little-endian systems
      video: xilinxfb: Do not name out_be32 in function name
      video: xilinxfb: Rename PLB_ACCESS_FLAG to BUS_ACCESS_FLAG
      video: xilinxfb: Use drvdata->regs_phys instead of physaddr
      video: xilinxfb: Group bus initialization
      video: xilinxfb: Add support for little endian accesses
      video: xilinxfb: Use driver for Xilinx ARM Zynq

Randy Dunlap (2):
      fb: fix atyfb build warning
      fb: fix atyfb unused data warnings

Sachin Kamat (5):
      video: smscufx: Use NULL instead of 0
      video: udlfb: Use NULL instead of 0
      video: udlfb: Make local symbol static
      video: imxfb: Make local symbols static
      video: i740fb: Make i740fb_init static

Tomi Valkeinen (1):
      OMAPDSS: DPI: Fix wrong pixel clock limit

Wei Yongjun (1):
      video: mxsfb: remove redundant dev_err call in mxsfb_probe()

Yijing Wang (2):
      aty128fb: use pdev->pm_cap instead of pci_find_capability(..,PCI_CA=
P_ID_PM)
      radeon: use pdev->pm_cap instead of pci_find_capability(..,PCI_CAP_=
ID_PM)

 drivers/video/Kconfig                     |   2 +-
 drivers/video/aty/aty128fb.c              |   2 +-
 drivers/video/aty/atyfb_base.c            |   9 +-
 drivers/video/aty/radeon_pm.c             |   2 +-
 drivers/video/au1100fb.c                  |   1 -
 drivers/video/bf54x-lq043fb.c             |   1 -
 drivers/video/bfin-lq035q1-fb.c           |  24 +++---
 drivers/video/bfin-t350mcqb-fb.c          |   2 -
 drivers/video/ep93xx-fb.c                 |   2 -
 drivers/video/fbmem.c                     |   4 +-
 drivers/video/fsl-diu-fb.c                |   4 +-
 drivers/video/i740fb.c                    |   2 +-
 drivers/video/imxfb.c                     |   7 +-
 drivers/video/jz4740_fb.c                 |   2 -
 drivers/video/mmp/fb/mmpfb.c              |   1 -
 drivers/video/mmp/hw/mmp_ctrl.c           |   1 -
 drivers/video/mxsfb.c                     |   3 -
 drivers/video/nuc900fb.c                  |   1 -
 drivers/video/omap2/displays/panel-taal.c |   6 +-
 drivers/video/omap2/dss/dpi.c             |   4 +-
 drivers/video/pxa3xx-gcu.c                |   2 -
 drivers/video/pxafb.c                     |   1 -
 drivers/video/s3c2410fb.c                 |   2 -
 drivers/video/sa1100fb.c                  |   1 -
 drivers/video/sh7760fb.c                  |   1 -
 drivers/video/sh_mipi_dsi.c               |   1 -
 drivers/video/smscufx.c                   |   2 +-
 drivers/video/tmiofb.c                    |   3 -
 drivers/video/udlfb.c                     |  12 +--
 drivers/video/uvesafb.c                   |   4 +-
 drivers/video/vga16fb.c                   |   1 -
 drivers/video/vt8500lcdfb.c               |   1 -
 drivers/video/wm8505fb.c                  |   2 +-
 drivers/video/xilinxfb.c                  | 135 +++++++++++++++---------=
------
 include/video/of_display_timing.h         |   1 +
 35 files changed, 113 insertions(+), 136 deletions(-)


------enig2RJMGAWRIQELQGXOXKERT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRy//SAAoJEPo9qoy8lh71uF4P/1bOQVUyn7/cLS5oZN+GEqAp
74V0EB1uGpxTTbfP3TQ8ELFBV75n0a61iSfVYhNleptUtFOUdm3k7cnUs+MqzcZQ
/yYjtBHXVqMttIAuyYAWQEZDdwMcsp8pfehUgGjJQMEz4vbOBdhhcE42k62RGxIT
6NPIEmOS9RohCBTF7/W0OpSCbH3Kaq8mv1XbZjjSuldmLqYQ2LHjrPu+bv4gb0UB
QvD5OpN5uZQHtjUn2S1mylck0jhV8kCqhNucCSWGscvdzDYARsLzYvV1Ali5E9IJ
J2CdgPP/uUipyubxUs2r6w79I+aW/KEmaKSkmCSdcfvGotsjMdDs+9M78xtWK6jj
r/HshBlEuxghCCuQBSuFnHP3RRe2wGFDEl3PMJXrxht6BkIoqvmfxvkdpSqe4ev7
/cwzZN6KVhhtMuhEYiKzpTvc6TXrLZYzh3j7CuVzZ1XxRQjUatnA6GZJuXOtE/ef
namatC18dApU5U0IGTcg3c8kLni7UE2IlzTmj4nLGUjj8kvPu7T8MJW6Aa+7myW5
SqyT44eBH5yM1AKO3WCi0OuLAgq9g1+xRr8dunWGDaJoiDmvkr+TvZqpoNzhAtSz
9BbRuwD2bjR2ry5dtzu8VhG9Vi0NUQS0aCAJay9NzrfGkVHv+zBsg3RRvJ5eJ7ri
F/KF+7KrvHBSg3WzWhVe
=RtzW
-----END PGP SIGNATURE-----

------enig2RJMGAWRIQELQGXOXKERT--
