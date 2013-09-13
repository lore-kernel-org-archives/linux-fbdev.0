From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 06:59:44 +0000
Subject: [PATCH V5 0/5] video: mmp: misc updates for mmp display driver
Message-Id: <1379055589-26132-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Resend this patch set, the V1 to V4 of which is sent by Jett Zhou.
This patch set contains some misc updates for mmp display controller:
1. Rbswap enhancement
2. Code refine.
3. Pitch calculation and video layer settings.

Changes:
V5/V4:
Just rebase.

V3/V2:
some updates according to comments.

Guoqing Li (2):
  video: mmp: rb swap setting update for mmp display
  video: mmp: optimize some register setting code

Jett.Zhou (1):
  ARM: mmp: remove the legacy rbswap setting for ttc_dkb platform

Jing Xiang (2):
  video: mmp: calculate pitch value when fb set win
  video: mmp: add pitch info in mmp_win structure

 arch/arm/mach-mmp/ttc_dkb.c     |    4 +--
 drivers/video/mmp/fb/mmpfb.c    |   34 ++++++++++++-------
 drivers/video/mmp/hw/mmp_ctrl.c |   71 ++++++++++++++++++++++-----------------
 drivers/video/mmp/hw/mmp_ctrl.h |    5 +++
 include/video/mmp_disp.h        |    6 ++++
 5 files changed, 75 insertions(+), 45 deletions(-)

-- 
1.7.9.5

