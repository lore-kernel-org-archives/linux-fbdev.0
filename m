From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 22 Feb 2011 22:36:45 +0000
Subject: [PATCH] s3fb: fix 15/16bpp modes with over 115MHz pixclocks on 86C365 Trio3D
Message-Id: <201102222336.48506.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>

Enable pixel multiplexing in 15/16bpp modes when pixclock is over 115MHz
on Trio3D (86C365) cards to fix artifacts on the left side of screen.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.38-rc4-/drivers/video/s3fb.c	2011-02-20 20:48:41.000000000 +0100
+++ linux-2.6.38-rc4/drivers/video/s3fb.c	2011-02-22 23:31:16.000000000 +0100
@@ -675,6 +675,15 @@
 				svga_wcrt_mask(par->state.vgabase, 0x67, 0x20, 0xF0);
 			else
 				svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
+		} else if (par->chip = CHIP_365_TRIO3D) {
+			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
+			if (info->var.pixclock > 8695) {
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
+				hmul = 2;
+			} else {
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x20, 0xF0);
+				multiplex = 1;
+			}
 		} else {
 			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
 			svga_wcrt_mask(par->state.vgabase, 0x67, 0x30, 0xF0);
@@ -691,6 +700,15 @@
 				svga_wcrt_mask(par->state.vgabase, 0x67, 0x40, 0xF0);
 			else
 				svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);
+		} else if (par->chip = CHIP_365_TRIO3D) {
+			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
+			if (info->var.pixclock > 8695) {
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);
+				hmul = 2;
+			} else {
+				svga_wcrt_mask(par->state.vgabase, 0x67, 0x40, 0xF0);
+				multiplex = 1;
+			}
 		} else {
 			svga_wcrt_mask(par->state.vgabase, 0x50, 0x10, 0x30);
 			svga_wcrt_mask(par->state.vgabase, 0x67, 0x50, 0xF0);


-- 
Ondrej Zary
