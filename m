From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 14/15] ps3vram: Make
	ps3vram_priv.reports a void *
Date: Fri,  8 May 2009 16:01:23 +0200
Message-ID: <1241791284-11490-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1M2Qdt-0001rR-P0
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:37 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 1b2kzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1M2Qds-0007SX-VA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 08 May 2009 14:01:37 +0000
In-Reply-To: <1241791284-11490-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>, linux-kernel@vger.kernel.org

So we can kill a cast.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
---
 drivers/block/ps3vram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 5f5b828..70f51ff 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -72,7 +72,7 @@ struct ps3vram_priv {
 	u64 memory_handle;
 	u64 context_handle;
 	u32 *ctrl;
-	u32 *reports;
+	void *reports;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -102,9 +102,9 @@ static char *size = "256M";
 module_param(size, charp, 0);
 MODULE_PARM_DESC(size, "memory size");
 
-static u32 *ps3vram_get_notifier(u32 *reports, int notifier)
+static u32 *ps3vram_get_notifier(void *reports, int notifier)
 {
-	return (void *)reports + DMA_NOTIFIER_OFFSET_BASE +
+	return reports + DMA_NOTIFIER_OFFSET_BASE +
 	       DMA_NOTIFIER_SIZE * notifier;
 }
 
-- 
1.6.2.4


------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
