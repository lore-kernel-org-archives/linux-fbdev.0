From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: fsl-diu-fb: fix regression with uninitalized
	fb_info->mm_lock mutex
Date: Tue, 7 Jul 2009 19:44:40 +0200
Message-ID: <20090707194440.12550fab.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MOEZF-0004b0-O0
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:34:57 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOEZA-0005oa-R7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 17:34:57 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>, Paul Widmer <paul.widmer@freescale.com>, Hongjun Chen <hong-jun.chen@freescale.com>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove redundant call to the fsl_diu_set_par before the register_framebuffer().

This fixes a problem with uninitialized the fb_info->mm_lock mutex introduced 
by the commit 537a1bf059f " fbdev: add mutex for fb_mmap locking"

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
If anybody could test this patch with the 2.6.30-rc2 kernel I am deeply grateful.

The fb_set_par() function is called after register_framebuffer() when fbcon
is taking over the console so a call just before the register_framebuffer()
is redundant.

Regards,
Krzysztof

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0bf2190..72d68b3 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1223,12 +1223,6 @@ static int __devinit install_fb(struct fb_info *info)
 		return -EINVAL;
 	}
 
-	if (fsl_diu_set_par(info)) {
-		printk(KERN_ERR "fb_set_par failed");
-		fb_dealloc_cmap(&info->cmap);
-		return -EINVAL;
-	}
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "register_framebuffer failed");
 		unmap_video_memory(info);

----------------------------------------------------------------------
Rozwiaz krzyzowke i  wygraj nagrody! 
Sprawdz >>  http://link.interia.pl/f2232 


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
