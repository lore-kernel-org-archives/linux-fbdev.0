From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/2] vesafb: Add blanking support
Date: Wed, 27 Jul 2005 08:37:53 +0800
Message-ID: <42E6D761.7040309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxZwP-0001uA-R8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 17:38:33 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DxZwP-0007W1-Jo
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Jul 2005 17:38:33 -0700
Received: by wproxy.gmail.com with SMTP id i20so60290wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Jul 2005 17:38:27 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

   Add rudimentary support by manipulating the VGA registers. However,
   not all vesa modes are VGA compatible, so VGA compatiblity is
   checked first. Only 2 levels are supported, powerup and powerdown.

   From: Antonino Daplas <adaplas@pol.net>
   Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

arch/i386/boot/video.S |    9 +++++++--
drivers/video/vesafb.c |   38 ++++++++++++++++++++++++++++++++++++++
include/linux/tty.h    |    3 ++-
3 files changed, 47 insertions(+), 3 deletions(-)

Index: arch/i386/boot/video.S
===================================================================
--- b0d937f67545c922e19f4f0680d1d02d6fbc035f/arch/i386/boot/video.S  (mode:100644)
+++ 86b5df80031a3c68459cc684c4ee9e00e9e38873/arch/i386/boot/video.S  (mode:100644)
@@ -97,7 +97,8 @@
#define PARAM_VESAPM_OFF	0x30
#define PARAM_LFB_PAGES		0x32
#define PARAM_VESA_ATTRIB	0x34
-
+#define PARAM_CAPABILITIES      0x36
+	
/* Define DO_STORE according to CONFIG_VIDEO_RETAIN */
#ifdef CONFIG_VIDEO_RETAIN
#define DO_STORE call store_screen
@@ -224,7 +225,7 @@
	movl	%eax, %fs:(PARAM_LFB_COLORS+4)
	movw	0(%di), %ax
	movw	%ax, %fs:(PARAM_VESA_ATTRIB)
-
+	
# get video mem size
	leaw	modelist+1024, %di
	movw	$0x4f00, %ax
@@ -233,6 +234,10 @@
	movw	18(%di), %ax
	movl	%eax, %fs:(PARAM_LFB_SIZE)

+# store mode capabilities
+	movl    10(%di), %eax
+	movl    %eax, %fs:(PARAM_CAPABILITIES)
+
# switching the DAC to 8-bit is for <= 8 bpp only
	movw	%fs:(PARAM_LFB_DEPTH), %ax
	cmpw	$8, %ax
Index: drivers/video/vesafb.c
===================================================================
--- b0d937f67545c922e19f4f0680d1d02d6fbc035f/drivers/video/vesafb.c  (mode:100644)
+++ 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/vesafb.c  (mode:100644)
@@ -19,6 +19,7 @@
#include <linux/fb.h>
#include <linux/ioport.h>
#include <linux/init.h>
+#include <video/vga.h>
#include <asm/io.h>
#include <asm/mtrr.h>

@@ -54,6 +55,7 @@
static void            (*pmi_start)(void);
static void            (*pmi_pal)(void);
static int             depth;
+static int             vga_compat;

/* --------------------------------------------------------------------- */

@@ -86,6 +88,37 @@
	return 0;
}

+static int vesafb_blank(int blank, struct fb_info *info)
+{
+	int err = 1;
+
+	if (vga_compat) {
+		int loop = 10000;
+		u8 seq = 0, crtc17 = 0;
+	    
+		err = 0;
+
+		if (blank) {
+			seq = 0x20;
+			crtc17 = 0x00;
+		} else {
+			seq = 0x00;
+			crtc17 = 0x80;
+		}
+		
+		vga_wseq(NULL, 0x00, 0x01);
+		seq |= vga_rseq(NULL, 0x01) & ~0x20;
+		vga_wseq(NULL, 0x00, seq);
+		
+		crtc17 |= vga_rcrt(NULL, 0x17) & ~0x80;
+		while (loop--);
+		vga_wcrt(NULL, 0x17, crtc17);
+		vga_wseq(NULL, 0x00, 0x03);		  
+	}
+
+	return err;
+}
+
static void vesa_setpalette(int regno, unsigned red, unsigned green,
			    unsigned blue)
{
@@ -176,6 +209,7 @@
	.owner		= THIS_MODULE,
	.fb_setcolreg	= vesafb_setcolreg,
	.fb_pan_display	= vesafb_pan_display,
+	.fb_blank       = vesafb_blank,
	.fb_fillrect	= cfb_fillrect,
	.fb_copyarea	= cfb_copyarea,
	.fb_imageblit	= cfb_imageblit,
@@ -404,6 +438,10 @@
	info->flags = FBINFO_FLAG_DEFAULT |
		(ypan) ? FBINFO_HWACCEL_YPAN : 0;

+	vga_compat = (screen_info.capabilities & 2) ? 0 : 1; 
+	printk("vesafb: Mode is %sVGA compatible\n",
+	       (vga_compat) ? "" : "not ");
+	
	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
		err = -ENOMEM;
		goto err;
Index: include/linux/tty.h
===================================================================
--- b0d937f67545c922e19f4f0680d1d02d6fbc035f/include/linux/tty.h  (mode:100644)
+++ 86b5df80031a3c68459cc684c4ee9e00e9e38873/include/linux/tty.h  (mode:100644)
@@ -74,7 +74,8 @@
	u16 vesapm_off;		/* 0x30 */
	u16 pages;		/* 0x32 */
	u16 vesa_attributes;	/* 0x34 */
-				/* 0x36 -- 0x3f reserved for future expansion */
+	u32  capabilities;      /* 0x36 */
+				/* 0x3a -- 0x3f reserved for future expansion */
};

extern struct screen_info screen_info;




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
