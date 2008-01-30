From: ben@fluff.org.uk
Subject: [patch 3/5] FB/S3C2410: Update debugging in
	S3C2410 framebuffer driver
Date: Wed, 30 Jan 2008 01:30:14 +0000
Message-ID: <20080130013106.182952236@fluff.org.uk>
References: <20080130013011.604188602@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JK1nb-0007BK-94 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:35 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JK1nZ-0003Q6-MK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:35 -0800
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-debug-update.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux FB <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vincent Sanders <vince@simtec.co.uk>, Ben Dooks <ben-linux@fluff.org>

Update the debugging in the s3c2410 framebuffer driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.22-simtec14/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.22-simtec14.orig/drivers/video/s3c2410fb.c
+++ linux-2.6.22-simtec14/drivers/video/s3c2410fb.c
@@ -670,7 +670,7 @@ static int __init s3c2410fb_map_video_me
 	dma_addr_t map_dma;
 	unsigned map_size = PAGE_ALIGN(info->fix.smem_len);
 
-	dprintk("map_video_memory(fbi=%p)\n", fbi);
+	dprintk("map_video_memory(fbi=%p) map_size %u\n", fbi, map_size);
 
 	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
 						   &map_dma, GFP_KERNEL);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
