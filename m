From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: accel_putcs()
Date: Sun, 12 Jan 2003 22:00:35 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301122156210.20640-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XpEJ-0005pW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 13:01:15 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id WAA17995
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 22:00:36 +0100 (MET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


accel_putcs() calls fb_sync() after fb_imageblit(), except if fontwidth is not
a multiple of 8 and it falls back to individual drawing of the characters. This
patch adds the missing call to fb_sync().

It also replaces `vc->vc_font.height * width' by its precalculated value in
`cellsize'.

--- linux-2.5.56/drivers/video/console/fbcon.c	Thu Jan  2 12:54:55 2003
+++ linux-geert-2.5.56/drivers/video/console/fbcon.c	Sun Jan 12 13:20:53 2003
@@ -418,17 +415,17 @@
 			dst0 += width;
 		}
 		info->fbops->fb_imageblit(info, &image);
-		if (info->fbops->fb_sync)
-			info->fbops->fb_sync(info);
 	} else {
 		image.width = vc->vc_font.width;
 		while (count--) {
-			image.data = p->fontdata + 
-				(scr_readw(s++) & charmask) * vc->vc_font.height * width;
+			image.data = p->fontdata +
+				(scr_readw(s++) & charmask) * cellsize;
 			info->fbops->fb_imageblit(info, &image);
 			image.dx += vc->vc_font.width;
-		}	
+		}
 	}
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
 	/*
 	if (pixmap);
 		kfree(pixmap);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
