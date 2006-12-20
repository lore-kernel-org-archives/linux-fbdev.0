From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] gxt4500: Fix colormap and PLL setting,
	support GXT6000P
Date: Wed, 20 Dec 2006 14:14:13 +1100
Message-ID: <17800.43653.166356.610480@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GwruT-00041y-DL for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Dec 2006 19:14:25 -0800
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GwruS-0006Z2-BZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Dec 2006 19:14:25 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net
Cc: camonett@woh.rr.com

This fixes some bugs in the gxt4500 framebuffer driver, and adds
support for GXT6000P cards.

First, I had the red and blue channels swapped in the colormap update
code, resulting in penguins' noses and feet turning blue (though the
penguins weren't actually shivering :).

Secondly, the code that calculated the values to put in the PLL that
generates the pixel clock wasn't observing some constraints that I
wasn't originally aware of, but am now that I have some documentation
on the chip.

The GXT6000P is essentially identical from software's point of view,
except for a different reference clock for the PLL, and the addition
of a geometry engine (which this driver doesn't use).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
I would like this to go into 2.6.20, since these bugs need to be fixed
for reliable and correct operation of the card.

diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 3adf6ab..23a6bcc 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -1,5 +1,5 @@
 /*
- * Frame buffer device for IBM GXT4500P display adaptor
+ * Frame buffer device for IBM GXT4500P and GXT6000P display adaptors
  *
  * Copyright (C) 2006 Paul Mackerras, IBM Corp. <paulus@samba.org>
  */
@@ -11,8 +11,10 @@ #include <linux/console.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define PCI_DEVICE_ID_IBM_GXT4500P	0x21c
+#define PCI_DEVICE_ID_IBM_GXT6000P	0x170
 
 /* GXT4500P registers */
 
@@ -94,6 +96,7 @@ #define   SYNC_CTL_VSYNC_OFF		0x40
 #define PLL_M			0x4040
 #define PLL_N			0x4044
 #define PLL_POSTDIV		0x4048
+#define PLL_C			0x404c
 
 /* Hardware cursor */
 #define CURSOR_X		0x4078
@@ -140,6 +143,7 @@ struct gxt4500_par {
 	int pixfmt;		/* pixel format, see DFA_PIX_* values */
 
 	/* PLL parameters */
+	int refclk_ps;		/* ref clock period in picoseconds */
 	int pll_m;		/* ref clock divisor */
 	int pll_n;		/* VCO divisor */
 	int pll_pd1;		/* first post-divisor */
@@ -166,6 +170,21 @@ static const struct fb_videomode default
 	.vmode = FB_VMODE_NONINTERLACED
 };
 
+/* List of supported cards */
+enum gxt_cards {
+	GXT4500P,
+	GXT6000P
+};
+
+/* Card-specific information */
+static const struct cardinfo {
+	int	refclk_ps;	/* period of PLL reference clock in ps */
+	const char *cardname;
+} cardinfo[] = {
+	[GXT4500P] = { .refclk_ps = 9259, .cardname = "IBM GXT4500P" },
+	[GXT6000P] = { .refclk_ps = 40000, .cardname = "IBM GXT6000P" },
+};
+
 /*
  * The refclk and VCO dividers appear to use a linear feedback shift
  * register, which gets reloaded when it reaches a terminal value, at
@@ -203,27 +222,16 @@ static const unsigned char ndivtab[] = {
 /* 130 */	0x9e, 0x4f, 0x27, 0x93, 0xc9, 0xe4, 0x72, 0x39, 0x1c, 0x0e,
 /* 140 */	0x87, 0xc3, 0x61, 0x30, 0x18, 0x8c, 0xc6, 0x63, 0x31, 0x98,
 /* 150 */	0xcc, 0xe6, 0x73, 0xb9, 0x5c, 0x2e, 0x97, 0x4b, 0xa5, 0xd2,
-/* 160 */	0x69, 0xb4, 0xda, 0xed, 0x76, 0xbb, 0x5d, 0xae, 0xd7, 0x6b,
-/* 170 */	0xb5, 0x5a, 0xad, 0x56, 0xab, 0xd5, 0x6a, 0x35, 0x1a, 0x8d,
-/* 180 */	0x46, 0x23, 0x11, 0x88, 0x44, 0x22, 0x91, 0xc8, 0x64, 0x32,
-/* 190 */	0x19, 0x0c, 0x86, 0x43, 0x21, 0x10, 0x08, 0x04, 0x02, 0x81,
-/* 200 */	0x40, 0xa0, 0xd0, 0x68, 0x34, 0x9a, 0xcd, 0x66, 0x33, 0x99,
-/* 210 */	0x4c, 0xa6, 0x53, 0xa9, 0xd4, 0xea, 0x75, 0x3a, 0x9d, 0xce,
-/* 220 */	0xe7, 0xf3, 0xf9, 0x7c, 0x3e, 0x1f, 0x8f, 0x47, 0xa3, 0x51,
-/* 230 */	0xa8, 0x54, 0xaa, 0x55, 0x2a, 0x15, 0x0a, 0x05, 0x82, 0xc1,
-/* 240 */	0x60, 0xb0, 0x58, 0xac, 0xd6, 0xeb, 0xf5, 0x7a, 0xbd, 0xde,
-/* 250 */	0x6f, 0x37, 0x1b, 0x0d, 0x06, 0x03, 0x01,
+/* 160 */	0x69,
 };
 
