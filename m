From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 1/7] fbdev: remove unnecessary banshee_wait_idle from tdfxfb
Date: Fri, 10 Sep 2004 05:34:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409100534.29454.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5WYT-0000A0-53
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C5WYS-0005fA-GK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 3FF5379BAA1
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Sep 2004 21:33:54 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

- This patch removes the unnecessary call to banshee_wait_idle() from
  tdfxfb_copyarea, imageblit and fillrect.  Removal of the sync will garner
  an additional ~20% in scrolling speed.

- Removes "inverse" which generates a compile warning if modular.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 tdfxfb.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c	2004-09-08 12:45:38.552927032 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c	2004-09-08 12:47:28.012286680 +0800
@@ -202,7 +202,6 @@ static unsigned long do_lfb_size(struct 
  */
 static int  nopan   = 0;
 static int  nowrap  = 1;      // not implemented (yet)
-static int  inverse = 0;
 static char *mode_option __initdata = NULL;
 
 /* ------------------------------------------------------------------------- 
@@ -921,7 +920,6 @@ static void tdfxfb_fillrect(struct fb_in
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));
-	banshee_wait_idle(info);
 }
 
 /*
@@ -957,7 +955,6 @@ static void tdfxfb_copyarea(struct fb_in
 	tdfx_outl(par,	DSTSIZE,   area->width | (area->height << 16));
 	tdfx_outl(par,	DSTXY,     dx | (dy << 16));
 	tdfx_outl(par,	LAUNCH_2D, sx | (sy << 16)); 
-	banshee_wait_idle(info);
 }
 
 static void tdfxfb_imageblit(struct fb_info *info, const struct fb_image *image) 
@@ -1025,7 +1022,6 @@ static void tdfxfb_imageblit(struct fb_i
 		case 2:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata); break;
 		case 3:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata | ((chardata[3]) << 24)); break;
 	}
-	banshee_wait_idle(info);
 }
 #endif /* CONFIG_FB_3DFX_ACCEL */
 
@@ -1392,10 +1388,7 @@ void tdfxfb_setup(char *options)
 	while ((this_opt = strsep(&options, ",")) != NULL) {	
 		if (!*this_opt)
 			continue;
-		if (!strcmp(this_opt, "inverse")) {
-			inverse = 1;
-			fb_invert_cmaps();
-		} else if(!strcmp(this_opt, "nopan")) {
+		if(!strcmp(this_opt, "nopan")) {
 			nopan = 1;
 		} else if(!strcmp(this_opt, "nowrap")) {
 			nowrap = 1;




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
