From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 05 Oct 2012 14:03:22 +0000
Subject: [PATCH 0/2] da8xx-fb LCDC driver cleanup
Message-Id: <1349445084-9857-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series clean up driver as it is necessary for DT migration
1) Moves panel information from driver to platform file.
2) Panel independent LCDC configuration are set to optimal values.

Manjunathappa, Prakash (2):
  da8xx-fb: move panel information from driver to platform file
  da8xx-fb: cleanup LCDC configurations

 arch/arm/mach-davinci/devices-da8xx.c |   55 ++++++-----
 drivers/video/da8xx-fb.c              |  164 +++++++++------------------------
 include/video/da8xx-fb.h              |   28 +-----
 3 files changed, 79 insertions(+), 168 deletions(-)

