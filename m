From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/8] fbdev: Fix cursor in doublescan mode in atyfb
Date: Thu, 11 Nov 2004 10:15:36 +0800
Message-ID: <20041111022454.14B801A0262@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4eM-00053g-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:26 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4eL-0004Us-Vq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:26 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 589B59D8885
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:25:17 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

fix hw cursor in doublescan modes 

Signed-off-by: Alexander Kern <alex.kern@gmx.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 mach64_cursor.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff -Nru a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
--- a/drivers/video/aty/mach64_cursor.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/mach64_cursor.c	2004-11-11 09:56:33 +08:00
@@ -75,7 +75,7 @@
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u16 xoff, yoff;
-	int x, y;
+	int x, y, h;
 
 #ifdef __sparc__
 	if (par->mmaped)
@@ -106,17 +106,20 @@
 			yoff = 0;
 		}
 
+		h = cursor->image.height;
+
 		/*
-		 * In doublescan mode, the cursor location also needs to be
-		 * doubled.
+		 * In doublescan mode, the cursor location
+		 * and heigh also needs to be doubled.
 		 */
-                if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
+                if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN) {
 			y<<=1;
+			h<<=1;
+		}
 		wait_for_fifo(4, par);
 		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
 		aty_st_le32(CUR_HORZ_VERT_OFF,
-			    ((u32) (64 - cursor->image.height + yoff) << 16) | xoff,
-			    par);
+			    ((u32) (64 - h + yoff) << 16) | xoff, par);
 		aty_st_le32(CUR_HORZ_VERT_POSN, ((u32) y << 16) | x, par);
 	}
 





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
