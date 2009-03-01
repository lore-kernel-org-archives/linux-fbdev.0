From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Fix 8bpp RGB fields length
Date: Sun, 1 Mar 2009 21:55:56 +0100
Message-ID: <20090301215556.8631c63c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Ldsca-0006M0-1V
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Mar 2009 20:50:48 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LdscQ-0005w0-Gz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Mar 2009 20:50:47 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I found that some fbdev drivers set RGB field's lengths incorrectly
to 6 bits. This is incorrect as the field's length says how many bits
has a color index when using color palette (6 bits = 64 colors).

Fix this error in uvesafb by dropping DAC switching to 8 bits 
completely. Advantage of this approach is making the driver shorter,
disadvantage is that some color fidelity is lost.

Regards,
Krzysztof


diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 6c2d37f..76661bf 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -300,22 +300,10 @@ static void uvesafb_setup_var(struct fb_var_screeninfo *var,
 		var->blue.offset   = 0;
 		var->transp.offset = 0;
 
-		/*
-		 * We're assuming that we can switch the DAC to 8 bits. If
-		 * this proves to be incorrect, we'll update the fields
-		 * later in set_par().
-		 */
-		if (par->vbe_ib.capabilities & VBE_CAP_CAN_SWITCH_DAC) {
-			var->red.length    = 8;
-			var->green.length  = 8;
-			var->blue.length   = 8;
-			var->transp.length = 0;
-		} else {
-			var->red.length    = 6;
-			var->green.length  = 6;
-			var->blue.length   = 6;
-			var->transp.length = 0;
-		}
+		var->red.length    = 8;
+		var->green.length  = 8;
+		var->blue.length   = 8;
+		var->transp.length = 0;
 	}
 }
 
@@ -998,16 +986,15 @@ static int uvesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 		struct fb_info *info)
 {
 	struct uvesafb_pal_entry entry;
-	int shift = 16 - info->var.green.length;
 	int err = 0;
 
 	if (regno >= info->cmap.len)
 		return -EINVAL;
 
 	if (info->var.bits_per_pixel == 8) {
-		entry.red   = red   >> shift;
-		entry.green = green >> shift;
-		entry.blue  = blue  >> shift;
+		entry.red   = red   >> 10;
+		entry.green = green >> 10;
+		entry.blue  = blue  >> 10;
 		entry.pad   = 0;
 
 		err = uvesafb_setpalette(&entry, 1, regno, info);
@@ -1047,7 +1034,6 @@ static int uvesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 static int uvesafb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 {
 	struct uvesafb_pal_entry *entries;
-	int shift = 16 - info->var.green.length;
 	int i, err = 0;
 
 	if (info->var.bits_per_pixel == 8) {
@@ -1060,9 +1046,9 @@ static int uvesafb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 			return -ENOMEM;
 
 		for (i = 0; i < cmap->len; i++) {
-			entries[i].red   = cmap->red[i]   >> shift;
-			entries[i].green = cmap->green[i] >> shift;
-			entries[i].blue  = cmap->blue[i]  >> shift;
+			entries[i].red   = cmap->red[i]   >> 10;
+			entries[i].green = cmap->green[i] >> 10;
+			entries[i].blue  = cmap->blue[i]  >> 10;
 			entries[i].pad   = 0;
 		}
 		err = uvesafb_setpalette(entries, cmap->len, cmap->start, info);
@@ -1299,26 +1285,6 @@ setmode:
 	}
 	par->mode_idx = i;
 
-	/* For 8bpp modes, always try to set the DAC to 8 bits. */
-	if (par->vbe_ib.capabilities & VBE_CAP_CAN_SWITCH_DAC &&
-	    mode->bits_per_pixel <= 8) {
-		uvesafb_reset(task);
-		task->t.regs.eax = 0x4f08;
-		task->t.regs.ebx = 0x0800;
-
-		err = uvesafb_exec(task);
-		if (err || (task->t.regs.eax & 0xffff) != 0x004f ||
-		    ((task->t.regs.ebx & 0xff00) >> 8) != 8) {
-			/*
-			 * We've failed to set the DAC palette format -
-			 * time to correct var.
-			 */
-			info->var.red.length    = 6;
-			info->var.green.length  = 6;
-			info->var.blue.length   = 6;
-		}
-	}
-
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	info->fix.line_length = mode->bytes_per_scan_line;

----------------------------------------------------------------------
Dodatkowy dzien wolny od pracy? Wypowiedz sie i wygraj nagrode!
Wejdz >>  http://link.interia.pl/f2077 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
