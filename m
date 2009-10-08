From: Claudio Scordino <claudio@evidence.eu.com>
Subject: [PATCH 1/1] atmel_lcdfb.c: Fix sinfo->irqbase from %lu to %d in dev_info()
Date: Thu, 08 Oct 2009 11:02:12 +0200
Message-ID: <4ACDAA94.8010305@evidence.eu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020604020007030706020408"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756203AbZJHJIx@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: nicolas.ferre@atmel.com
Cc: hong.xu@atmel.com, krzysztof.h1@wp.pl, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604020007030706020408
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nicolas,

   this patch fixes a type mismatch when calling dev_info() in the 
atmel_lcdfb.c driver.

Please commit.

Best regards,

                Claudio


--------------020604020007030706020408
Content-Type: text/x-patch;
 name="0001-atmel_lcdfb.c-Fix-sinfo-irqbase-from-lu-to-d-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-atmel_lcdfb.c-Fix-sinfo-irqbase-from-lu-to-d-in.patch"

From: Claudio Scordino <claudio@evidence.eu.com>
Date: Thu, 8 Oct 2009 10:51:33 +0200
Subject: [PATCH 1/1] atmel_lcdfb.c: Fix sinfo->irqbase from %lu to %d in dev_info()

atmel_lcdfb.c: Fix sinfo->irqbase from %lu to %d in dev_info().


Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
---
 drivers/video/atmel_lcdfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 2830ffd..317afab 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -959,7 +959,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	if (sinfo->atmel_lcdfb_power_control)
 		sinfo->atmel_lcdfb_power_control(1);
 
-	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %lu\n",
+	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %d\n",
 		       info->node, info->fix.mmio_start, sinfo->mmio, sinfo->irq_base);
 
 	return 0;
-- 
1.6.0.4


--------------020604020007030706020408--
