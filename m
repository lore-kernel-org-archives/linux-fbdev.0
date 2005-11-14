From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] vesafb: Drop blank hook
Date: Mon, 14 Nov 2005 17:22:40 +0800
Message-ID: <43785760.1060202@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbaYH-0000PZ-Ac
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 01:23:01 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EbaYF-0003OV-RV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Nov 2005 01:23:01 -0800
Received: by zproxy.gmail.com with SMTP id z3so835190nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Nov 2005 01:22:56 -0800 (PST)
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

From: Bugzilla Bug 5351

"After resuming from S3 (suspended  while in X), the LCD
panel stays black . However, the laptop is up again, and I can SSH into it
from another machine.

I can get the panel working again, when I first direct video output to the CRT
output of the laptop, and then back to LCD (done by repeatedly hitting Fn+F5
buttons on the Toshiba, which directs output to either LCD, CRT or TV) 
None of this ever happened with older kernels."

This bug is due to the recently added vesafb_blank() method in vesafb. It
works with CRT displays, but has a high incidence of problems in laptop
users.  Since CRT users don't really get that much benefit from hardware
blanking, drop support for this.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 arch/i386/boot/video.S |    5 -----
 drivers/video/vesafb.c |   37 -------------------------------------
 include/linux/tty.h    |    3 +--
 3 files changed, 1 insertion(+), 44 deletions(-)


diff --git a/arch/i386/boot/video.S b/arch/i386/boot/video.S
index 92f6694..2ac40c8 100644
--- a/arch/i386/boot/video.S
+++ b/arch/i386/boot/video.S
@@ -97,7 +97,6 @@
 #define PARAM_VESAPM_OFF	0x30
 #define PARAM_LFB_PAGES		0x32
 #define PARAM_VESA_ATTRIB	0x34
-#define PARAM_CAPABILITIES      0x36
 
 /* Define DO_STORE according to CONFIG_VIDEO_RETAIN */
 #ifdef CONFIG_VIDEO_RETAIN
@@ -234,10 +233,6 @@ mopar_gr:
 	movw	18(%di), %ax
 	movl	%eax, %fs:(PARAM_LFB_SIZE)
 
-# store mode capabilities
-	movl    10(%di), %eax
-	movl    %eax, %fs:(PARAM_CAPABILITIES)
-
 # switching the DAC to 8-bit is for <= 8 bpp only
 	movw	%fs:(PARAM_LFB_DEPTH), %ax
 	cmpw	$8, %ax
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index b82511e..c5899ac 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -57,7 +57,6 @@ static unsigned short  *pmi_base  = NULL
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
 static int             depth;
-static int             vga_compat;
 
 /* --------------------------------------------------------------------- */
 
@@ -90,37 +89,6 @@ static int vesafb_pan_display(struct fb_
 	return 0;
 }
 
-static int vesafb_blank(int blank, struct fb_info *info)
-{
-	int err = 1;
-
-	if (vga_compat) {
-		int loop = 10000;
-		u8 seq = 0, crtc17 = 0;
-
-		if (blank == FB_BLANK_POWERDOWN) {
-			seq = 0x20;
-			crtc17 = 0x00;
-			err = 0;
-		} else {
-			seq = 0x00;
-			crtc17 = 0x80;
-			err = (blank == FB_BLANK_UNBLANK) ? 0 : -EINVAL;
-		}
-
-		vga_wseq(NULL, 0x00, 0x01);
-		seq |= vga_rseq(NULL, 0x01) & ~0x20;
-		vga_wseq(NULL, 0x00, seq);
-
-		crtc17 |= vga_rcrt(NULL, 0x17) & ~0x80;
-		while (loop--);
-		vga_wcrt(NULL, 0x17, crtc17);
-		vga_wseq(NULL, 0x00, 0x03);
-	}
-
-	return err;
-}
-
 static void vesa_setpalette(int regno, unsigned red, unsigned green,
 			    unsigned blue)
 {
@@ -205,7 +173,6 @@ static struct fb_ops vesafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_setcolreg	= vesafb_setcolreg,
 	.fb_pan_display	= vesafb_pan_display,
-	.fb_blank       = vesafb_blank,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -460,10 +427,6 @@ static int __init vesafb_probe(struct de
 	info->flags = FBINFO_FLAG_DEFAULT |
 		(ypan) ? FBINFO_HWACCEL_YPAN : 0;
 
-	vga_compat = (screen_info.capabilities & 2) ? 0 : 1;
-	printk("vesafb: Mode is %sVGA compatible\n",
-	       (vga_compat) ? "" : "not ");
-
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
 		goto err;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 56a089e..a7c6e76 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -74,8 +74,7 @@ struct screen_info {
 	u16 vesapm_off;		/* 0x30 */
 	u16 pages;		/* 0x32 */
 	u16 vesa_attributes;	/* 0x34 */
-	u32  capabilities;      /* 0x36 */
-				/* 0x3a -- 0x3f reserved for future expansion */
+				/* 0x36 -- 0x3f reserved for future expansion */
 };
 
 extern struct screen_info screen_info;


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
