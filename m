From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/5] [FBDEV]: Set color fields correctly
Date: Thu, 29 Jul 2004 10:04:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407291004.10098.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bq0RI-0002oy-BR
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jul 2004 19:14:36 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bq0RH-0003EM-KT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Jul 2004 19:14:36 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id 67D53102D318
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 29 Jul 2004 01:52:08 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Hello all,

Although the depth can be correctly inferred from bits_per_pixel
(if bits_per_pixel == 1), for the  sake of consistency, drivers should still
set the color fields correctly. True even if the first patch is not applied.

(I've combined everything in a single diff since there is only 1 logical
change)

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
 
 68328fb.c  |   13 +++++++++++++
 bw2.c      |    6 +++++-
 cirrusfb.c |    6 ++++++
 dnfb.c     |    3 +++
 macfb.c    |    3 +++
 stifb.c    |    1 +
 tx3912fb.c |    3 +++
 7 files changed, 34 insertions(+), 1 deletion(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/68328fb.c linux-2.6.8-rc2-mm1/drivers/video/68328fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/68328fb.c	2004-07-28 20:12:58.386578752 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/68328fb.c	2004-07-28 20:15:20.197020288 +0000
@@ -199,6 +199,15 @@ static int mc68x328fb_check_var(struct f
 	 */
 	switch (var->bits_per_pixel) {
 	case 1:
+		var->red.offset = 0;
+		var->red.length = 1;
+		var->green.offset = 0;
+		var->green.length = 1;
+		var->blue.offset = 0;
+		var->blue.length = 1;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
 	case 8:
 		var->red.offset = 0;
 		var->red.length = 8;
@@ -452,6 +461,10 @@ int __init mc68x328fb_init(void)
 		get_line_length(mc68x328fb_default.xres_virtual, mc68x328fb_default.bits_per_pixel);
 	fb_info.fix.visual = (mc68x328fb_default.bits_per_pixel) == 1 ?
 		MC68X328FB_MONO_VISUAL : FB_VISUAL_PSEUDOCOLOR;
+	if (fb_info.var.bits_per_pixel == 1) {
+		fb_info.var.red.length = fb_info.var.green.length = fb_info.var.blue.length = 1;
+		fb_info.var.red.offset = fb_info.var.green.offset = fb_info.var.blue.offset = 0;
+	}
 	fb_info.pseudo_palette = &mc68x328fb_pseudo_palette;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/bw2.c linux-2.6.8-rc2-mm1/drivers/video/bw2.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/bw2.c	2004-07-28 20:13:14.279162712 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/bw2.c	2004-07-28 20:15:31.292333544 +0000
@@ -323,7 +323,7 @@ static void bw2_init_one(struct sbus_dev
 		resp = &res;
 		all->info.var.xres = all->info.var.xres_virtual = 1152;
 		all->info.var.yres = all->info.var.yres_virtual = 900;
-		all->info.bits_per_pixel = 1;
+		all->info.var.bits_per_pixel = 1;
 		linebytes = 1152 / 8;
 	} else
 #else
@@ -337,6 +337,10 @@ static void bw2_init_one(struct sbus_dev
 					       all->info.var.xres);
 	}
 #endif
+	all->info.var.red.length = all->info.var.green.length =
+		all->info.var.blue.length = all_info.var.bits_per_pixel;
+	all->info.var.red.offset = all->info.var.green.offset =
+		all->info.var.blue.offset = 0;
 
 	all->par.regs = (struct bw2_regs *)
 		sbus_ioremap(resp, BWTWO_REGISTER_OFFSET,
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/cirrusfb.c linux-2.6.8-rc2-mm1/drivers/video/cirrusfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/cirrusfb.c	2004-07-28 20:13:25.316484784 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/cirrusfb.c	2004-07-28 20:15:40.616915992 +0000
@@ -752,6 +752,12 @@ int cirrusfb_check_var(struct fb_var_scr
 
 	switch (var->bits_per_pixel) {
 	case 1:
+		var->red.offset = 0;
+		var->red.length = 1;
+		var->green.offset = 0;
+		var->green.length = 1;
+		var->blue.offset = 0;
+		var->blue.length = 1;
 		break;
 
 	case 8:
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/dnfb.c linux-2.6.8-rc2-mm1/drivers/video/dnfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/dnfb.c	2004-07-28 20:13:35.850883312 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/dnfb.c	2004-07-28 20:15:56.266536888 +0000
@@ -239,6 +239,9 @@ static int __devinit dnfb_probe(struct d
 	info->fbops = &dn_fb_ops;
 	info->fix = dnfb_fix;
 	info->var = dnfb_var;
+	info->var.red.length = 1;
+	info->var.red.offset = 0;
+	info->var.green = info->var.blue = info->var.red;
 	info->screen_base = (u_char *) info->fix.smem_start;
 
 	err = fb_alloc_cmap(&info->cmap, 2, 0);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/macfb.c linux-2.6.8-rc2-mm1/drivers/video/macfb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/macfb.c	2004-07-28 20:13:59.972216312 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/macfb.c	2004-07-28 20:16:08.340701336 +0000
@@ -660,6 +660,9 @@ void __init macfb_init(void)
 	case 1:
 		/* XXX: I think this will catch any program that tries
 		   to do FBIO_PUTCMAP when the visual is monochrome */
+		macfb_defined.red.length = macfb_defined.bits_per_pixel;
+		macfb_defined.green.length = macfb_defined.bits_per_pixel;
+		macfb_defined.blue.length = macfb_defined.bits_per_pixel;
 		video_cmap_len = 0;
 		macfb_fix.visual = FB_VISUAL_MONO01;
 		break;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/stifb.c linux-2.6.8-rc2-mm1/drivers/video/stifb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/stifb.c	2004-07-28 20:14:15.423867304 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/stifb.c	2004-07-28 20:16:21.296731720 +0000
@@ -1298,6 +1298,7 @@ stifb_init_fb(struct sti_struct *sti, in
 	    case 1:
 		fix->type = FB_TYPE_PLANES;	/* well, sort of */
 		fix->visual = FB_VISUAL_MONO10;
+		var->red.length = var->green.length = var->blue.length = 1;
 		break;
 	    case 8:
 		fix->type = FB_TYPE_PACKED_PIXELS;
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/tx3912fb.c linux-2.6.8-rc2-mm1/drivers/video/tx3912fb.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/tx3912fb.c	2004-07-28 20:14:26.830133288 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/tx3912fb.c	2004-07-28 20:16:31.124237712 +0000
@@ -60,6 +60,9 @@ static struct fb_var_screeninfo tx3912fb
 	.blue =		{ 0, 2, 0 },
 #else
 	.bits_per_pixel =4,
+	.red =		{ 0, 4, 0 },	/* ??? */
+	.green =	{ 0, 4, 0 },
+	.blue =		{ 0, 4, 0 },
 #endif
 	.activate =	FB_ACTIVATE_NOW,
 	.width =	-1,




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
