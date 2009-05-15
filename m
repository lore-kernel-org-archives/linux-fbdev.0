From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: Correct fifo size for some
	products
Date: Fri, 15 May 2009 12:34:18 +0200
Message-ID: <4A0D452A.4000805@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.ferre@atmel.com>) id 1M4uld-0004x7-72
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 10:35:53 +0000
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4ukK-0007sX-AP for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 10:35:48 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Andrew Victor <avictor.za@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>

Remove wrong fifo size definition for some AT91 products.

Due to a misunderstanding of some AT91 datasheets, a fifo size of 2048 (words)
has been introduced by mistake. In fact, all products (AT91/AT32) are sharing
the same fifo size of 512 words.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Can we consider this fix for .30-final ?

 drivers/video/atmel_lcdfb.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 9a577a8..2fb63f6 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -29,14 +29,8 @@
 
 /* configurable parameters */
 #define ATMEL_LCDC_CVAL_DEFAULT		0xc8
-#define ATMEL_LCDC_DMA_BURST_LEN	8
-
-#if defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91CAP9) || \
-	defined(CONFIG_ARCH_AT91SAM9RL)
-#define ATMEL_LCDC_FIFO_SIZE		2048
-#else
-#define ATMEL_LCDC_FIFO_SIZE		512
-#endif
+#define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
+#define ATMEL_LCDC_FIFO_SIZE		512	/* words */
 
 #if defined(CONFIG_ARCH_AT91)
 #define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
-- 
1.5.3.7



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
