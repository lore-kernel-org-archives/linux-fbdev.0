From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: LCDC startup fix
Date: Fri, 23 Nov 2007 16:12:22 +0100
Message-ID: <4746EDD6.6060301@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvacM-0007qD-Ah for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 07:38:58 -0800
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IvacK-0007ax-Kw
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Nov 2007 07:38:58 -0800
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: Anti Sullin <anti.sullin@artecdesign.ee>, Patrice Vilchez <patrice.vilchez@atmel.com>, Andrew Victor <linux@maxim.org.za>, Linux Kernel list <linux-kernel@vger.kernel.org>

From: Anti Sullin <anti.sullin@artecdesign.ee>

This patch adds an additional loop, that delays turning off the DMA 
until the LCDC core has been turned off. This prevents the picture 
to be shifted some random length when the kernel re-initializes
the LCDC.

Signed-off-by: Anti Sullin <anti.sullin@artecdesign.ee>
Signed-off-by: Andrew Victor <andrew@sanpeople.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---

Without this patch, the LCDC keeps running for some small time 
after the PWRCON:LCD_PWR has been cleared ; the FIFO suffers 
an underrun and on re-starting the LCDC the FIFO data 
stays shifted.
This behavior has been seen and fixed on AT91SAM9261-EK and 
two custom AT91SAM9261 boards, all of them having different 
LCD panels.

Thanks a lot to Anti Sullin for submitting this patch (long 
time ago).

--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -268,6 +268,10 @@
 	/* Turn off the LCD controller and the DMA controller */
 	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON, sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
 
+	/* Wait for the LCDC core to become idle */
+	while (lcdc_readl(sinfo, ATMEL_LCDC_PWRCON) & ATMEL_LCDC_BUSY)
+		msleep(10);
+
 	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, 0);
 
 	if (info->var.bits_per_pixel == 1)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