-#define REF_PERIOD_PS	9259	/* period of reference clock in ps */
-
 static int calc_pll(int period_ps, struct gxt4500_par *par)
 {
 	int m, n, pdiv1, pdiv2, postdiv;
-	int pll_period, best_error, t;
+	int pll_period, best_error, t, intf;
 
-	/* only deal with range 1MHz - 400MHz */
-	if (period_ps < 2500 || period_ps > 1000000)
+	/* only deal with range 5MHz - 300MHz */
+	if (period_ps < 3333 || period_ps > 200000)
 		return -1;
 
 	best_error = 1000000;
@@ -231,14 +239,17 @@ static int calc_pll(int period_ps, struc
 		for (pdiv2 = 1; pdiv2 <= pdiv1; ++pdiv2) {
 			postdiv = pdiv1 * pdiv2;
 			pll_period = (period_ps + postdiv - 1) / postdiv;
-			/* keep pll in range 500..1250 MHz */
-			if (pll_period < 800 || pll_period > 2000)
+			/* keep pll in range 350..600 MHz */
+			if (pll_period < 1666 || pll_period > 2857)
 				continue;
-			for (m = 3; m <= 40; ++m) {
-				n = REF_PERIOD_PS * m * postdiv / period_ps;
-				if (n < 5 || n > 256)
+			for (m = 1; m <= 64; ++m) {
+				intf = m * par->refclk_ps;
+				if (intf > 500000)
+					break;
+				n = intf * postdiv / period_ps;
+				if (n < 3 || n > 160)
 					continue;
-				t = REF_PERIOD_PS * m * postdiv / n;
+				t = par->refclk_ps * m * postdiv / n;
 				t -= period_ps;
 				if (t >= 0 && t < best_error) {
 					par->pll_m = m;
@@ -257,7 +268,7 @@ static int calc_pll(int period_ps, struc
 
 static int calc_pixclock(struct gxt4500_par *par)
 {
-	return REF_PERIOD_PS * par->pll_m * par->pll_pd1 * par->pll_pd2
+	return par->refclk_ps * par->pll_m * par->pll_pd1 * par->pll_pd2
 		/ par->pll_n;
 }
 
@@ -357,7 +368,7 @@ static int gxt4500_set_par(struct fb_inf
 	struct gxt4500_par *par = info->par;
 	struct fb_var_screeninfo *var = &info->var;
 	int err;
-	u32 ctrlreg;
+	u32 ctrlreg, tmp;
 	unsigned int dfa_ctl, pixfmt, stride;
 	unsigned int wid_tiles, i;
 	unsigned int prefetch_pix, htot;
@@ -376,10 +387,25 @@ static int gxt4500_set_par(struct fb_inf
 	writereg(par, DTG_CONTROL, ctrlreg);
 
 	/* set PLL registers */
+	tmp = readreg(par, PLL_C) & ~0x7f;
+	if (par->pll_n < 38)
+		tmp |= 0x29;
+	if (par->pll_n < 69)
+		tmp |= 0x35;
+	else if (par->pll_n < 100)
+		tmp |= 0x76;
+	else
+		tmp |= 0x7e;
+	writereg(par, PLL_C, tmp);
 	writereg(par, PLL_M, mdivtab[par->pll_m - 1]);
 	writereg(par, PLL_N, ndivtab[par->pll_n - 2]);
-	writereg(par, PLL_POSTDIV,
-		 ((8 - par->pll_pd1) << 3) | (8 - par->pll_pd2));
+	tmp = ((8 - par->pll_pd2) << 3) | (8 - par->pll_pd1);
+	if (par->pll_pd1 == 8 || par->pll_pd2 == 8) {
+		/* work around erratum */
+		writereg(par, PLL_POSTDIV, tmp | 0x9);
+		udelay(1);
+	}
+	writereg(par, PLL_POSTDIV, tmp);
 	msleep(20);
 
 	/* turn off hardware cursor */
@@ -483,8 +509,8 @@ static int gxt4500_setcolreg(unsigned in
 
 	if (reg > 1023)
 		return 1;
-	cmap_entry = ((transp & 0xff00) << 16) | ((blue & 0xff00) << 8) |
-		(green & 0xff00) | (red >> 8);
+	cmap_entry = ((transp & 0xff00) << 16) | ((red & 0xff00) << 8) |
+		(green & 0xff00) | (blue >> 8);
 	writereg(par, CMAP + reg * 4, cmap_entry);
 
 	if (reg < 16 && par->pixfmt != DFA_PIX_8BIT) {
@@ -585,6 +611,7 @@ static int __devinit gxt4500_probe(struc
 	struct gxt4500_par *par;
 	struct fb_info *info;
 	struct fb_var_screeninfo var;
+	enum gxt_cards cardtype;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -613,7 +640,11 @@ static int __devinit gxt4500_probe(struc
 		goto err_free_fb;
 	}
 	par = info->par;
+	cardtype = ent->driver_data;
+	par->refclk_ps = cardinfo[cardtype].refclk_ps;
 	info->fix = gxt4500_fix;
+	strlcpy(info->fix.id, cardinfo[cardtype].cardname,
+		sizeof(info->fix.id));
 	info->pseudo_palette = par->pseudo_palette;
 
 	info->fix.mmio_start = reg_phys;
@@ -703,8 +734,10 @@ static void __devexit gxt4500_remove(str
 
 /* supported chipsets */
 static const struct pci_device_id gxt4500_pci_tbl[] = {
-	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT4500P),
+	  .driver_data = GXT4500P },
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_GXT6000P),
+	  .driver_data = GXT6000P },
 	{ 0 }
 };
 
@@ -735,7 +768,7 @@ static void __exit gxt4500_exit(void)
 module_exit(gxt4500_exit);
 
 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
-MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P");
+MODULE_DESCRIPTION("FBDev driver for IBM GXT4500P/6000P");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\"");

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
