From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: Add __iomem annotations for savagefb
Date: Thu, 28 Oct 2004 09:10:14 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410280910.14398.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMykk-0003HU-K2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 18:06:58 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMykj-0004E1-N2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 18:06:58 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 50E059578F0
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Oct 2004 01:06:49 +0000 (UTC)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add __iomem annotations for savagefb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 savagefb.c |    8 ++------
 savagefb.h |    8 ++++----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff -Nru a/drivers/video/savage/savagefb.c b/drivers/video/savage/savagefb.c
--- a/drivers/video/savage/savagefb.c	2004-10-27 15:25:24 +08:00
+++ b/drivers/video/savage/savagefb.c	2004-10-28 09:07:26 +08:00
@@ -1499,7 +1499,7 @@
 	info->fix.mmio_start = par->mmio.pbase;
 	info->fix.mmio_len   = par->mmio.len;
 
-	par->bci_base = (u32*)(par->mmio.vbase + BCI_BUFFER_OFFSET);
+	par->bci_base = (u32 __iomem *)(par->mmio.vbase + BCI_BUFFER_OFFSET);
 	par->bci_ptr  = 0;
 
 	savage_enable_mmio (par);
@@ -1515,7 +1515,7 @@
 	savage_disable_mmio(par);
 
 	if (par->mmio.vbase) {
-		iounmap ((void *)par->mmio.vbase);
+		iounmap ((void __iomem *)par->mmio.vbase);
 		par->mmio.vbase = NULL;
 	}
 }
@@ -1552,10 +1552,6 @@
 	par->video.mtrr = mtrr_add (par->video.pbase, video_len,
 				     MTRR_TYPE_WRCOMB, 1);
 #endif
-
-	/* Clear framebuffer, it's all white in memory after boot */
-	memset (par->video.vbase, 0, par->video.len);
-
 	return 0;
 }
 
diff -Nru a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
--- a/drivers/video/savage/savagefb.h	2004-10-27 15:25:25 +08:00
+++ b/drivers/video/savage/savagefb.h	2004-10-28 08:54:24 +08:00
@@ -156,7 +156,7 @@
 	struct savagefb_par *par;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data algo;
-	volatile u8 *ioaddr;
+	volatile u8 __iomem *ioaddr;
 	u32   reg;
 };
 
@@ -172,7 +172,7 @@
 	int numClocks;
 	int clock[4];
 	struct {
-		u8    *vbase;
+		u8   __iomem *vbase;
 		u32    pbase;
 		u32    len;
 #ifdef CONFIG_MTRR
@@ -181,12 +181,12 @@
 	} video;
 
 	struct {
-		volatile u8  *vbase;
+		volatile u8  __iomem *vbase;
 		u32           pbase;
 		u32           len;
 	} mmio;
 
-	volatile u32  *bci_base;
+	volatile u32  __iomem *bci_base;
 	unsigned int  bci_ptr;
 
 	u32           cob_offset;




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
