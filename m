From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] FB: Update debugging in S3C2410
	framebuffer driver
Date: Mon, 19 Nov 2007 18:06:53 +0000
Message-ID: <20071119180725.790612804@fluff.org>
References: <20071119180650.568288237@fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuB23-0006hu-Th for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 10:07:40 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IuB22-00021E-Ac
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 10:07:39 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: vince@simtec.co.uk, Ben Dooks <ben-linux@fluff.org>

Update the debugging in the s3c2410 framebuffer driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.24-rc3-fb1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.24-rc3-fb1.orig/drivers/video/s3c2410fb.c
+++ linux-2.6.24-rc3-fb1/drivers/video/s3c2410fb.c
@@ -663,7 +663,7 @@ static int __init s3c2410fb_map_video_me
 	dma_addr_t map_dma;
 	unsigned map_size = PAGE_ALIGN(info->fix.smem_len);
 
-	dprintk("map_video_memory(fbi=%p)\n", fbi);
+	dprintk("map_video_memory(fbi=%p) map_size %u\n", fbi, map_size);
 
 	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
 						   &map_dma, GFP_KERNEL);
@@ -891,6 +891,7 @@ static int __init s3c2410fb_probe(struct
 		smem_len *= mach_info->displays[i].yres;
 		smem_len *= mach_info->displays[i].bpp;
 		smem_len >>= 3;
+
 		if (fbinfo->fix.smem_len < smem_len)
 			fbinfo->fix.smem_len = smem_len;
 	}

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
