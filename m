From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH atyfb] fix hw cursor in doublescan modes
Date: Wed, 10 Nov 2004 19:25:30 +0100
Message-ID: <200411101925.30957.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a0lkB61S7EafUik"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRxA5-0007dh-PA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:25:41 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRxA5-0004Kw-3R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 10:25:41 -0800
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_a0lkB61S7EafUik
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

fix hw cursor in doublescan modes 

Signed-off-by: Alexander Kern <alex.kern@gmx.de>


--Boundary-00=_a0lkB61S7EafUik
Content-Type: text/x-diff;
  charset="us-ascii";
  name="atyfb_fix_cursor_in_doublescanmode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb_fix_cursor_in_doublescanmode.patch"

--- linux-2.6.head/drivers/video/aty/mach64_cursor.c.orig	2004-11-07 17:14:57.000000000 +0100
+++ linux-2.6.head/drivers/video/aty/mach64_cursor.c	2004-11-09 15:04:56.000000000 +0100
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
 

--Boundary-00=_a0lkB61S7EafUik--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
