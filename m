From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/16] cirrusfb: Driver cleanup and bug fixes
Date: Mon, 28 Nov 2005 23:21:44 +0800
Message-ID: <438B2088.4080301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhGnL-000250-AT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:30:03 -0800
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EhGnK-000244-NY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 29 Nov 2005 17:30:03 -0800
Received: by zproxy.gmail.com with SMTP id z3so2537390nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Nov 2005 17:30:02 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jeff Garzik <jgarzik@pobox.com>

- pseudo_palette is only 16 entries long
- the pseudo_palette, if using the generic drawing functions, must always
be u32 regardless of bpp
- the fillrect accelerator is using region->color regardless of the visual.
region->color is the index to the pseudo_palette if visual is truecolor

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/cirrusfb.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 2858c5c..e0dbdfc 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -404,7 +404,7 @@ struct cirrusfb_info {
 	struct cirrusfb_regs currentmode;
 	int blank_mode;
 
-	u32	pseudo_palette[17];
+	u32	pseudo_palette[16];
 	struct { u8 red, green, blue, pad; } palette[256];
 
 #ifdef CONFIG_ZORRO
@@ -1603,14 +1603,14 @@ static int cirrusfb_setcolreg (unsigned 
 
 		switch (info->var.bits_per_pixel) {
 			case 8:
-				((u8*)(info->pseudo_palette))[regno] = v;
+				cinfo->pseudo_palette[regno] = v;
 				break;
 			case 16:
-				((u16*)(info->pseudo_palette))[regno] = v;
+				cinfo->pseudo_palette[regno] = v;
 				break;
 			case 24:
 			case 32:
-				((u32*)(info->pseudo_palette))[regno] = v;
+				cinfo->pseudo_palette[regno] = v;
 				break;
 		}
 		return 0;
@@ -2020,18 +2020,21 @@ static void cirrusfb_prim_fillrect(struc
 				   const struct fb_fillrect *region)
 {
 	int m; /* bytes per pixel */
+	u32 color = (cinfo->info->fix.visual == FB_VISUAL_TRUECOLOR) ?
+		cinfo->pseudo_palette[region->color] : region->color;
+
 	if(cinfo->info->var.bits_per_pixel == 1) {
 		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.bits_per_pixel,
 				  region->dx / 8, region->dy,
 				  region->width / 8, region->height,
-				  region->color,
+				  color,
 				  cinfo->currentmode.line_length);
 	} else {
 		m = ( cinfo->info->var.bits_per_pixel + 7 ) / 8;
 		cirrusfb_RectFill(cinfo->regbase, cinfo->info->var.bits_per_pixel,
 				  region->dx * m, region->dy,
 				  region->width * m, region->height,
-				  region->color,
+				  color,
 				  cinfo->currentmode.line_length);
 	}
 	return;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
