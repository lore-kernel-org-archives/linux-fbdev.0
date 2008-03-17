From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: Re: [PATCH] i810fb: Fix console switch regression
Date: Mon, 17 Mar 2008 16:41:10 +0100
Message-ID: <200803171641.10750.stefan.bauer@cs.tu-chemnitz.de>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de> <Pine.LNX.4.64.0803162042460.7207@anakin> <200803170920.33626.stefan.bauer@cs.tu-chemnitz.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753953AbYCQPlk@vger.kernel.org>
In-Reply-To: <200803170920.33626.stefan.bauer@cs.tu-chemnitz.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@pol.net>

I'm sorry for the spaces in the second patch, here's a clean one with tabs.

---
From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>

Since 4c7ffe0b9f7f40bd818fe3af51342f64c483908e ("fbdev: prevent drivers that 
have hardware cursors from calling software cursor code") every call of 
i810fb_cursor fails with -ENXIO because of a incorrect "!".

This hasn't striked until eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix ! 
versus & precedence in various places") surrounded the expression with 
braces, so that the intended behavior was inverted. That caused 'pixel 
waste' - the same line of multi-colored pixels repeated over the whole 
screen - during console switch.

This switches back to the original pre-4c7ffe0 behavior.

Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>

--- linux-2.6/drivers/video/i810/i810_main.c.orig
+++ linux-2.6/drivers/video/i810/i810_main.c
@@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info 
 	struct i810fb_par *par = info->par;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (!(par->dev_flags & LOCKUP))
+	if (par->dev_flags & LOCKUP)
 		return -ENXIO;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
