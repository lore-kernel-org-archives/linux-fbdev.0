From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 16 Oct 2012 05:05:14 +0000
Subject: [PATCH v2 0/2] da8xx-fb: LCDC driver cleanup
Message-Id: <1350363196-9340-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch series clean up driver as it is necessary for DT migration.

Manjunathappa, Prakash (2):
  da8xx-fb: adopt fb_videomode data for panel information
  da8xx-fb: cleanup LCDC configurations

 arch/arm/mach-davinci/devices-da8xx.c |   22 +----
 drivers/video/da8xx-fb.c              |  167 +++++++++++++++------------------
 include/video/da8xx-fb.h              |   25 +----
 3 files changed, 79 insertions(+), 135 deletions(-)

