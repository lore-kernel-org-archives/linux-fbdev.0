From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] atyfb: Unshare pseudo_palette
Date: Sun, 26 Aug 2007 10:21:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708261018470.31149@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPDNK-0002EY-NH for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 01:21:39 -0700
Received: from asia.telenet-ops.be ([195.130.137.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPDNI-0005VD-5a
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 01:21:38 -0700
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
To: Ville Syrjala <syrjala@sci.fi>, "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

atyfb: Move the pseudo palette into the card-specific atyfb_par, so it's
no longer shared among multiple cards

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested (on ppc64) only

 drivers/video/aty/atyfb.h      |    1 +
 drivers/video/aty/atyfb_base.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/video/aty/atyfb.h
+++ b/drivers/video/aty/atyfb.h
@@ -126,6 +126,7 @@ union aty_pll {
      */
 
 struct atyfb_par {
+	u32 pseudo_palette[16];
 	struct { u8 red, green, blue; } palette[256];
 	const struct aty_dac_ops *dac_ops;
 	const struct aty_pll_ops *pll_ops;
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -541,8 +541,6 @@ static char ram_off[] __devinitdata = "O
 #endif /* CONFIG_FB_ATY_CT */
 
 
-static u32 pseudo_palette[16];
-
 #ifdef CONFIG_FB_ATY_GX
 static char *aty_gx_ram[8] __devinitdata = {
 	ram_dram, ram_vram, ram_vram, ram_dram,
@@ -2577,7 +2575,7 @@ static int __devinit aty_init(struct fb_
 #endif
 
 	info->fbops = &atyfb_ops;
-	info->pseudo_palette = pseudo_palette;
+	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_DEFAULT           |
 	              FBINFO_HWACCEL_IMAGEBLIT |
 	              FBINFO_HWACCEL_FILLRECT  |

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
