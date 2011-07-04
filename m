From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 04 Jul 2011 08:05:28 +0000
Subject: [PATCH 0/5 v4] LCDC MERAM runtime PM support
Message-Id: <1309766728-32419-1-git-send-email-dhobsong@igel.co.jp>
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

Only the first 2 patches of the series have been updated from v3 sent on
2011/06/22

Changes from V3

* Remove the MERAM callbacks used to runtime_get/runtime_put the device from
  the LCDC driver.  Instead, just call the functions on the MERAM device
  directly

Damian Hobson-Garcia (5):
  fbdev: sh_mobile_meram: Enable runtime PM
  fbdev: sh_mobile_meram: Enable/disable MERAM along with LCDC - v4
  fbdev: sh_mobile_meram: Move private data from .h to .c 
  fbdev: sh_mobile_meram: Backup/restore device registers on
    shutdown/resume - v3
  fbdev: sh_mobile_meram: Assign meram to the SH7372_A4LC power domain

 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 drivers/video/sh_mobile_lcdcfb.c        |    6 ++
 drivers/video/sh_mobile_meram.c         |   84 +++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h         |    8 ---
 4 files changed, 91 insertions(+), 8 deletions(-)

