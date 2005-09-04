From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH 2/2] ARM S3C2410 framebuffer driver
Date: Sun, 04 Sep 2005 12:18:03 +0200
Message-ID: <854q916sro.fsf@Orfeo.duckcorp.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBrZw-0001WJ-78
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 03:18:24 -0700
Received: from orfeo.duckcorp.org
	([62.4.21.229] helo=mx.duckcorp.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EBrZv-0002CO-JV
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 03:18:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 1F45E50008B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Sep 2005 12:18:21 +0200 (CEST)
Received: from mx.duckcorp.org ([127.0.0.1])
	by localhost (Orfeo [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10435-04 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 4 Sep 2005 12:18:14 +0200 (CEST)
Received: from Orfeo.duckcorp.org (localhost [127.0.0.1])
	by mx.duckcorp.org (Postfix) with ESMTP id 130A250009B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Sep 2005 12:18:04 +0200 (CEST)
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
To: linux-fbdev-devel@lists.sourceforge.net

--=-=-=




Signed-Off-By: Arnaud Patard <arnaud.patard@rtp-net.org>
  ---


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=s3c2410fb2.patch

diff --git a/arch/arm/mach-s3c2410/devs.c b/arch/arm/mach-s3c2410/devs.c
--- a/arch/arm/mach-s3c2410/devs.c
+++ b/arch/arm/mach-s3c2410/devs.c
@@ -29,7 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
-
+#include <asm/arch/fb.h>
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -103,6 +103,15 @@ struct platform_device s3c_device_lcd = 
 
 EXPORT_SYMBOL(s3c_device_lcd);
 
+static struct s3c2410fb_mach_info s3c2410fb_info;
+
+void __init set_s3c2410fb_info(struct s3c2410fb_mach_info *hard_s3c2410fb_info)
+{
+	memcpy(&s3c2410fb_info,hard_s3c2410fb_info,sizeof(struct s3c2410fb_mach_info));
+	s3c_device_lcd.dev.platform_data = &s3c2410fb_info;
+}
+EXPORT_SYMBOL(set_s3c2410fb_info);
+
 /* NAND Controller */
 
 static struct resource s3c_nand_resource[] = {
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -45,6 +45,9 @@
 
 //#include <asm/debug-ll.h>
 #include <asm/arch/regs-serial.h>
+#include <asm/arch/regs-lcd.h>
+
+#include <asm/arch/fb.h>
 
 #include <linux/serial_core.h>
 
@@ -88,6 +91,48 @@ static struct s3c2410_uartcfg h1940_uart
 
 
 
+/**
+ * Set lcd on or off
+ **/
+static struct s3c2410fb_mach_info h1940_lcdcfg __initdata = {
+	.fixed_syncs=		1,
+	.regs={ 
+		.lcdcon1=	S3C2410_LCDCON1_TFT16BPP | \
+				S3C2410_LCDCON1_TFT | \
+				S3C2410_LCDCON1_CLKVAL(0x0C),
+
+		.lcdcon2=	S3C2410_LCDCON2_VBPD(7) | \
+				S3C2410_LCDCON2_LINEVAL(319) | \
+				S3C2410_LCDCON2_VFPD(6) | \
+				S3C2410_LCDCON2_VSPW(0),
+
+		.lcdcon3=	S3C2410_LCDCON3_HBPD(19) | \
+				S3C2410_LCDCON3_HOZVAL(239) | \
+				S3C2410_LCDCON3_HFPD(7),
+
+		.lcdcon4=	S3C2410_LCDCON4_MVAL(0) | \
+				S3C2410_LCDCON4_HSPW(3),
+
+		.lcdcon5=	S3C2410_LCDCON5_FRM565 | \
+				S3C2410_LCDCON5_INVVLINE | \
+				S3C2410_LCDCON5_HWSWP,
+	},
+	.lpcsel=	0x02,
+	.gpccon=	0xaa940659,
+	.gpccon_mask=	0xffffffff,
+	.gpcup=		0x0000ffff,
+	.gpcup_mask=	0xffffffff,
+	.gpdcon=	0xaa84aaa0,
+	.gpdcon_mask=	0xffffffff,
+	.gpdup=		0x0000faff,
+	.gpdup_mask=	0xffffffff,
+
+	.width=		240,
+	.height=	320,
+	.xres=		{240,240,240},
+	.yres=		{320,320,320},
+	.bpp=		{16,16,16},
+};
 
 static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_usb,
@@ -116,6 +161,11 @@ void __init h1940_init_irq(void)
 
 }
 
+void __init h1940_init(void)
+{
+	set_s3c2410fb_info(&h1940_lcdcfg);
+}
+
 MACHINE_START(H1940, "IPAQ-H1940")
 	/* Maintainer: Ben Dooks <ben@fluff.org> */
 	.phys_ram	= S3C2410_SDRAM_PA,
@@ -124,5 +174,6 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.boot_params	= S3C2410_SDRAM_PA + 0x100,
 	.map_io		= h1940_map_io,
 	.init_irq	= h1940_init_irq,
+	.init_machine   = h1940_init,
 	.timer		= &s3c24xx_timer,
 MACHINE_END


--=-=-=--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
