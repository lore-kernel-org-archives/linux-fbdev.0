From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/hgafb.c warning fix.
Date: Tue, 13 Apr 2004 16:45:34 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040413164534.17eb0c1b.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDTsF-0003gJ-FM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Apr 2004 12:47:11 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDTsE-0002oA-Tk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Apr 2004 12:47:11 -0700
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
To: jsimmons@infradead.org
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sf.net


Hi,

 I'm getting the fallowing warnings:

drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used

 They are caused by dead code, this patch remove then:

diff -X dontdiff -Nparu a/drivers/video/hgafb.c a~/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	2004-01-09 10:30:36.000000000 -0200
+++ a~/drivers/video/hgafb.c	2004-04-13 15:29:51.000000000 -0300
@@ -448,70 +448,6 @@ static int hgafb_blank(int blank_mode, s
 	return 0;
 }
 
-static void hgafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
-{
-	u_int rows, y;
-	u8 *dest;
-
-	y = rect->dy;
-
-	for (rows = rect->height; rows--; y++) {
-		dest = rowaddr(info, y) + (rect->dx >> 3);
-		switch (rect->rop) {
-		case ROP_COPY:
-			//fb_memset(dest, rect->color, (rect->width >> 3));
-			break;
-		case ROP_XOR:
-			*dest = ~*dest;
-			break;
-		}
-	}
-}
-
-static void hgafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
-{
-	u_int rows, y1, y2;
-	u8 *src, *dest;
-
-	if (area->dy <= area->sy) {
-		y1 = area->sy;
-		y2 = area->dy;
-
-		for (rows = area->height; rows--; ) {
-			src = rowaddr(info, y1) + (area->sx >> 3);
-			dest = rowaddr(info, y2) + (area->dx >> 3);
-			//fb_memmove(dest, src, (area->width >> 3));
-			y1++;
-			y2++;
-		}
-	} else {
-		y1 = area->sy + area->height - 1;
-		y2 = area->dy + area->height - 1;
-
-		for (rows = area->height; rows--;) {
-			src = rowaddr(info, y1) + (area->sx >> 3);
-			dest = rowaddr(info, y2) + (area->dx >> 3);
-			//fb_memmove(dest, src, (area->width >> 3));
-			y1--;
-			y2--;
-		}
-	}
-}
-
-static void hgafb_imageblit(struct fb_info *info, const struct fb_image *image)
-{
-	u8 *dest, *cdat = (u8 *) image->data;
-	u_int rows, y = image->dy;
-	u8 d;
-
-	for (rows = image->height; rows--; y++) {
-		d = *cdat++;
-		dest = rowaddr(info, y) + (image->dx >> 3);
-		*dest = d;
-	}
-}
-
-
 static struct fb_ops hgafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= hgafb_open,
@@ -519,9 +455,9 @@ static struct fb_ops hgafb_ops = {
 	.fb_setcolreg	= hgafb_setcolreg,
 	.fb_pan_display	= hgafb_pan_display,
 	.fb_blank	= hgafb_blank,
-	.fb_fillrect	= cfb_fillrect, //hgafb_fillrect,
-	.fb_copyarea	= cfb_copyarea,	//hgafb_copyarea,
-	.fb_imageblit	= cfb_imageblit,//hgafb_imageblit,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
 };
 		
 /* ------------------------------------------------------------------------- *

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
