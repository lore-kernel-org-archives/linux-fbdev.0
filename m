From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 2/6] tgafb: Fix copying overlapping areas
Date: Wed, 13 Dec 2006 17:10:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612131600360.24220@blysk.ds.pg.gda.pl>
Reply-To: Linux on Alpha processors <axp-list@redhat.com>
Mime-Version: 1.0
Return-path: <axp-list-bounces@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/axp-list>
List-Post: <mailto:axp-list@redhat.com>
List-Help: <mailto:axp-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=subscribe>
Sender: axp-list-bounces@redhat.com
Errors-To: axp-list-bounces@redhat.com
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: axp-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 The direction of copying in the copyarea functions is selected 
incorrectly, resulting in corruption.  This is a fix.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 It looks like these functions are not used by the console code as image 
blitting is preferred for scrolling and hence the bug has escaped 
unnoticed for so long.  Still it is not an excuse for these functions to 
be wrong.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-copyarea-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 05:15:28.000000000 +0000
@@ -919,7 +919,7 @@ copyarea_line_8bpp(struct fb_info *info,
 
 	n64 = (height * width) / 64;
 
-	if (dy < sy) {
+	if (sy < dy) {
 		spos = (sy + height) * width;
 		dpos = (dy + height) * width;
 
@@ -967,7 +967,7 @@ copyarea_line_32bpp(struct fb_info *info
 
 	n16 = (height * width) / 16;
 
-	if (dy < sy) {
+	if (sy < dy) {
 		src = tga_fb + (sy + height) * width * 4;
 		dst = tga_fb + (dy + height) * width * 4;
