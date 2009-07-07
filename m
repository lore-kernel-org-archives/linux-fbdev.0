From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: atmelfb: fix regression with uninitalized
	fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:52:59 +0200
Message-ID: <20090707195259.f3a02bca.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MOEhK-0006Mr-NQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:43:18 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOEhB-0005rc-O9 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:43:18 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-arm-kernel@lists.arm.linux.org.uk

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant locking of the fb_info->mm_lock mutex before the frambuffer 
is registered.

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index cb88394..da05f08 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -261,6 +261,9 @@ static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
 /**
  *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
  *	@sinfo: the frame buffer to allocate memory for
+ * 	
+ * 	This function is called only from the atmel_lcdfb_probe()
+ * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
  */
 static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
 {
@@ -270,9 +273,7 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
 
 	smem_len = (var->xres_virtual * var->yres_virtual
 		    * ((var->bits_per_pixel + 7) / 8));
-	mutex_lock(&info->mm_lock);
 	info->fix.smem_len = max(smem_len, sinfo->smem_len);
-	mutex_unlock(&info->mm_lock);
 
 	info->screen_base = dma_alloc_writecombine(info->device, info->fix.smem_len,
 					(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);


----------------------------------------------------------------------
O czym spiewa Ayo w piosence &#8222;Lonely&#8221;?
U nas teledysk razem z tekstem piosenki! 
>>> http://link.interia.pl/f2240


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
