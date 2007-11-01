From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: more precise clock
	calculation
Date: Thu, 1 Nov 2007 15:17:31 +0100
Message-ID: <20071101151731.9aae64ea.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InahJ-0002JQ-No for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 07:07:02 -0700
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1InahJ-0005TR-3W
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 07:07:01 -0700
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id C91F92EB29C
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  1 Nov 2007 15:06:57 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 4F2392BF637
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu,  1 Nov 2007 15:06:57 +0100 (CET)
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The pixclock calculation is done in kHz instead in MHz. This allow
much more precise pixclock matching.

Additionally, the vclk field is removed from the par structure
and calculation of pixclock prefer now lower k values.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch requires previous tridentfb patches sent to this list.

diff -urp linux-ref/drivers/video/tridentfb.c linux-2.6.23/drivers/video/tridentfb.c
--- linux-ref/drivers/video/tridentfb.c	2007-11-01 15:10:03.674079571 +0100
+++ linux-2.6.23/drivers/video/tridentfb.c	2007-11-01 15:02:17.622078751 +0100
@@ -27,7 +27,6 @@
 #define VERSION		"0.7.8-NEWAPI"
 
 struct tridentfb_par {
-	int vclk;		/* in MHz */
 	void __iomem *io_virt;	/* iospace virtual memory address */
 };
 
@@ -676,18 +675,18 @@ static void set_screen_start(int base)
 		 (read3X4(CRTHiOrd) & 0xF8) | ((base & 0xE0000) >> 17));
 }
 
-/* Use 20.12 fixed-point for NTSC value and frequency calculation */
-#define calc_freq(n, m, k)  ( ((unsigned long)0xE517 * (n + 8) / ((m + 2) * (1 << k))) >> 12 )
+/* NTSC value and frequency calculation */
+#define calc_freq(n, m, k)  (((14318L * (n + 8)) / (m + 2) ) >> k)
 
 /* Set dotclock frequency */
-static void set_vclk(int freq)
+static void set_vclk(unsigned long freq)
 {
 	int m, n, k;
-	int f, fi, d, di;
+	unsigned long f, fi, d, di;
 	unsigned char lo = 0, hi = 0;
 
-	d = 20;
-	for (k = 2; k >= 0; k--)
+	d = 50000;
+	for (k = 0; k < 3; k++)
 		for (m = 0; m < 63; m++)
 			for (n = 0; n < 128; n++) {
 				fi = calc_freq(n, m, k);
@@ -894,6 +893,8 @@ static int tridentfb_set_par(struct fb_i
 	struct fb_var_screeninfo *var = &info->var;
 	int bpp = var->bits_per_pixel;
 	unsigned char tmp;
+	unsigned long vclk;
+
 	debug("enter\n");
 	hdispend = var->xres / 8 - 1;
 	hsyncstart = (var->xres + var->right_margin) / 8;
@@ -1020,11 +1021,10 @@ static int tridentfb_set_par(struct fb_i
 	write3X4(Performance, 0x92);
 	write3X4(PCIReg, 0x07);		/* MMIO & PCI read and write burst enable */
 
-	/* convert from picoseconds to MHz */
-	par->vclk = 1000000 / info->var.pixclock;
+	vclk = PICOS2KHZ(info->var.pixclock);
 	if (bpp == 32)
-		par->vclk *= 2;
-	set_vclk(par->vclk);
+		vclk *= 2;
+	set_vclk(vclk);
 
 	write3C4(0, 3);
 	write3C4(1, 1);		/* set char clock 8 dots wide */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
