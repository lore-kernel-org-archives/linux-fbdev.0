From: Richard Henderson <rth@twiddle.net>
Subject: [FB PATCH] fix alpha boot oops
Date: Mon, 6 Jan 2003 01:20:42 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030106012042.A14616@twiddle.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from are.twiddle.net ([64.81.246.98])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18VTRC-0001MW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 06 Jan 2003 01:20:50 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com

Oops in fb_set_cmap caused by palette_cmap.transp uninitialized.
By inspection, fb_blank appears to have the same problem.


r~


===== fbmem.c 1.49 vs edited =====
--- 1.49/drivers/video/fbmem.c	Tue Dec 31 18:08:48 2002
+++ edited/fbmem.c	Mon Jan  6 01:07:03 2003
@@ -386,6 +386,7 @@
 	palette_cmap.red = palette_red;
 	palette_cmap.green = palette_green;
 	palette_cmap.blue = palette_blue;
+	palette_cmap.transp = NULL;
 
 	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
 		n = LINUX_LOGO_COLORS - i;
@@ -767,6 +768,7 @@
 int
 fb_blank(int blank, struct fb_info *info)
 {	
+	/* ??? Varible sized stack allocation.  */
 	u16 black[info->cmap.len];
 	struct fb_cmap cmap;
 	
@@ -775,8 +777,7 @@
 	if (blank) { 
 		memset(black, 0, info->cmap.len * sizeof(u16));
 		cmap.red = cmap.green = cmap.blue = black;
-		if (info->cmap.transp)
-			cmap.transp = black;
+		cmap.transp = info->cmap.transp ? black : NULL;
 		cmap.start = info->cmap.start;
 		cmap.len = info->cmap.len;
 	} else


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
