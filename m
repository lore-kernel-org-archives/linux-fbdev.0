From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3fb: mode selection fixes
Date: Sun, 30 Sep 2007 16:10:20 +0200
Message-ID: <20070930161020.e6a01fa0.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbzMu-0000lz-Rv for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 07:02:01 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbzMt-0005FN-7U
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 07:02:00 -0700
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 86A0C13DE7A
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 30 Sep 2007 16:01:55 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id E099F137BF4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 30 Sep 2007 16:01:55 +0200 (CEST)
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes bugs related to mode selection in the s3fb driver:
- fixes definition of the 32-bit format,
- fixes wrong error value returned when format is not supported
  by chip,
- sets r,g,b length field from the bits_per_pixel value otherwise
  the fbset fails in simple case like switching depths: 
  8bpp ->32bpp -> 8bpp

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch keeps selected depth while switching resolutions.

Regards,
Krzysztof

diff -urp linux-2.6.22/drivers/video/s3fb.c linux-2.6.23/drivers/video/s3fb.c
--- linux-2.6.22/drivers/video/s3fb.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.23/drivers/video/s3fb.c	2007-09-30 13:26:11.000000000 +0200
@@ -58,7 +58,7 @@ static const struct svga_fb_format s3fb_
 		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 2, 4},
 	{24,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {0, 0, 0}, 0,
 		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 1, 2},
-	{32,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {0, 0, 0}, 0,
+	{32,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {24, 8, 0}, 0,
 		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 1, 2},
 	SVGA_FORMAT_END
 };
@@ -401,12 +401,42 @@ static int s3fb_check_var(struct fb_var_
 	struct s3fb_info *par = info->par;
 	int rv, mem, step;
 
+	/* set predefined mode for bits_per_pixel settings */
+	var->transp.offset = 0;
+	var->transp.length = 0;
+	switch(var->bits_per_pixel) {
+	case 4:
+	case 8:
+		var->red.length = 6;
+		var->red.offset = 0;
+		var->green = var->red;
+		var->blue = var->red;
+		break;
+	case 16:
+		var->red.length = 5;
+		var->blue.length = 5;
+		if (var->green.length != 6 && var->green.length != 5)
+			var->green.length = 6;
+		var->transp.length = 0;
+		break;
+	case 32:
+		var->transp.length = 8;
+		var->transp.offset = 24;
+	case 24:
+		var->red.length = 8;
+		var->green = var->red;
+		var->blue = var->red;
+		break;
+	default:
+		printk(KERN_ERR "depth not supported: %u\n", var->bits_per_pixel);
+		return -EINVAL;
+	}
 	/* Find appropriate format */
 	rv = svga_match_format (s3fb_formats, var, NULL);
 	if ((rv < 0) || ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6)))
 	{		/* 24bpp on VIRGE VX, 32bpp on others */
 		printk(KERN_ERR "fb%d: unsupported mode requested\n", info->node);
-		return rv;
+		return rv < 0 ? rv : -EINVAL;
 	}
 
 	/* Do not allow to have real resoulution larger than virtual */



----------------------------------------------------------------------
Wygrasz, czy przegrasz?

>>> http://link.interia.pl/f1bbd


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
