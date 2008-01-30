From: ben@fluff.org.uk
Subject: [patch 4/5] FB/S3C2410: Ensure S3C2410
	framebuffer clears initial memory to black
Date: Wed, 30 Jan 2008 01:30:15 +0000
Message-ID: <20080130013106.340972281@fluff.org.uk>
References: <20080130013011.604188602@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JK1nb-0007BJ-7P for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:35 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JK1nZ-0003Q7-LV
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jan 2008 17:31:35 -0800
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-cleartoblack.patch
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

Change the initial pattern in the s3c2410 framebuffer driver
to black.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.23-quilt3/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.23-quilt3.orig/drivers/video/s3c2410fb.c
+++ linux-2.6.23-quilt3/drivers/video/s3c2410fb.c
@@ -679,7 +679,7 @@ static int __init s3c2410fb_map_video_me
 		/* prevent initial garbage on screen */
 		dprintk("map_video_memory: clear %p:%08x\n",
 			info->screen_base, map_size);
-		memset(info->screen_base, 0xf0, map_size);
+		memset(info->screen_base, 0x00, map_size);
 
 		info->fix.smem_start = map_dma;
 

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
