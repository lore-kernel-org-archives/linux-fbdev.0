From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/9][VESAFB]: Use 8-bit DAC for capable hardware
Date: Sat, 21 Aug 2004 20:59:33 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212059.33601.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByVzz-00082c-PR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:35 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1ByVzz-0008Dv-1e
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:33:35 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BDD0079AA12
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:33:26 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

The patch adds the ability for vesafb to switch the DAC from 6-bit to 8-bit
at kernel boot.  Besides fixing the failure to draw the 224-color logo, an
8-bit DAC will also provide a wider color range for user applications.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S |   38 +++++++++++++++++++++++++++++-
 drivers/video/vesafb.c |   62 +++++++++++++++++++++++--------------------------
 2 files changed, 67 insertions(+), 33 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/arch/i386/boot/video.S linux-2.6.8.1-mm3/arch/i386/boot/video.S
--- linux-2.6.8.1-mm3-orig/arch/i386/boot/video.S	2004-05-10 10:32:26.000000000 +0800
+++ linux-2.6.8.1-mm3/arch/i386/boot/video.S	2004-08-21 19:02:50.611285656 +0800
@@ -232,6 +232,41 @@ mopar_gr:
 	xorl	%eax, %eax
 	movw	18(%di), %ax
 	movl	%eax, %fs:(PARAM_LFB_SIZE)
+
+# switching the DAC to 8-bit is for <= 8 bpp only
+	movw	%fs:(PARAM_LFB_DEPTH), %ax
+	cmpw	$8, %ax
+	jg	dac_done
+	
+# get DAC switching capability
+	xorl	%eax, %eax
+	movb	10(%di), %al
+	testb	$1, %al
+	jz	dac_set
+
+# attempt to switch DAC to 8-bit
+	movw	$0x4f08, %ax
+	movw	$0x0800, %bx
+	int	$0x10
+	cmpw	$0x004f, %ax
+	jne     dac_set
+	movb    %bh, dac_size		# store actual DAC size	
+
+dac_set:		
+# set color size to DAC size	
+	movb	dac_size, %al
+	movb	%al, %fs:(PARAM_LFB_COLORS+0)
+	movb	%al, %fs:(PARAM_LFB_COLORS+2)
+	movb	%al, %fs:(PARAM_LFB_COLORS+4)
+	movb	%al, %fs:(PARAM_LFB_COLORS+6)  
+
+# set color offsets to 0
+	movb	$0, %fs:(PARAM_LFB_COLORS+1)
+	movb	$0, %fs:(PARAM_LFB_COLORS+3)	
+	movb	$0, %fs:(PARAM_LFB_COLORS+5)	
+	movb	$0, %fs:(PARAM_LFB_COLORS+7)	
+
+dac_done:			
 # get protected mode interface informations
 	movw	$0x4f0a, %ax
 	xorw	%bx, %bx
@@ -1929,7 +1964,8 @@ scanning:	.byte	0	# Performing mode scan
 do_restore:	.byte	0	# Screen contents altered during mode change
 svga_prefix:	.byte	VIDEO_FIRST_BIOS>>8	# Default prefix for BIOS modes
 graphic_mode:	.byte	0	# Graphic mode with a linear frame buffer
-
+dac_size:	.byte	6	# DAC bit depth
+	
 # Status messages
 keymsg:		.ascii	"Press <RETURN> to see video modes available, "
 		.ascii	"<SPACE> to continue or wait 30 secs"
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/vesafb.c linux-2.6.8.1-mm3/drivers/video/vesafb.c
--- linux-2.6.8.1-mm3-orig/drivers/video/vesafb.c	2004-08-17 21:51:40.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/vesafb.c	2004-08-21 19:02:50.613285352 +0800
@@ -87,15 +87,17 @@ static int vesafb_pan_display(struct fb_
 	return 0;
 }
 
