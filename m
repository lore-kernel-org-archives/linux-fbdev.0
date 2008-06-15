From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] amifb: Register Amiga-specific video
	modes with sysfs
Date: Sun, 15 Jun 2008 13:11:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806151311200.5736@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7q9a-00054x-Bl for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 04:12:10 -0700
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7q9V-0001Ys-Gt
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 04:12:06 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

Register the Amiga-specific video modes with sysfs, so you can see them in
/sys/class/graphics/fb0/modes and change the video mode by writing to
/sys/class/graphics/fb0/mode.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2383,6 +2383,9 @@ default_chipset:
 		goto amifb_error;
 	}
 
+	fb_videomode_to_modelist(ami_modedb, NUM_TOTAL_MODES,
+				 &fb_info.modelist);
+
 	round_down_bpp = 0;
 	chipptr = chipalloc(fb_info.fix.smem_len+
 	                    SPRITEMEMSIZE+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
