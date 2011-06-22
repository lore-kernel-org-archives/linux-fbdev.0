From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 22 Jun 2011 07:49:47 +0000
Subject: [PATCH 0/5 v3] LCDC MERAM runtime PM support
Message-Id: <1308728992-9660-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series is a provides PM runtime support for the LCDC MERAM.

The runtime_pm_get/put calls are made at the same time as the LCDC calls, so
that the LCDC MERAM is enabled with the first LCDC device and disabled 
with the last LCDC device.

The first 4 patches will apply to rmobile-latest or common/fbdev-meram as-is,
but the final patch needs to have the "PM / Domains: Support for generic I/O PM
domains" patch series. 

Changes from V2

* Change the names of the clk_on/clk_off callbacks to pm_get_sync/pm_put_sync
  to better reflect their actual functionality

* Make these callback functions static

* The private data structure definition was moved from sh_mobile_meram.h to
  sh_mobile_meram.c.  This has been moved into a separate patch

* Use the sh7372_add_device_to_domain() function to register the MERAM in
  the SH7372_A4LC domain.

Damian Hobson-Garcia (5):
  fbdev: sh_mobile_meram: Add enable/disble hooks for LCDC
  fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC
  fbdev: sh_mobile_meram: Move private data from .h to .c
  fbdev: sh_mobile_meram: Backup/restore device registers on
    shutdown/resume
  fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain

 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 drivers/video/sh_mobile_lcdcfb.c        |   10 +++
 drivers/video/sh_mobile_meram.c         |  106 +++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h         |    8 ---
 include/video/sh_mobile_meram.h         |    6 ++
 5 files changed, 123 insertions(+), 8 deletions(-)

