From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 02/20] atyfb: atyfb: Unshare
	pseudo_palette
Date: Sun, 26 Aug 2007 21:56:12 +0800
Message-ID: <46D1867C.1090500@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ15-000569-7U for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:03 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ14-00088d-N7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:23:03 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:23:02 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <geert@linux-m68k.org>

atyfb: Move the pseudo palette into the card-specific atyfb_par, so it's
no longer shared among multiple cards

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb.h      |    1 +
 drivers/video/aty/atyfb_base.c |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
index dc62f8e..7691e73 100644
--- a/drivers/video/aty/atyfb.h
+++ b/drivers/video/aty/atyfb.h
@@ -126,6 +126,7 @@ union aty_pll {
      */
 
 struct atyfb_par {
+	u32 pseudo_palette[16];
 	struct { u8 red, green, blue; } palette[256];
 	const struct aty_dac_ops *dac_ops;
 	const struct aty_pll_ops *pll_ops;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index bc6f009..b537151 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -541,8 +541,6 @@ static char ram_off[] __devinitdata = "O
 #endif /* CONFIG_FB_ATY_CT */
 
 
-static u32 pseudo_palette[16];
-
 #ifdef CONFIG_FB_ATY_GX
 static char *aty_gx_ram[8] __devinitdata = {
 	ram_dram, ram_vram, ram_vram, ram_dram,
@@ -2577,7 +2575,7 @@ #ifdef CONFIG_MTRR
 #endif
 
 	info->fbops = &atyfb_ops;
-	info->pseudo_palette = pseudo_palette;
+	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_DEFAULT           |
 	              FBINFO_HWACCEL_IMAGEBLIT |
 	              FBINFO_HWACCEL_FILLRECT  |


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
