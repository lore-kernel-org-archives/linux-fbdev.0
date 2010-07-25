From: Ondrej Zary <linux@rainbow-software.org>
Date: Sun, 25 Jul 2010 16:52:30 +0000
Subject: [PATCH] cyber2000fb: fix machine hang on module load
Message-Id: <201007251852.32397.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Hello,
I was testing two CyberPro 2000 based PCI cards on x86 and the machine always
hanged completely when the cyber2000fb module was loaded. It seems that the
card hangs when some registers are accessed too quickly after writing RAMDAC
control register. With this patch, both card work.

Add delay after RAMDAC control register write to prevent hangs on module load.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.35-rc2/drivers/video/cyber2000fb.c	2010-06-06 05:43:24.000000000 +0200
+++ linux-2.6.35-rc3/drivers/video/cyber2000fb.c	2010-07-25 18:20:47.000000000 +0200
@@ -436,6 +436,7 @@ static void cyber2000fb_write_ramdac_ctr
 	cyber2000fb_writeb(i | 4, 0x3cf, cfb);
 	cyber2000fb_writeb(val, 0x3c6, cfb);
 	cyber2000fb_writeb(i, 0x3cf, cfb);
+	udelay(1);
 }
 
 static void cyber2000fb_set_timing(struct cfb_info *cfb, struct par_info *hw)


-- 
Ondrej Zary
