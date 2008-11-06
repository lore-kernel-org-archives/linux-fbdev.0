From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: Change irq_base definition to allow error reporting
Date: Thu, 06 Nov 2008 16:23:15 +0100
Message-ID: <49130BE3.1030108@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752305AbYKFPXy@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Victor <linux@maxim.org.za>

Change irq_base definition to allow error reporting

Changed because old definition : unsigned long cannot be negative.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reported-by: Roel Kluin <roel.kluin@gmail.com>
---
 include/video/atmel_lcdc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 6ad87f4..0c864db 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -38,7 +38,7 @@ struct atmel_lcdfb_info {
 	spinlock_t		lock;
 	struct fb_info		*info;
 	void __iomem		*mmio;
-	unsigned long		irq_base;
+	int			irq_base;
 	struct work_struct	task;
 
 	unsigned int		guard_time;
-- 
1.5.3.7
