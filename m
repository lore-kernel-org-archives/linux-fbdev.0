From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/3][FBDEV]: Set capabilities flag for vesafb and vga16fb
Date: Tue, 6 Jul 2004 06:34:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407060634.43963.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bhc2U-0005Uy-9O
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:18 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bhc2T-0000zl-Qh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 15:34:18 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 3755772A75
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  5 Jul 2004 21:28:23 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

This patch sets the correct capabilities flag for vesafb and vga16fb to provide fbcon
with the correct hints as to the best scrolling mode.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-mm6-orig/drivers/video/vesafb.c linux-2.6.7-mm6/drivers/video/vesafb.c
--- linux-2.6.7-mm6-orig/drivers/video/vesafb.c	2004-07-05 21:13:11.369469160 +0000
+++ linux-2.6.7-mm6/drivers/video/vesafb.c	2004-07-05 13:50:25.000000000 +0000
@@ -378,7 +378,8 @@
 	info->fbops = &vesafb_ops;
 	info->var = vesafb_defined;
 	info->fix = vesafb_fix;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_FLAG_DEFAULT |
+		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENXIO;
diff -Naur linux-2.6.7-mm6-orig/drivers/video/vga16fb.c linux-2.6.7-mm6/drivers/video/vga16fb.c
--- linux-2.6.7-mm6-orig/drivers/video/vga16fb.c	2004-07-05 21:13:21.050997344 +0000
+++ linux-2.6.7-mm6/drivers/video/vga16fb.c	2004-07-05 21:13:37.357518376 +0000
@@ -1370,7 +1370,8 @@
 	vga16fb.var = vga16fb_defined;
 	vga16fb.fix = vga16fb_fix;
 	vga16fb.par = &vga16_par;
-	vga16fb.flags = FBINFO_FLAG_DEFAULT;
+	vga16fb.flags = FBINFO_FLAG_DEFAULT |
+		FBINFO_HWACCEL_YPAN;
 
 	i = (vga16fb_defined.bits_per_pixel == 8) ? 256 : 16;
 	ret = fb_alloc_cmap(&vga16fb.cmap, i, 0);




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
