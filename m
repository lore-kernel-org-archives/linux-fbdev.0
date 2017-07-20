From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 20 Jul 2017 17:51:25 +0000
Subject: [PATCH 00/28] constify fbdev pci_device_id.
Message-Id: <1500572393-18844-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, paulus@samba.org, benh@kernel.crashing.org, adaplas@gmail.com, mbroemme@libmpq.org, FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Arvind Yadav (28):
  [PATCH 01/28] video: fbdev: radeon: constify pci_device_id.
  [PATCH 02/28] video: fbdev: atyfb: constify pci_device_id.
  [PATCH 03/28] video: fbdev: aty128fb: constify pci_device_id.
  [PATCH 04/28] video: fbdev: sunxvr2500: constify pci_device_id.
  [PATCH 05/28] video: fbdev: asiliantfb: constify pci_device_id.
  [PATCH 06/28] video: fbdev: intelfb: constify pci_device_id.
  [PATCH 07/28] video: fbdev: pvr2fb: constify pci_device_id.
  [PATCH 08/28] video: fbdev: tridentfb: constify pci_device_id.
  [PATCH 09/28] video: fbdev: skeletonfb: constify pci_device_id.
  [PATCH 10/28] video: fbdev: via: constify pci_device_id.
  [PATCH 11/28] video: fbdev: savage: constify pci_device_id.
  [PATCH 12/28] video: fbdev: riva: constify pci_device_id.
  [PATCH 13/28] video: fbdev: i810: constify pci_device_id.
  [PATCH 14/28] video: fbdev: arkfb: constify pci_device_id.
  [PATCH 15/28] video: fbdev: kyro: constify pci_device_id.
  [PATCH 16/28] video: fbdev: vermilion: constify pci_device_id.
  [PATCH 17/28] video: fbdev: nvidia: constify pci_device_id.
  [PATCH 18/28] video: fbdev: mb862xx: constify pci_device_id.
  [PATCH 19/28] video: fbdev: tdfx: constify pci_device_id.
  [PATCH 20/28] video: fbdev: sunxvr500: constify pci_device_id.
  [PATCH 21/28] video: fbdev: imsttfb: constify pci_device_id.
  [PATCH 22/28] video: fbdev: pm2fb: constify pci_device_id.
  [PATCH 23/28] video: fbdev: gxfb: constify pci_device_id.
  [PATCH 24/28] video: fbdev: neofb: constify pci_device_id.
  [PATCH 25/28] video: fbdev: s3fb: constify pci_device_id.
  [PATCH 26/28] video: fbdev: pm3fb: constify pci_device_id.
  [PATCH 27/28] video: fbdev: matroxfb: constify pci_device_id.
  [PATCH 28/28] video: fbdev: vt8623fb: constify pci_device_id.

 drivers/video/fbdev/arkfb.c                  | 2 +-
 drivers/video/fbdev/asiliantfb.c             | 2 +-
 drivers/video/fbdev/aty/aty128fb.c           | 2 +-
 drivers/video/fbdev/aty/atyfb_base.c         | 2 +-
 drivers/video/fbdev/aty/radeon_base.c        | 2 +-
 drivers/video/fbdev/geode/gxfb_core.c        | 2 +-
 drivers/video/fbdev/i810/i810_main.c         | 2 +-
 drivers/video/fbdev/imsttfb.c                | 2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c     | 2 +-
 drivers/video/fbdev/kyro/fbdev.c             | 2 +-
 drivers/video/fbdev/matrox/matroxfb_base.c   | 4 ++--
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c   | 2 +-
 drivers/video/fbdev/neofb.c                  | 2 +-
 drivers/video/fbdev/nvidia/nvidia.c          | 2 +-
 drivers/video/fbdev/pm2fb.c                  | 2 +-
 drivers/video/fbdev/pm3fb.c                  | 2 +-
 drivers/video/fbdev/pvr2fb.c                 | 2 +-
 drivers/video/fbdev/riva/fbdev.c             | 2 +-
 drivers/video/fbdev/s3fb.c                   | 2 +-
 drivers/video/fbdev/savage/savagefb_driver.c | 2 +-
 drivers/video/fbdev/skeletonfb.c             | 2 +-
 drivers/video/fbdev/sunxvr2500.c             | 2 +-
 drivers/video/fbdev/sunxvr500.c              | 2 +-
 drivers/video/fbdev/tdfxfb.c                 | 2 +-
 drivers/video/fbdev/tridentfb.c              | 2 +-
 drivers/video/fbdev/vermilion/vermilion.c    | 2 +-
 drivers/video/fbdev/via/via-core.c           | 2 +-
 drivers/video/fbdev/vt8623fb.c               | 2 +-
 28 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.7.4

