From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vesafb: Fix incorrect logo colors in x86_64
Date: Sun, 09 Apr 2006 22:01:22 +0800
Message-ID: <443913B2.7080403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSaVq-0000cw-IE
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 07:03:34 -0700
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FSaVp-00032O-7L
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 07:03:34 -0700
Received: by pproxy.gmail.com with SMTP id i49so881641pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Apr 2006 07:03:32 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Bugzilla Bug 6299:

A pixel size of 8 bits produces wrong logo colors in x86_64.

The driver has 2 methods for setting the color map, using the protected mode
interface provided by the video BIOS and directly writing to the VGA
registers. The former is not supported in x86_64 and the latter is enabled
only in i386.

Fix by enabling the latter method in x86_64 only if supported by the BIOS.
If both methods are unsupported, change the visual of vesafb to
STATIC_PSEUDOCOLOR.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/boot/video.S      |    5 +++++
 arch/x86_64/boot/video.S    |    5 +++++
 drivers/video/vesafb.c      |   27 +++++++++++++++++++++------
 include/linux/screen_info.h |    3 ++-
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index 0000a26..c9343c3 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -97,6 +97,7 @@
 #define PARAM_VESAPM_OFF	0x30
 #define PARAM_LFB_PAGES		0x32
 #define PARAM_VESA_ATTRIB	0x34
+#define PARAM_CAPABILITIES	0x36
 
 /* Define DO_STORE according to CONFIG_VIDEO_RETAIN */
 #ifdef CONFIG_VIDEO_RETAIN
@@ -233,6 +234,10 @@ mopar_gr:
 	movw	18(%di), %ax
 	movl	%eax, %fs:(PARAM_LFB_SIZE)
 
+# store mode capabilities
+	movl 10(%di), %eax
+	movl %eax, %fs:(PARAM_CAPABILITIES)
+
 # switching the DAC to 8-bit is for <= 8 bpp only
 	movw	%fs:(PARAM_LFB_DEPTH), %ax
 	cmpw	$8, %ax
diff --git a/arch/x86_64/boot/video.S b/arch/x86_64/boot/video.S
index 0587477..32327bb 100644
--- a/arch/x86_64/boot/video.S
+++ b/arch/x86_64/boot/video.S
@@ -97,6 +97,7 @@
 #define PARAM_VESAPM_OFF	0x30
 #define PARAM_LFB_PAGES		0x32
 #define PARAM_VESA_ATTRIB	0x34
+#define PARAM_CAPABILITIES	0x36
 
 /* Define DO_STORE according to CONFIG_VIDEO_RETAIN */
 #ifdef CONFIG_VIDEO_RETAIN
@@ -233,6 +234,10 @@ mopar_gr:
 	movw	18(%di), %ax
 	movl	%eax, %fs:(PARAM_LFB_SIZE)
 
+# store mode capabilities
+	movl 10(%di), %eax
+	movl %eax, %fs:(PARAM_CAPABILITIES)
+
 # switching the DAC to 8-bit is for <= 8 bpp only
 	movw	%fs:(PARAM_LFB_DEPTH), %ax
 	cmpw	$8, %ax
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index 8982e54..b0b9acf 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -57,7 +57,7 @@ static unsigned short  *pmi_base  = NULL
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
 static int             depth;
-
+static int             vga_compat;
 /* --------------------------------------------------------------------- */
 
 static int vesafb_pan_display(struct fb_var_screeninfo *var,
@@ -83,9 +83,10 @@ static int vesafb_pan_display(struct fb_
 static void vesa_setpalette(int regno, unsigned red, unsigned green,
 			    unsigned blue)
 {
+	int shift = 16 - depth;
+
 #ifdef __i386__
 	struct { u_char blue, green, red, pad; } entry;
-	int shift = 16 - depth;
 
 	if (pmi_setpal) {
 		entry.red   = red   >> shift;
@@ -101,14 +102,20 @@ static void vesa_setpalette(int regno, u
                   "d" (regno),          /* EDX */
                   "D" (&entry),         /* EDI */
                   "S" (&pmi_pal));      /* ESI */
-	} else {
-		/* without protected mode interface, try VGA registers... */
+		return;
+	}
+#endif
+
+/*
+ * without protected mode interface and if VGA compatible,
+ * try VGA registers...
+ */
+	if (vga_compat) {
 		outb_p(regno,       dac_reg);
 		outb_p(red   >> shift, dac_val);
 		outb_p(green >> shift, dac_val);
 		outb_p(blue  >> shift, dac_val);
 	}
-#endif
 }
 
 static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
@@ -214,6 +221,7 @@ static int __init vesafb_probe(struct pl
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENODEV;
 
+	vga_compat = (screen_info.capabilities & 2) ? 0 : 1;
 	vesafb_fix.smem_start = screen_info.lfb_base;
 	vesafb_defined.bits_per_pixel = screen_info.lfb_depth;
 	if (15 == vesafb_defined.bits_per_pixel)
@@ -318,6 +326,12 @@ static int __init vesafb_probe(struct pl
 		}
 	}
 
+	if (vesafb_defined.bits_per_pixel == 8 && !pmi_setpal && !vga_compat) {
+		printk(KERN_WARNING "vesafb: hardware palette is unchangeable,\n"
+		                    "        colors may be incorrect\n");
+		vesafb_fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+	}
+
 	vesafb_defined.xres_virtual = vesafb_defined.xres;
 	vesafb_defined.yres_virtual = vesafb_fix.smem_len / vesafb_fix.line_length;
 	if (ypan && vesafb_defined.yres_virtual > vesafb_defined.yres) {
@@ -354,7 +368,8 @@ static int __init vesafb_probe(struct pl
 	printk(KERN_INFO "vesafb: %s: "
 	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
 	       (vesafb_defined.bits_per_pixel > 8) ?
-	       "Truecolor" : "Pseudocolor",
+	       "Truecolor" : (vga_compat || pmi_setpal) ?
+	       "Pseudocolor" : "Static Pseudocolor",
 	       screen_info.rsvd_size,
 	       screen_info.red_size,
 	       screen_info.green_size,
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
index 6336987..2925e66 100644
--- a/include/linux/screen_info.h
+++ b/include/linux/screen_info.h
@@ -41,7 +41,8 @@ struct screen_info {
 	u16 vesapm_off;		/* 0x30 */
 	u16 pages;		/* 0x32 */
 	u16 vesa_attributes;	/* 0x34 */
-				/* 0x36 -- 0x3f reserved for future expansion */
+	u32 capabilities;       /* 0x36 */
+				/* 0x3a -- 0x3f reserved for future expansion */
 };
 
 extern struct screen_info screen_info;



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
