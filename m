From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2]Freescale i.MX framebuffer driver
Date: Thu, 17 Mar 2005 18:42:12 +0100
Message-ID: <20050317174212.GA30323@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DBz0i-0000ut-4s
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 09:42:16 -0800
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DBz0h-0004Pl-0q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 09:42:16 -0800
Received: from sha by metis.extern.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1DBz0e-0007tu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 18:42:12 +0100
Content-Disposition: inline
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.11-imxfb-arch.patch"

--- linux-2.6.11/arch/arm/mach-imx/generic.c	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6.11-work/arch/arm/mach-imx/generic.c	2005-03-17 17:18:00.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <asm/arch/imxfb.h>
 #include <asm/hardware.h>
 
 #include <asm/mach/map.h>
@@ -228,6 +229,14 @@
 	.resource	= imx_uart2_resources,
 };
 
+static struct imxfb_mach_info imx_fb_info;
+
+void __init set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info)
+{
+	memcpy(&imx_fb_info,hard_imx_fb_info,sizeof(struct imxfb_mach_info));
+}
+EXPORT_SYMBOL(set_imx_fb_info);
+
 static struct resource imxfb_resources[] = {
 	[0] = {
 		.start	= 0x00205000,
@@ -241,9 +250,16 @@
 	},
 };
 
+static u64 fb_dma_mask = ~(u64)0;
+
 static struct platform_device imxfb_device = {
 	.name		= "imx-fb",
 	.id		= 0,
+	.dev		= {
+ 		.platform_data	= &imx_fb_info,
+		.dma_mask	= &fb_dma_mask,
+		.coherent_dma_mask = 0xffffffff,
+	},
 	.num_resources	= ARRAY_SIZE(imxfb_resources),
 	.resource	= imxfb_resources,
 };
--- linux-2.6.11/include/asm-arm/arch-imx/imxfb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-work/include/asm-arm/arch-imx/imxfb.h	2005-03-17 17:06:36.000000000 +0100
@@ -0,0 +1,35 @@
+/*
+ * This structure describes the machine which we are running on.
+ */
+struct imxfb_mach_info {
+	u_long		pixclock;
+
+	u_short		xres;
+	u_short		yres;
+
+	u_char		bpp;
+	u_char		hsync_len;
+	u_char		left_margin;
+	u_char		right_margin;
+
+	u_char		vsync_len;
+	u_char		upper_margin;
+	u_char		lower_margin;
+	u_char		sync;
+
+	u_int		cmap_greyscale:1,
+			cmap_inverse:1,
+			cmap_static:1,
+			unused:29;
+
+	u_int		pcr;
+	u_int		pwmr;
+	u_int		lscr1;
+	
+	u_char * fixed_screen_cpu;
+	dma_addr_t fixed_screen_dma;
+
+	void (*lcd_power)(int);
+	void (*backlight_power)(int);
+};
+void set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info);

--y0ulUmNC+osPPQO6--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
