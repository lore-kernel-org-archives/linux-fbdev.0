From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 24 Mar 2020 13:45:02 +0000
Subject: [PATCH v2 0/6] video: fbdev: controlfb: small cleanup
Message-Id: <20200324134508.25120-1-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200324134518eucas1p1440c92398ddcbe5ea72d6db3703d3f97@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Sam Ravnborg <sam@ravnborg.org>, b.zolnierkie@samsung.com

Hi,

Small cleanup for controlfb driver:

- fix sparse warnings
- remove not working module support
- add COMPILE_TEST support
- remove redundant function prototypes

Changes since v1
(https://lore.kernel.org/lkml/20200116140900.26363-1-b.zolnierkie@samsung.com/):
- use in_le32() instead of le32_to_cpup()
- use eieio() and dcbf() helpers
- add invalid_vram_cache() helper
- add more dummy CONFIG_PPC_PMAC=n helpers to avoid ifdefs
- add ACKs from Sam

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (6):
  video: fbdev: controlfb: fix sparse warning about using incorrect type
  video: fbdev: controlfb: add COMPILE_TEST support
  video: fbdev: controlfb: remove obsolete module support
  video: fbdev: controlfb: remove function prototypes part #1
  video: fbdev: controlfb: remove function prototypes part #2
  video: fbdev: controlfb: remove function prototypes part #3

 drivers/video/fbdev/Kconfig     |   2 +-
 drivers/video/fbdev/controlfb.c | 828 +++++++++++++++-----------------
 2 files changed, 391 insertions(+), 439 deletions(-)

-- 
2.24.1