-static void vesa_setpalette(int regno, unsigned red, unsigned green, unsigned blue)
+static void vesa_setpalette(int regno, unsigned red, unsigned green, 
+			    unsigned blue, struct fb_var_screeninfo *var)
 {
 #ifdef __i386__
 	struct { u_char blue, green, red, pad; } entry;
+	int shift = 16 - var->green.length;
 
 	if (pmi_setpal) {
-		entry.red   = red   >> 10;
-		entry.green = green >> 10;
-		entry.blue  = blue  >> 10;
+		entry.red   = red   >> shift;
+		entry.green = green >> shift;
+		entry.blue  = blue  >> shift;
 		entry.pad   = 0;
 	        __asm__ __volatile__(
                 "call *(%%esi)"
@@ -109,9 +111,9 @@ static void vesa_setpalette(int regno, u
 	} else {
 		/* without protected mode interface, try VGA registers... */
 		outb_p(regno,       dac_reg);
-		outb_p(red   >> 10, dac_val);
-		outb_p(green >> 10, dac_val);
-		outb_p(blue  >> 10, dac_val);
+		outb_p(red   >> shift, dac_val);
+		outb_p(green >> shift, dac_val);
+		outb_p(blue  >> shift, dac_val);
 	}
 #endif
 }
@@ -132,7 +134,7 @@ static int vesafb_setcolreg(unsigned reg
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		vesa_setpalette(regno,red,green,blue);
+		vesa_setpalette(regno,red,green,blue, &info->var);
 		break;
 	case 16:
 		if (info->var.red.offset == 10) {
@@ -331,30 +333,26 @@ static int __init vesafb_probe(struct de
 	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
 	vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
 	
-	if (vesafb_defined.bits_per_pixel > 8) {
-		vesafb_defined.red.offset    = screen_info.red_pos;
-		vesafb_defined.red.length    = screen_info.red_size;
-		vesafb_defined.green.offset  = screen_info.green_pos;
-		vesafb_defined.green.length  = screen_info.green_size;
-		vesafb_defined.blue.offset   = screen_info.blue_pos;
-		vesafb_defined.blue.length   = screen_info.blue_size;
-		vesafb_defined.transp.offset = screen_info.rsvd_pos;
-		vesafb_defined.transp.length = screen_info.rsvd_size;
-		printk(KERN_INFO "vesafb: directcolor: "
-		       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
-		       screen_info.rsvd_size,
-		       screen_info.red_size,
-		       screen_info.green_size,
-		       screen_info.blue_size,
-		       screen_info.rsvd_pos,
-		       screen_info.red_pos,
-		       screen_info.green_pos,
-		       screen_info.blue_pos);
-	} else {
-		vesafb_defined.red.length   = 6;
-		vesafb_defined.green.length = 6;
-		vesafb_defined.blue.length  = 6;
-	}
+	vesafb_defined.red.offset    = screen_info.red_pos;
+	vesafb_defined.red.length    = screen_info.red_size;
+	vesafb_defined.green.offset  = screen_info.green_pos;
+	vesafb_defined.green.length  = screen_info.green_size;
+	vesafb_defined.blue.offset   = screen_info.blue_pos;
+	vesafb_defined.blue.length   = screen_info.blue_size;
+	vesafb_defined.transp.offset = screen_info.rsvd_pos;
+	vesafb_defined.transp.length = screen_info.rsvd_size;
+	printk(KERN_INFO "vesafb: %s: "
+	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+	       (vesafb_defined.bits_per_pixel > 8) ?
+	       "Truecolor" : "Pseudocolor", 
+	       screen_info.rsvd_size,
+	       screen_info.red_size,
+	       screen_info.green_size,
+	       screen_info.blue_size,
+	       screen_info.rsvd_pos,
+	       screen_info.red_pos,
+	       screen_info.green_pos,
+	       screen_info.blue_pos);
 
 	vesafb_fix.ypanstep  = ypan     ? 1 : 0;
 	vesafb_fix.ywrapstep = (ypan>1) ? 1 : 0;




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
