From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] inivisible cursor on vesafb
Date: Mon, 19 Aug 2002 01:05:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020818230541.GA1680@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p056.as-l031.contactel.cz ([212.65.234.248] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17gZ95-00083z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Aug 2002 16:07:47 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Linus,

Since vesafb was converted to the (strange) cfb* interface, it uses random
colors for the cursor, making cursor invisible when console uses black foreground
(f.e. Midnight Commander does that). Problem is common to all fbdevs which
use fbcon-accel interface.

This change tries to restore old behavior which existed before cfb* came in.
Unfortunately due to region.color semantic it is not possible to completely
restore previous behavior - 
+ for truecolor cfbfillrect always consults current palette, so we do not 
  have "always invert" constant available, and so we do inversion with palette
  color 15 (it is light white, ~0, by default)
+ for directcolor it assumes that display has at least 4 bits per color.
+ for pseudocolor it works as old code worked.

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/fbcon-accel.c linux/drivers/video/fbcon-accel.c
--- linux/drivers/video/fbcon-accel.c	2002-08-18 01:35:06.000000000 +0200
+++ linux/drivers/video/fbcon-accel.c	2002-08-18 15:07:42.000000000 +0200
@@ -104,7 +104,10 @@
 	struct fb_info *info = p->fb_info;
 	struct fb_fillrect region;
 
-	region.color = attr_fgcol_ec(p, p->conp);
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR || info->fix.visual == FB_VISUAL_TRUECOLOR)
+		region.color = 0x0F;
+	else
+		region.color = (0x0F << info->var.red.offset) | (0x0F << info->var.green.offset) | (0x0F << info->var.blue.offset);
 	region.dx = xx * fontwidth(p);
 	region.dy = yy * fontheight(p);
 	region.width  = fontwidth(p);


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
