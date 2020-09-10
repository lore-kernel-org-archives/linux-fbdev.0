From: Jason Yan <yanaijie@huawei.com>
Date: Thu, 10 Sep 2020 14:05:36 +0000
Subject: [PATCH] video: fbdev: sis: remove unneeded semicolon
Message-Id: <20200910140536.1191150-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: thomas@winischhofer.net, b.zolnierkie@samsung.com, yanaijie@huawei.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>

Eliminate the following coccicheck warning:

drivers/video/fbdev/sis/sis_accel.h:143:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:144:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:145:72-73: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:273:75-76: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:274:75-76: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:275:73-74: Unneeded semicolon
drivers/video/fbdev/sis/sis_accel.h:276:75-76: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/sis/sis_accel.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_accel.h b/drivers/video/fbdev/sis/sis_accel.h
index c3dfd2a20cf9..98d209658662 100644
--- a/drivers/video/fbdev/sis/sis_accel.h
+++ b/drivers/video/fbdev/sis/sis_accel.h
@@ -140,9 +140,9 @@
 
 #define SiS300Idle \
   { \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
-  	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){}; \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
+	while((MMIO_IN16(ivideo->mmio_vbase, BR(16)+2) & 0xE000) != 0xE000){} \
   	CmdQueLen = MMIO_IN16(ivideo->mmio_vbase, 0x8240); \
   }
 /* (do three times, because 2D engine seems quite unsure about whether or not it's idle) */
@@ -270,10 +270,10 @@
 
 #define SiS310Idle \
   { \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
-  	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){}; \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
+	while( (MMIO_IN16(ivideo->mmio_vbase, Q_STATUS+2) & 0x8000) != 0x8000){} \
   	CmdQueLen = 0; \
   }
 
-- 
2.25.4
