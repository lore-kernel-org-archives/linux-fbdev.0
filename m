From: Vincent Sanders <vince@simtec.co.uk>
Subject: Silicon motion 501 driver
Date: Sun, 14 May 2006 23:37:42 +0100
Message-ID: <20060514223741.GB20765@kyllikki.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfPDz-0006gR-2z
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 May 2006 15:38:07 -0700
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48] helo=mtaout02-winn.ispmail.ntl.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FfPDy-0006K6-Ac
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 May 2006 15:38:07 -0700
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060514223757.LIGV29040.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sun, 14 May 2006 23:37:57 +0100
Received: from density.kyllikki.org ([81.103.92.60])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060514223754.VWSZ24467.aamtaout02-winn.ispmail.ntl.com@density.kyllikki.org>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Sun, 14 May 2006 23:37:54 +0100
Received: from gerald.kyllikki.org ([192.168.7.3])
	by density.kyllikki.org with esmtp (Exim 4.50)
	id 1FfPDa-0007A0-6J
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 May 2006 23:37:42 +0100
Received: from vince by gerald.kyllikki.org with local (Exim 4.50)
	id 1FfPDa-0007H8-4R
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 May 2006 23:37:42 +0100
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--ZwgA9U+XZDXt4+m+
Content-Type: multipart/mixed; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached you will find a first cut of a driver for the silicon motion
SM501 mobile multimedia companion chip.

The driver actually breaks down into a "base" driver for all the
available functions and a framebuffer driver for the video elements.

Although there is still several TODO in the framebuffer driver it does
work as is, in dual headed configuration, for both PCI and localbus
configurations.

Comments and patches gratefully received, I don't know how much more
complete a driver has to be for consideration for mainline merge but
that is the ultimate aim.

--=20
Regards Vincent


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sm501-driver.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.6.16-orig/drivers/base/Makefile linux-2.6.16-sm501/driver=
s/base/Makefile
--- linux-2.6.16-orig/drivers/base/Makefile	2006-03-20 05:53:29.000000000 +=
0000
+++ linux-2.6.16-sm501/drivers/base/Makefile	2006-04-11 12:51:08.000000000 =
+0100
@@ -10,6 +10,8 @@
 obj-$(CONFIG_MEMORY_HOTPLUG) +=3D memory.o
 obj-$(CONFIG_SMP)	+=3D topology.o
=20
+obj-m			+=3D sm501.o
+
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS +=3D -DDEBUG
 endif
diff -urN linux-2.6.16-orig/drivers/base/sm501.c linux-2.6.16-sm501/drivers=
/base/sm501.c
--- linux-2.6.16-orig/drivers/base/sm501.c	1970-01-01 01:00:00.000000000 +0=
100
+++ linux-2.6.16-sm501/drivers/base/sm501.c	2006-05-14 19:09:03.000000000 +=
0100
@@ -0,0 +1,843 @@
+/* linux/drivers/base/sm501.c
+ *
+ * Copyright (C) 2006 Simtec Electronics
+ *	Ben Dooks, Vincent Sanders
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * SM501 base driver
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+
+
+#include <linux/sm501.h>
+#include <linux/sm501-regs.h>
+
+#include <asm/io.h>
+
+#define SZ_8M (8*1024*1024)
+#define SZ_1M (1*1024*1024)
+#define SZ_256K (256*1024)
+
+struct sm501_devdata {
+	struct mutex			 clock_lock;
+	struct device			*dev;
+	struct resource			*io_res;
+	struct resource			*mem_res;
+
+	struct plat_serial8250_port	 uarts[3];
+	struct platform_device		 uart_dev;
+
+	struct platform_device		 usb_slave;
+	struct resource			 usb_slave_res[2];
+
+	struct platform_device		 usb_host;
+	struct resource			 usb_host_res[3];
+
+	struct platform_device		 ssp;
+	struct resource			 ssp_res[2];
+
+	struct platform_device		 fb;
+	struct resource			 fb_res[3];
+
+	unsigned int			 irq;
+	void __iomem			*regs;
+};
+
+
+static unsigned int misc_div[] =3D {
+	[0]		=3D 1,
+	[1]		=3D 2,
+	[2]		=3D 4,
+	[3]		=3D 8,
+	[4]		=3D 16,
+	[5]		=3D 32,
+	[6]		=3D 64,
+	[7]		=3D 128,
+	[8]		=3D 3,
+	[9]		=3D 6,
+	[10]		=3D 12,
+	[11]		=3D 24,
+	[12]		=3D 48,
+	[13]		=3D 96,
+	[14]		=3D 192,
+	[15]		=3D 384,
+};
+
+static unsigned int px_div[] =3D {
+	[0]		=3D 1,
+	[1]		=3D 2,
+	[2]		=3D 4,
+	[3]		=3D 8,
+	[4]		=3D 16,
+	[5]		=3D 32,
+	[6]		=3D 64,
+	[7]		=3D 128,
+	[8]		=3D 3,
+	[9]		=3D 6,
+	[10]	        =3D 12,
+	[11]		=3D 24,
+	[12]		=3D 48,
+	[13]		=3D 96,
+	[14]		=3D 192,
+	[15]		=3D 384,
+	[16]		=3D 5,
+	[17]		=3D 10,
+	[18]		=3D 20,
+	[19]		=3D 40,
+	[20]		=3D 80,
+	[21]		=3D 160,
+	[22]		=3D 320,
+	[23]		=3D 604,
+};
+
+#define decode_div(val, lshft, selbit, mask, dtab) \
+	((((val) & (selbit)) ? pll2 : 288 * MHZ) / dtab[(((val) >> (lshft)) & (ma=
sk))])
+
+#define MHZ (1000 * 1000)
+
+#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
+
+static void sm501_dump_clk(struct sm501_devdata *sm)
+{
+	unsigned long misct =3D readl(sm->regs + SM501_MISC_TIMING);
+	unsigned long pm0 =3D readl(sm->regs + SM501_POWER_MODE_0_CLOCK);
+	unsigned long pm1 =3D readl(sm->regs + SM501_POWER_MODE_1_CLOCK);
+	unsigned long pmc =3D readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long sdclk0, sdclk1;
+	unsigned long pll2;
+
+	switch (misct & 0x30) {
+	case 0x00:
+		pll2 =3D 336 * MHZ;
+		break;
+	case 0x10:
+		pll2 =3D 288 * MHZ;
+		break;
+	case 0x20:
+		pll2 =3D 240 * MHZ;
+		break;
+	case 0x30:
+		pll2 =3D 192 * MHZ;
+		break;
+	}
+
+	sdclk0 =3D (misct & (1<<12)) ? pll2 : 288 * MHZ;
+	sdclk0 /=3D misc_div[((misct >> 8) & 0xf)];
+
+	sdclk1 =3D (misct & (1<<20)) ? pll2 : 288 * MHZ;
+	sdclk1 /=3D misc_div[((misct >> 16) & 0xf)];
+
+	dev_info(sm->dev, "MISCT=3D%08lx, PM0=3D%08lx, PM1=3D%08lx\n",
+		 misct, pm0, pm1);
+
+	dev_info(sm->dev, "PLL2 =3D %ld.%ld MHz (%ld), SDCLK0 =3D %08lx, SDCLK1 =
=3D %08lx\n",
+		 fmt_freq(pll2), sdclk0, sdclk1);
+
+	dev_info(sm->dev, "SDRAM: PM0=3D%ld, PM1=3D%ld\n", sdclk0, sdclk1);
+
+	dev_info(sm->dev, "PM0[%c]: "
+		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		 (pmc & 3 ) =3D=3D 0 ? '*' : '-',
+		 fmt_freq(decode_div(pm0, 24, 1<<29, 31, px_div)),
+		 fmt_freq(decode_div(pm0, 16, 1<<20, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 8,  1<<12, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 0,  1<<4,  15, misc_div)));
+
+	dev_info(sm->dev, "PM1[%c]: "
+		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		 (pmc & 3 ) =3D=3D 1 ? '*' : '-',
+		 fmt_freq(decode_div(pm1, 24, 1<<29, 31, px_div)),
+		 fmt_freq(decode_div(pm1, 16, 1<<20, 15, misc_div)),
+		 fmt_freq(decode_div(pm1, 8,  1<<12, 15, misc_div)),
+		 fmt_freq(decode_div(pm1, 0,  1<<4,  15, misc_div)));
+}
+
+static int sm501_register_device(struct sm501_devdata *sm,
+				 struct platform_device *pdev)
+{
+	int id =3D 0;
+	int ret;
+
+	pdev->dev.parent =3D sm->dev;
+
+	for (id =3D 0; id < 255; id++) {
+		pdev->id =3D id;
+
+		ret =3D platform_device_register(pdev);
+		if (ret =3D=3D 0)
+			break;
+	}
+
+	dev_info(sm->dev, "%p(%d) - registration result %d\n", pdev, id, ret);
+
+	return ret;
+}
+
+/* sm501_misc_control
+ *
+ * alters the misceleneous control parameters
+ */
+int sm501_misc_control(struct device *dev, unsigned int func, unsigned int=
 to)
+{
+	struct sm501_devdata *sm =3D dev_get_drvdata(dev);
+	unsigned long misc =3D readl(sm->regs + SM501_MISC_CONTROL);
+
+	func =3D 1<<func;
+
+	if (to)
+	{
+		if(misc & func)
+			goto already;
+
+		misc |=3D func;
+	} else {
+		if(!(misc & func))
+			goto already;
+		misc &=3D ~func;
+	}
+
+	writel(misc, sm->regs + SM501_MISC_CONTROL);
+
+already:
+	dev_info(sm->dev, "MISC_CONTROL %08lx\n", misc);
+
+	return misc;
+}
+
+EXPORT_SYMBOL_GPL(sm501_misc_control);
+
+
+/* sm501_unit_power
+ *
+ * alters the power active gate to set specific units on or off
+ */
+
+int sm501_unit_power(struct device *dev, unsigned int unit, unsigned int t=
o)
+{
+	struct sm501_devdata *sm =3D dev_get_drvdata(dev);
+	unsigned long mode =3D readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate =3D readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock =3D readl(sm->regs + SM501_CURRENT_CLOCK);
+
+	mode &=3D 3;  // find current mode
+
+	if (to)
+	{
+		if(gate & (1 << unit))
+			return gate; /* already enabled */
+		gate |=3D (1 << unit);
+	} else {
+		if(!(gate & (1 << unit)))
+			return gate; /* already disabled */
+		gate &=3D ~(1 << unit);
+	}
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode =3D 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode =3D 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_info(sm->dev, "gate %08lx,clock %08lx, mode %08lx\n", gate, clock, mo=
de);
+
+	msleep(16);
+
+	return gate;
+}
+
+EXPORT_SYMBOL_GPL(sm501_unit_power);
+
+
+/* Perform a rounded division. */
+long sm501fb_round_div(long num, long denom)
+{
+        /* n / d + 1 / 2 =3D (2n + d) / 2d */
+        return (2 * num + denom) / (2 * denom);
+}
+
+/* clock value structure. */
+struct sm501_clock
+{
+	unsigned long mclk;
+	int divider;
+	int shift;
+};
+
+/* sm501fb_find_clock
+ *
+ * find nearest discrete clock frequency the SM501 can achive
+ *   the maximum divisor is either 3 or 5
+ */
+unsigned long sm501fb_find_clock(unsigned long freq,
+				 struct sm501_clock *clock,
+				 int max_div)
+{
+	unsigned long mclk;
+	int divider;
+	int shift;
+	long diff;
+	long best_diff =3D 999999999;
+
+	/* Try 288MHz and 336MHz clocks. */
+	for (mclk =3D 288000000; mclk <=3D 336000000; mclk +=3D 48000000)
+	{
+		/* try dividers 1 and 3 for CRT and for panel,
+		   try divider 5 for panel only.*/
+		for (divider =3D 1; divider <=3D max_div; divider +=3D 2)
+		{
+			/* try all 8 shift values.*/
+			for (shift =3D 0; shift < 8; shift++)
+			{
+				/* Calculate difference with requested clock. */
+				diff =3D sm501fb_round_div(mclk, divider << shift) - freq;
+				if (diff < 0)
+				{
+					diff =3D -diff;
+				}
+
+				/* If the difference is less than the current, use it. */
+				if (diff < best_diff)
+				{
+					/* Store best difference. */
+					best_diff =3D diff;
+
+					/* Store clock values. */
+					clock->mclk =3D mclk;
+					clock->divider =3D divider;
+					clock->shift =3D shift;
+				}
+			}
+		}
+	}
+
+	/* Return best clock. */
+	return clock->mclk / (clock->divider << clock->shift);
+}
+
+/* sm501_set_clock
+ *
+ * set one of the four clock sources to the closest available frequency to
+ *  the one specified
+ */
+
+int sm501_set_clock(struct device *dev,
+		    int clksrc,
+		    unsigned long req_freq)
+{
+	struct sm501_devdata *sm =3D dev_get_drvdata(dev);
+	unsigned long mode =3D readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate =3D readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock =3D readl(sm->regs + SM501_CURRENT_CLOCK);
+	unsigned char reg;
+	unsigned long sm501_freq; /* the actual frequency achived by the 501 */
+
+	struct sm501_clock to;
+
+	/* find achivable discrete frequency and setup register value
+	 * accordingly, V2XCLK, MCLK and M1XCLK are the same P2XCLK
+	 * has an extra bit for the divider */
+	switch (clksrc) {
+	case SM501_CLOCK_P2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by
+		 * 2. This clock also has an additional pre divisor */
+		sm501_freq =3D (sm501fb_find_clock(2 * req_freq, &to, 5) / 2);
+		reg=3Dto.shift & 0x07;/* bottom 3 bits are shift */
+		if(to.divider =3D=3D 3)
+			reg|=3D0x08; /* /3 divider required */
+		else if(to.divider =3D=3D 5)
+			reg|=3D0x10; /* /5 divider required */
+		if(to.mclk !=3D 288000000)
+			reg|=3D0x20; /* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_V2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by 2. */
+		sm501_freq =3D (sm501fb_find_clock(2 * req_freq, &to, 3) / 2);
+		reg=3Dto.shift & 0x07;/* bottom 3 bits are shift */
+		if(to.divider =3D=3D 3)
+			reg|=3D0x08; /* /3 divider required */
+		if(to.mclk !=3D 288000000)
+			reg|=3D0x10; /* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_MCLK:
+	case SM501_CLOCK_M1XCLK:
+		/* These clocks are the same and not futher divided */
+		sm501_freq =3D sm501fb_find_clock( req_freq, &to, 3);
+		reg=3Dto.shift & 0x07;/* bottom 3 bits are shift */
+		if(to.divider =3D=3D 3)
+			reg|=3D0x08; /* /3 divider required */
+		if(to.mclk !=3D 288000000)
+			reg|=3D0x10; /* which mclk pll is source */
+		break;
+
+	default:
+		return 0; /* this is bad, mkayyy */
+	}
+
+	clock =3D clock & ~(0xFF << clksrc);/* clear bits of the relvant clock */
+	clock |=3D reg<<clksrc;/* new frequency bitmask */
+
+	mode &=3D 3;  // find current mode
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode =3D 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode =3D 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_info(sm->dev, "gate %08lx,clock %08lx, mode %08lx\n", gate, clock, mo=
de);
+
+	msleep(16);
+	sm501_dump_clk(sm);
+
+	return sm501_freq;
+}
+
+EXPORT_SYMBOL_GPL(sm501_set_clock);
+
+static void sm501_null_release(struct device *dev)
+{
+}
+
+static int sm501_register_uarts(struct sm501_devdata *sm)
+{
+	int err;
+
+	sm->uart_dev.dev.platform_data =3D &sm->uarts;
+	sm->uart_dev.name =3D "serial8250";
+	sm->uart_dev.dev.release =3D sm501_null_release;
+
+	sm->uarts[0].membase  =3D sm->regs + SM501_UART0;
+	sm->uarts[0].mapbase  =3D sm->io_res->start + SM501_UART0;
+	sm->uarts[0].irq      =3D sm->irq;
+	sm->uarts[0].flags    =3D UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	sm->uarts[0].iotype   =3D UPIO_MEM;
+	sm->uarts[0].regshift =3D 2;
+	sm->uarts[0].uartclk  =3D 8*1000*1000;
+
+	sm->uarts[1].membase  =3D sm->regs + SM501_UART1;
+	sm->uarts[1].mapbase  =3D sm->io_res->start + SM501_UART1;
+	sm->uarts[1].irq      =3D sm->irq;
+	sm->uarts[1].flags    =3D UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	sm->uarts[1].iotype   =3D UPIO_MEM;
+	sm->uarts[1].regshift =3D 2;
+	sm->uarts[1].uartclk  =3D 8*1000*1000;
+
+	err =3D sm501_register_device(sm, &sm->uart_dev);
+	if (err) {
+		dev_err(sm->dev, "failed to register serial devices\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void sm501_create_subio(struct sm501_devdata *sm,
+			       struct resource *res,
+			       unsigned long offs,
+			       unsigned long size)
+{
+	res->flags =3D IORESOURCE_MEM;
+	res->parent =3D sm->io_res;
+	res->start =3D sm->io_res->start + offs;
+	res->end =3D res->start + size - 1;
+}
+
+static void sm501_create_mem(struct sm501_devdata *sm,
+			     struct resource *res,
+			     unsigned long offs,
+			     unsigned long size)
+{
+	res->flags =3D IORESOURCE_MEM;
+	res->parent =3D sm->mem_res;
+	res->start =3D sm->mem_res->start + offs;
+	res->end =3D res->start + size - 1;
+}
+
+static int sm501_register_usbhost(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	int err;
+
+	*mem_avail =3D *mem_avail - SZ_256K; /* size of this resource */
+
+	sm->usb_host.name =3D "sm501-usb";
+	sm->usb_host.dev.release =3D sm501_null_release;
+
+	sm->usb_host.resource =3D sm->usb_host_res;
+	sm->usb_host.num_resources =3D ARRAY_SIZE(sm->usb_host_res);
+
+	sm501_create_subio(sm, &sm->usb_host_res[0], 0x40000, 0x20000);
+	sm501_create_mem(sm, &sm->usb_host_res[1], *mem_avail , SZ_256K);
+
+	err =3D sm501_register_device(sm, &sm->usb_host);
+	if (err) {
+		dev_err(sm->dev, "failed to register usb host\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int sm501_register_display(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	int err;
+	unsigned long len_avail =3D *mem_avail;
+
+	*mem_avail =3D 0; /* consumes all available memory remaining */
+
+	sm->fb.name =3D "sm501-fb";
+	sm->fb.dev.release =3D sm501_null_release;
+
+	sm->fb.resource =3D sm->fb_res;
+	sm->fb.num_resources =3D ARRAY_SIZE(sm->fb_res);
+
+	sm501_create_subio(sm, &sm->fb_res[0], 0x80000, 0x10000);
+	sm501_create_subio(sm, &sm->fb_res[1], 0x100000, 0x50000);
+	sm501_create_mem(sm, &sm->fb_res[2], *mem_avail, len_avail);
+
+	err =3D sm501_register_device(sm, &sm->fb);
+	if (err) {
+		dev_err(sm->dev, "failed to register display\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int sm501_init_dev(struct sm501_devdata *sm)
+{
+	unsigned long sdramclk;
+	unsigned long mem_avail=3DSZ_8M;
+
+	dev_info(sm->dev, "SM501 At %p,%p: Version %08x, IRQ %d\n",
+		 NULL, sm->regs,
+		 readl(sm->regs + SM501_DEVICEID), sm->irq);
+
+	dev_info(sm->dev, "CurrentGate      %08x\n", readl(sm->regs+0x38));
+	dev_info(sm->dev, "CurrentClock     %08x\n", readl(sm->regs+0x3c));
+	dev_info(sm->dev, "PowerModeControl %08x\n", readl(sm->regs+0x54));
+
+	sm501_dump_clk(sm);
+
+	/* set external sdram clocking */
+	sdramclk =3D readl(sm->regs + SM501_MISC_TIMING);
+
+	sdramclk &=3D ~0x1F1F00;
+
+	sdramclk |=3D 0x010100;
+
+	writel(sdramclk, sm->regs + SM501_MISC_TIMING);
+
+	printk("External SDRAM clock %08lx\n",sdramclk);
+
+	sm501_set_clock(sm->dev,SM501_CLOCK_M1XCLK,160 * MHZ);
+
+	sm501_set_clock(sm->dev,SM501_CLOCK_MCLK,100 * MHZ);
+
+	/* enable 24bpp */
+	sm501_misc_control(sm->dev, SM501_MISC_PNL_24BIT , 1);
+	/* set gpio to 24bpp */
+	sdramclk =3D readl(sm->regs + SM501_GPIO63_32_CONTROL);
+	sdramclk|=3D0x3F000000;
+	writel(sdramclk, sm->regs + SM501_GPIO63_32_CONTROL);
+	printk("GPIO 63-32: %08lx\n",sdramclk);
+
+
+	/* ok, it worked, advertise our devices */
+
+#define register_uarts 0
+	if (register_uarts) {
+		sm501_unit_power(sm->dev, SM501_GATE_UART0, 1);
+		sm501_unit_power(sm->dev, SM501_GATE_UART1, 1);
+
+		sm501_register_uarts(sm);
+	}
+
+	sm501_register_usbhost(sm, &mem_avail);
+	sm501_register_display(sm, &mem_avail);
+
+	return 0;
+}
+
+static ssize_t sm501_dbg_regs(struct device *dev, struct device_attribute =
*attr, char *buff)
+{
+	struct sm501_devdata *sm =3D dev_get_drvdata(dev)	;
+	unsigned int reg;
+	char *ptr =3D buff;
+	int ret;
+
+	for (reg =3D 0x00; reg < 0x70; reg +=3D 4) {
+		ret =3D sprintf(ptr, "%08x =3D %08x\n", reg, readl(sm->regs + reg));
+		ptr +=3D ret;
+	}
+
+	return ptr - buff;
+}
+
+
+static DEVICE_ATTR(dbg_regs, 0666, sm501_dbg_regs, NULL);
+
+static int sm501_plat_probe(struct platform_device *dev)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	printk(KERN_INFO "SM501: PCI device found\n");
+
+	sm =3D kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm =3D=3D NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err =3D -ENOMEM;
+		goto err1;
+	}
+
+	sm->dev =3D &dev->dev;
+	sm->irq =3D platform_get_irq(dev, 0);
+	sm->io_res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
+	sm->mem_res =3D platform_get_resource(dev, IORESOURCE_MEM, 1);
+
+	if (sm->irq < 0) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err =3D sm->irq;
+		goto err_res;
+	}
+
+	if (sm->io_res =3D=3D NULL || sm->mem_res =3D=3D NULL) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err =3D -ENOENT;
+		goto err_res;
+	}
+
+	device_create_file(sm->dev, &dev_attr_dbg_regs);
+
+	platform_set_drvdata(dev, sm);
+
+	sm->regs =3D ioremap(sm->io_res->start,
+			   (sm->io_res->end - sm->io_res->start) - 1);
+
+	if (sm->regs =3D=3D NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err =3D -EIO;
+		goto err_remap;
+	}
+
+	sm501_init_dev(sm);
+	return 0;
+
+ err_remap:
+ err_res:
+	kfree(sm);
+ err1:
+	return err;
+
+}
+
+static int sm501_pci_probe(struct pci_dev *dev,
+			   const struct pci_device_id *id)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	printk(KERN_INFO "SM501: PCI device found\n");
+
+	sm =3D kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm =3D=3D NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err =3D -ENOMEM;
+		goto err1;
+	}
+
+	sm->dev =3D &dev->dev;
+	sm->irq =3D dev->irq;
+
+	pci_set_drvdata(dev, sm);
+
+	err =3D pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "cannot enable device\n");
+		goto err2;
+	}
+	/* check our resources */
+
+	if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #0 is not memory?\n");
+		err =3D -EINVAL;
+		goto err3;
+	}
+
+	if (!(pci_resource_flags(dev, 1) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #1 is not memory?\n");
+		err =3D -EINVAL;
+		goto err3;
+	}
+	/* reserve our io regions */
+
+#if 0
+	err =3D pci_request_regions(dev, "sm501");
+	if (err) {
+		dev_err(&dev->dev, "cannot get regions\n");
+		goto err3;
+	}
+#endif
+
+	/* pci_set_master(dev) */
+
+	sm->io_res =3D &dev->resource[1];
+	sm->mem_res =3D &dev->resource[0];
+
+	sm->regs =3D ioremap(pci_resource_start(dev, 1),
+			   pci_resource_len(dev, 1));
+
+	if (sm->regs =3D=3D NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err =3D -EIO;
+		goto err4;
+	}
+
+	device_create_file(sm->dev, &dev_attr_dbg_regs);
+	sm501_init_dev(sm);
+	return 0;
+
+ err4:
+	if (0)
+		pci_release_regions(dev);
+ err3:
+	pci_disable_device(dev);
+ err2:
+	pci_set_drvdata(dev, NULL);
+	kfree(sm);
+ err1:
+	return err;
+}
+
+static void sm501_dev_remove(struct sm501_devdata *sm)
+{
+	//platform_device_unregister(&sm->uart_dev);
+	platform_device_unregister(&sm->usb_host);
+	platform_device_unregister(&sm->fb);
+	device_remove_file(sm->dev, &dev_attr_dbg_regs);
+}
+
+static void sm501_pci_remove(struct pci_dev *dev)
+{
+	struct sm501_devdata *sm =3D pci_get_drvdata(dev);
+
+	printk(KERN_INFO "SM501: PCI device removal\n");
+
+	/* remove our registered devices */
+
+	sm501_dev_remove(sm);
+
+	/* remove the resources */
+
+	iounmap(sm->regs);
+
+	if (0)
+		pci_release_regions(dev);
+
+	pci_set_drvdata(dev, NULL);
+	pci_disable_device(dev);
+}
+
+static int sm501_plat_remove(struct platform_device *dev)
+{
+	struct sm501_devdata *sm =3D platform_get_drvdata(dev);
+
+	printk(KERN_INFO "SM501: Platform device removal\n");
+
+	/* remove our registered devices */
+
+	sm501_dev_remove(sm);
+
+	/* remove the resources */
+
+	iounmap(sm->regs);
+	return 0;
+}
+
+static struct pci_device_id sm501_pci_tbl[] =3D {
+	{ 0x126f, 0x0501, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, sm501_pci_tbl);
+
+static struct pci_driver sm501_pci_drv =3D {
+	.name		=3D "sm501",
+	.id_table	=3D sm501_pci_tbl,
+	.probe		=3D sm501_pci_probe,
+	.remove		=3D sm501_pci_remove,
+};
+
+static struct platform_driver sm501_plat_drv =3D {
+	.driver		=3D {
+		.name	=3D "sm501",
+		.owner	=3D THIS_MODULE,
+	},
+	.probe		=3D sm501_plat_probe,
+	.remove		=3D sm501_plat_remove,
+};
+
+static int __init sm501_base_init(void)
+{
+	platform_driver_register(&sm501_plat_drv);
+	return pci_module_init(&sm501_pci_drv);
+}
+
+static void __exit sm501_base_exit(void)
+{
+	platform_driver_unregister(&sm501_plat_drv);
+	pci_unregister_driver(&sm501_pci_drv);
+}
+
+module_init(sm501_base_init);
+module_exit(sm501_base_exit);
+
+MODULE_DESCRIPTION("SM501 Core Driver");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Vincent Sanders");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.16-orig/drivers/Makefile linux-2.6.16-sm501/drivers/Mak=
efile
--- linux-2.6.16-orig/drivers/Makefile	2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16-sm501/drivers/Makefile	2006-04-11 19:10:31.000000000 +0100
@@ -31,6 +31,7 @@
 obj-y				+=3D serial/
 obj-$(CONFIG_PARPORT)		+=3D parport/
 obj-y				+=3D base/ block/ misc/ mfd/ net/ media/
+obj-m				+=3D base/
 obj-$(CONFIG_NUBUS)		+=3D nubus/
 obj-$(CONFIG_ATM)		+=3D atm/
 obj-$(CONFIG_PPC_PMAC)		+=3D macintosh/
diff -urN linux-2.6.16-orig/drivers/video/Kconfig linux-2.6.16-sm501/driver=
s/video/Kconfig
--- linux-2.6.16-orig/drivers/video/Kconfig	2006-03-20 05:53:29.000000000 +=
0000
+++ linux-2.6.16-sm501/drivers/video/Kconfig	2006-04-20 15:43:27.000000000 =
+0100
@@ -1426,6 +1426,13 @@
 	  Turn on debugging messages. Note that you can set/unset at run time
 	  through sysfs
=20
+config FB_SM501
+	tristate "Silicon Motion SM501"
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT=09
+
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
diff -urN linux-2.6.16-orig/drivers/video/Makefile linux-2.6.16-sm501/drive=
rs/video/Makefile
--- linux-2.6.16-orig/drivers/video/Makefile	2006-03-20 05:53:29.000000000 =
+0000
+++ linux-2.6.16-sm501/drivers/video/Makefile	2006-04-20 15:28:55.000000000=
 +0100
@@ -94,6 +94,7 @@
 obj-$(CONFIG_FB_S1D13XXX)	  +=3D s1d13xxxfb.o
 obj-$(CONFIG_FB_IMX)              +=3D imxfb.o
 obj-$(CONFIG_FB_S3C2410)	  +=3D s3c2410fb.o
+obj-$(CONFIG_FB_SM501)		  +=3D sm501-fb.o
=20
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             +=3D vesafb.o
diff -urN linux-2.6.16-orig/drivers/video/sm501-fb.c linux-2.6.16-sm501/dri=
vers/video/sm501-fb.c
--- linux-2.6.16-orig/drivers/video/sm501-fb.c	1970-01-01 01:00:00.00000000=
0 +0100
+++ linux-2.6.16-sm501/drivers/video/sm501-fb.c	2006-05-14 23:06:23.0000000=
00 +0100
@@ -0,0 +1,1505 @@
+/* linux/drivers/video/sm501-fb.c
+ *
+ * Copyright (c) 2006 Simtec Electronics
+ *	Vincent Sanders <vince@simtec.co.uk>
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Frambuffer driver for the Silicon Motion 501
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/div64.h>
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+#endif
+
+#include <linux/sm501.h>
+#include <linux/sm501-regs.h>
+
+#define NR_PALETTE 256
+
+#define HEAD_CRT	(0)
+#define HEAD_PANNEL	(1)
+
+static unsigned int debug;
+#define dprintk(msg...)	if (debug) { printk(KERN_DEBUG "sm501-fb: " msg); }
+
+/* SM501 memory adress */
+struct sm501_mem {
+	unsigned long	 sm_addr;
+	void __iomem	*k_addr;
+};
+
+/* private data that is shared between all frambuffers* */
+struct sm501fb_info {
+	struct device		*dev;
+	struct fb_info		*fb[2];		/* fb info for both heads */
+	struct resource		*fbmem_res;	/* framebuffer resource */
+	struct resource		*regs_res;	/* registers resource */
+
+	int			 irq;
+	void __iomem		*regs;		/* remapped registers */
+	void __iomem		*fbmem;		/* remapped framebuffer */
+	size_t			 fbmem_len;	/* length of remapped region */
+};
+
+/* per-framebuffer private data */
+struct sm501fb_par {
+	u32			 pseudo_palette[16];
+
+	struct sm501_mem	 cursor;
+	struct sm501_mem	 screen;
+
+	void __iomem		*cursor_regs;
+	struct sm501fb_info	*info;
+};
+
+/* sm501_alloc_mem
+ *
+ * This is an attempt to lay out memory for the two framebuffers and
+ * everything else
+ *
+ * |fbmem_res->start	                                       fbmem_res->end|
+ * |                                                                      =
   |
+ * |fb[0].fix.smem_start    |         |fb[1].fix.smem_start    |     2K   =
   |
+ * |-> fb[0].fix.smem_len <-| spare   |-> fb[1].fix.smem_len <-|-> cursors=
 <-|
+ *
+ * The "spare" space is for the 2d engine data
+ * the fixed is space for the cursors (2x1Kbyte)
+ *
+ * we need to allocate memory for the 2D acceleration engine
+ * command list and the data for the engine to deal with.
+ *
+ * - all allocations must be 128bit aligned
+ * - cursors are 64x64x2 bits (1Kbyte)
+ *
+ */
+
+#define SM501_MEMF_CURSOR		(1)
+#define SM501_MEMF_PANNEL		(2)
+#define SM501_MEMF_CRT			(4)
+#define SM501_MEMF_ACCEL		(8)
+
+int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
+		    unsigned int why, size_t size)
+{
+	unsigned int ptr =3D 0;
+
+	switch (why) {
+	case SM501_MEMF_CURSOR:
+		ptr =3D inf->fbmem_len - size;
+		inf->fbmem_len =3D ptr;
+		break;
+
+	case SM501_MEMF_PANNEL:
+		ptr =3D inf->fbmem_len - size;
+		if (ptr < inf->fb[0]->fix.smem_len)
+			return -ENOMEM;
+
+		break;
+
+	case SM501_MEMF_CRT:
+		ptr =3D 0;
+		break;
+
+	case SM501_MEMF_ACCEL:
+		ptr =3D inf->fb[0]->fix.smem_len;
+
+		if ((ptr + size) >
+		    (inf->fb[1]->fix.smem_start - inf->fbmem_res->start))
+			return -ENOMEM;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	mem->sm_addr =3D ptr;
+	mem->k_addr  =3D inf->fbmem + ptr;
+
+	printk("%s: result %08lx, %p - %u, %zd\n", __FUNCTION__,
+	       mem->sm_addr, mem->k_addr, why, size);
+
+	return 0;
+}
+
+/* sm501fb_ps_to_hz
+ *
+ * Converts a period in picoseconds to Hz
+ */
+static unsigned long sm501fb_ps_to_hz(unsigned long psvalue)
+{
+	unsigned long long numerator=3D1000000000000ULL;
+
+	/* 10^12 / picosecond period gives frequency in Hz */
+	do_div(numerator, psvalue);
+	return (unsigned long)numerator;
+}
+
+/* sm501fb_setup_gamma
+ *
+ * Programs a linear 1.0 gamma ramp
+ */
+static void sm501fb_setup_gamma(struct sm501fb_info *fbi,
+				unsigned long palette)
+{
+	unsigned long value=3D0;
+	int offset;
+
+	/* set gamma values */
+	for(offset=3D0;offset < 256 * 4; offset +=3D 4) {
+		writel(value, fbi->regs + palette + offset);
+		/* Advance RGB by 1,1,1.*/
+		value +=3D 0x010101;
+	}
+}
+
+/*
+ * sm501fb_check_var_crt():
+ *
+ * Checks the parameters in var can be achived on the CRT, If a
+ *   value doesn't fit, round it up, if it's too big, return -EINVAL.
+ */
+static int sm501fb_check_var_crt(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
+{
+
+	dprintk("check_var(var=3D%p, info=3D%p)\n", var, info);
+
+	/* TODO - limit CRT DAC bandwidth to 200MHz
+	 *	- limit memory usage across both screens
+	 * 	- limit memory bandwidth between both screens
+	 */
+
+	var->xres_virtual=3Dvar->xres;
+	var->yres_virtual=3Dvar->yres;
+
+	/* can cope with 8,16 or 32bpp */
+	if (var->bits_per_pixel <=3D 8)
+		var->bits_per_pixel =3D 8;
+	else if (var->bits_per_pixel <=3D 16)
+		var->bits_per_pixel =3D 16;
+	else
+		var->bits_per_pixel =3D 32;
+
+	/* set r/g/b positions and validate bpp */
+	switch(var->bits_per_pixel) {
+	case 8:
+		var->red.length		=3D var->bits_per_pixel;
+		var->red.offset		=3D 0;
+		var->green.length	=3D var->bits_per_pixel;
+		var->green.offset	=3D 0;
+		var->blue.length	=3D var->bits_per_pixel;
+		var->blue.offset	=3D 0;
+		var->transp.length	=3D 0;
+
+		break;
+
+	case 16:
+		var->red.offset		=3D 11;
+		var->green.offset	=3D 5;
+		var->blue.offset	=3D 0;
+		var->red.length		=3D 5;
+		var->green.length	=3D 6;
+		var->blue.length	=3D 5;
+		var->transp.length	=3D 0;
+
+		break;
+
+	case 32:
+		var->transp.offset	=3D 0;
+		var->transp.length	=3D 0;
+		var->red.offset		=3D 16;
+		var->red.length		=3D 8;
+		var->green.offset	=3D 8;
+		var->green.length	=3D 8;
+		var->blue.offset	=3D 0;
+		var->blue.length	=3D 8;
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* hard limits of device */
+	if((var->xres + var->left_margin + var->right_margin + var->hsync_len) > =
4096)
+		return -EINVAL;
+
+	if((var->yres + var->upper_margin + var->lower_margin + var->vsync_len) >=
 2048)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * sm501fb_check_var_pnl():
+ *
+ * Checks the parameters in var can be achived on the panel, If a
+ *   value doesn't fit, round it up, if it's too big, return -EINVAL.
+ */
+static int sm501fb_check_var_pnl(struct fb_var_screeninfo *var,
+				 struct fb_info *info)
+{
+	dprintk("check_var(var=3D%p, info=3D%p)\n", var, info);
+
+	/* TODO - limit to DAC bandwidth
+	 *	- limit memory usage across both screens
+	 * 	- limit memory bandwidth between both screens
+	 *	- limit panel to platform data specified parameters
+	 */
+
+	var->xres_virtual=3Dvar->xres;
+	var->yres_virtual=3Dvar->yres;
+
+	/* can cope with 8,16 or 32bpp */
+	if (var->bits_per_pixel <=3D 8)
+		var->bits_per_pixel =3D 8;
+	else if (var->bits_per_pixel <=3D 16)
+		var->bits_per_pixel =3D 16;
+	else
+		var->bits_per_pixel =3D 32;
+
+	/* set r/g/b positions and validate bpp */
+	switch(var->bits_per_pixel) {
+	case 8:
+		var->red.length		=3D var->bits_per_pixel;
+		var->red.offset		=3D 0;
+		var->green.length	=3D var->bits_per_pixel;
+		var->green.offset	=3D 0;
+		var->blue.length	=3D var->bits_per_pixel;
+		var->blue.offset	=3D 0;
+		var->transp.length	=3D 0;
+		break;
+
+	case 16:
+		var->red.offset		=3D 11;
+		var->green.offset	=3D 5;
+		var->blue.offset	=3D 0;
+		var->red.length		=3D 5;
+		var->green.length	=3D 6;
+		var->blue.length	=3D 5;
+		var->transp.length	=3D 0;
+		break;
+
+	case 32:
+		var->transp.offset   =3D 0;
+		var->transp.length   =3D 0;
+		var->red.offset      =3D 16;
+		var->red.length      =3D 8;
+		var->green.offset    =3D 8;
+		var->green.length    =3D 8;
+		var->blue.offset     =3D 0;
+		var->blue.length     =3D 8;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	/* hard limits of device */
+	if((var->xres + var->left_margin + var->right_margin + var->hsync_len) > =
4096)
+		return -EINVAL;
+
+	if((var->yres + var->upper_margin + var->lower_margin + var->vsync_len) >=
 2048)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * sm501fb_set_par_crt
+ * @info: frame buffer structure that represents the CRT framebuffer
+ *
+ * Sets the CRT video mode as per the data in the fb_info structure
+ */
+static int sm501fb_set_par_crt(struct fb_info *info)
+{
+	struct sm501fb_par  *par =3D info->par;
+	struct sm501fb_info *fbi =3D par->info;
+	struct fb_var_screeninfo *var =3D &info->var;
+	unsigned long pixclock;      /* pixelclock in Hz */
+	unsigned long sm501pixclock; /* pixelclock the 501 can achive in Hz */
+	unsigned long control;       /* control register */
+
+	/* activate new configuration */
+
+	dprintk("%s: var->xres  =3D %d\n", __FUNCTION__, var->xres);
+	dprintk("%s: var->yres  =3D %d\n", __FUNCTION__, var->yres);
+	dprintk("%s: var->bpp   =3D %d\n", __FUNCTION__, var->bits_per_pixel);
+
+	switch(var->bits_per_pixel) {
+	case 8:
+		info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+		break;
+
+	case 16:
+		info->fix.visual =3D FB_VISUAL_DIRECTCOLOR;
+		break;
+
+	case 32:
+		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
+	dprintk("%s: virtual %d,%d\n",
+		__FUNCTION__,
+		var->xres_virtual,
+		var->yres_virtual);
+
+	/* allocate fb memory within 501 */
+	info->fix.line_length     =3D (var->xres * var->bits_per_pixel)/8;
+	info->fix.smem_len	  =3D info->fix.line_length * var->yres;
+
+	dprintk("%s: line length  =3D %lu\n", __FUNCTION__,
+		(unsigned long)info->fix.line_length);
+
+	if (sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_CRT,
+			    info->fix.smem_len)) {
+		dev_err(fbi->dev, "no memory for crt\n");
+		return -ENOMEM;
+	}
+
+	info->fix.smem_start =3D fbi->fbmem_res->start + par->screen.sm_addr;
+
+	/* ensure virtual adressess are set */
+	info->screen_base =3D fbi->fbmem + par->screen.sm_addr;
+	info->screen_size =3D info->fix.smem_len;
+
+	/* calculate pixel clock in Hz from the ps value*/
+	pixclock =3D sm501fb_ps_to_hz(var->pixclock);
+
+	/* program CRT clcok  */
+	sm501pixclock =3D sm501_set_clock(fbi->dev->parent,
+					SM501_CLOCK_V2XCLK,
+					pixclock);
+
+	/* update fb layer with actual clock used */
+	var->pixclock =3D sm501fb_ps_to_hz(sm501pixclock);
+
+	dprintk("%s: pixclock(ps) =3D %u, pixclock(Hz)  =3D %lu, "
+	       "sm501pixclock =3D %lu,  error =3D %ld%%\n",
+	       __FUNCTION__, var->pixclock, pixclock, sm501pixclock,
+	       ((pixclock - sm501pixclock)*100)/pixclock);
+
+	/* enable CRT DAC - note 0 is on!*/
+	sm501_misc_control(fbi->dev->parent, SM501_MISC_DAC_POWER, 0);
+
+	/* set frame buffer base */
+	dprintk("%s: framebuffer base  =3D 0x%lx\n", __FUNCTION__,
+	       (1<<31) | par->screen.sm_addr);
+
+	writel(1<<31 | par->screen.sm_addr , fbi->regs + SM501_DC_CRT_FB_ADDR);
+
+	/* program framebuffer width and offset */
+	dprintk("%s: framebuffer width & offset  =3D 0x%08lx\n", __FUNCTION__,
+	       (unsigned long)(info->fix.line_length & 0x3FF0) | ((info->fix.line=
_length & 0x3FF0) << 16));
+
+	writel((info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF=
0) << 16),
+	       fbi->regs + SM501_DC_CRT_FB_OFFSET);
+
+	/* program horizontal total */
+	dprintk("%s: framebuffer htotal =3D 0x%x, xres =3D %d, left =3D %d, "
+	       "right =3D %d, hsync =3D %d\n", __FUNCTION__,
+	       (((var->xres + var->left_margin + var->right_margin + var->hsync_l=
en - 1) & 0xFFF) << 16) | ((var->xres - 1) & 0xFFF),
+	       var->xres,  var->left_margin, var->right_margin, var->hsync_len);
+
+	writel((((var->xres + var->left_margin + var->right_margin + var->hsync_l=
en - 1) & 0xFFF) << 16) |
+	       ((var->xres - 1) & 0xFFF),
+	       fbi->regs + SM501_DC_CRT_H_TOT);
+
+	/* program horizontal sync */
+	dprintk("%s: framebuffer hsync  =3D 0x%x\n",
+		__FUNCTION__,
+		((var->hsync_len & 0xFF) << 16 ) | ((var->xres + var->right_margin - 1) =
& 0x7FF));
+
+	writel(((var->hsync_len & 0xFF) << 16 ) |
+	       ((var->xres + var->right_margin - 1) & 0x7FF),
+	       fbi->regs + SM501_DC_CRT_H_SYNC);
+
+	/* program vertical total */
+	dprintk("%s: framebuffer vtotal =3D 0x%x, yres =3D %d,"
+		" upper =3D %d, lower =3D %d, vsync =3D %d\n",
+		__FUNCTION__,
+		(((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - =
1) & 0x7FF) << 16) | ((var->yres - 1) & 0x7FF),
+		var->yres,
+		var->upper_margin,
+		var->lower_margin,
+		var->vsync_len);
+
+	writel((((var->upper_margin + var->yres + var->lower_margin + var->vsync_=
len - 1) & 0x7FF) << 16) |
+	       ((var->yres - 1) & 0x7FF),
+	       fbi->regs + SM501_DC_CRT_V_TOT);
+
+	/* program vertical sync */
+	dprintk("%s: framebuffer vsync  =3D 0x%x\n",
+		__FUNCTION__,
+		((var->vsync_len & 0x3F) << 16) | (((var->yres + var->lower_margin - 1) =
& 0x7FF)));
+
+	writel(((var->vsync_len & 0x3F) << 16) |
+	       (((var->yres + var->lower_margin - 1) & 0x7FF)),
+	       fbi->regs + SM501_DC_CRT_V_SYNC);
+
+	/* program control register */
+	control=3Dreadl(fbi->regs + SM501_DC_CRT_CONTROL) & 0xCCF8;
+
+	switch(var->bits_per_pixel) {
+	case 8:
+		control |=3D 0;
+		break;
+
+	case 16:
+		control |=3D 1;
+		break;
+
+	case 32:
+		control |=3D 2;
+
+		sm501fb_setup_gamma(fbi,SM501_DC_CRT_PALETTE);
+		break;
+
+	default:
+		break; /* uh oh */
+	}
+
+	control |=3D 1<<9;	/* CRT displays CRT data */
+	control |=3D 1<<8;	/* enable CRT timing */
+	control |=3D 1<<2;	/* enable CRT graphics plane */
+
+	/* H sync polarity */
+	if((var->sync & FB_SYNC_HOR_HIGH_ACT) =3D=3D 0)
+		control |=3D 1<<12;
+
+	/* V sync polarity */
+	if((var->sync & FB_SYNC_VERT_HIGH_ACT) =3D=3D 0)
+		control |=3D 1<<13;
+
+	writel(control, fbi->regs + SM501_DC_CRT_CONTROL);
+
+	/* TODO - set DPMS */
+
+	return 0;
+}
+
+/*
+ * sm501fb_set_par_pnl
+ * @info: frame buffer structure that represents the panel framebuffer
+ *
+ * Sets the panel video mode with the data in the fb_info structure
+ */
+static int sm501fb_set_par_pnl(struct fb_info *info)
+{
+	struct sm501fb_par  *par =3D info->par;
+	struct sm501fb_info *fbi =3D par->info;
+	struct fb_var_screeninfo *var =3D &info->var;
+	unsigned long pixclock;
+	unsigned long sm501pixclock;
+	unsigned long control;
+
+	/* activate this new configuration */
+	dprintk("%s: var->xres  =3D %u\n", __FUNCTION__, var->xres);
+	dprintk("%s: var->yres  =3D %u\n", __FUNCTION__, var->yres);
+	dprintk("%s: var->bpp   =3D %u\n", __FUNCTION__, var->bits_per_pixel);
+
+	switch(var->bits_per_pixel) {
+	case 8:
+		info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+		break;
+
+	case 16:
+		info->fix.visual =3D FB_VISUAL_DIRECTCOLOR;
+		break;
+
+	case 32:
+		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
+	dprintk("%s: virtual %d,%d\n",
+	       __FUNCTION__,
+	       var->xres_virtual,
+	       var->yres_virtual);
+
+	info->fix.line_length =3D (var->xres * var->bits_per_pixel)/8;
+	info->fix.smem_len    =3D info->fix.line_length * var->yres;
+
+	dprintk("%s: line length  =3D %lu\n", __FUNCTION__,
+		(unsigned long)info->fix.line_length);
+
+	if (sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_PANNEL,
+			    info->fix.smem_len)) {
+		dev_err(fbi->dev, "no memory for panel\n");
+		return -ENOMEM;
+	}
+
+	info->fix.smem_start =3D fbi->fbmem_res->start + par->screen.sm_addr;
+
+	/* ensure virtual adressess are set */
+	info->screen_base =3D fbi->fbmem + par->screen.sm_addr;
+	info->screen_size =3D info->fix.smem_len;
+
+	/* calculate pixel clock in Hz from the ps value*/
+	pixclock =3D sm501fb_ps_to_hz(var->pixclock);
+
+	/* program clock  */
+	sm501pixclock =3D sm501_set_clock(fbi->dev->parent,
+					SM501_CLOCK_P2XCLK,
+					pixclock);
+
+	dprintk("%s: pixclock(ps) =3D %u, pixclock(Hz)  =3D %lu, "
+	       "sm501pixclock =3D %lu,  error =3D %ld%%\n",
+	       __FUNCTION__, var->pixclock, pixclock, sm501pixclock,
+	       (((pixclock - sm501pixclock)*100)/pixclock));
+
+	/* update fb layer with actual clock used */
+	var->pixclock =3D sm501fb_ps_to_hz(sm501pixclock);
+
+	/* set frame buffer base */
+	dprintk("%s: framebuffer base  =3D 0x%lx\n",
+	       __FUNCTION__, (1<<31) | par->screen.sm_addr);
+
+	writel((1<<31) | par->screen.sm_addr,
+	       fbi->regs + SM501_DC_PANEL_FB_ADDR);
+
+	/* program framebuffer width and offset */
+	dprintk("%s: framebuffer window width & offset  =3D 0x%08lx\n",
+		__FUNCTION__,
+		(unsigned long)(info->fix.line_length & 0x3FF0) | ((info->fix.line_lengt=
h & 0x3FF0) << 16));
+
+	writel((info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF=
0) << 16),
+	       fbi->regs + SM501_DC_PANEL_FB_OFFSET);
+
+	/* panel fb width */
+	dprintk("%s: framebuffer width =3D 0x%08x\n",
+	       __FUNCTION__, ((var->xres & 0xFFF) << 16));
+
+	writel((0 & 0xFFF) | ((var->xres & 0x0FFF) << 16),
+	       fbi->regs + SM501_DC_PANEL_FB_WIDTH);
+
+	/* panel fb height */
+	dprintk("%s: framebuffer height =3D 0x%08x\n",
+	       __FUNCTION__, ((var->yres & 0xFFF) << 16));
+
+	writel((0 & 0xFFF) | ((var->yres & 0xFFF) << 16),
+	       fbi->regs + SM501_DC_PANEL_FB_HEIGHT);
+
+	/* panel plane top left location */
+	dprintk("%s: framebuffer top left =3D 0x%08x\n",
+	       __FUNCTION__, ((0 & 0x7FF) | ((0 & 0x7FF) << 16)));
+
+	writel((0 & 0x7FF) | ((0 & 0x7FF) << 16),
+	       fbi->regs + SM501_DC_PANEL_TL_LOC);
+
+	/* panel plane bottom right  location */
+	dprintk("%s: framebuffer bottom right =3D 0x%08x\n", __FUNCTION__,
+	       (((var->xres - 1) & 0x7FF) | (((var->yres - 1) & 0x7FF) << 16)));
+	writel(((var->xres - 1) & 0x7FF) | (((var->yres - 1) & 0x7FF) << 16),
+	       fbi->regs + SM501_DC_PANEL_BR_LOC);
+
+	/* program horizontal total */
+	dprintk("%s: framebuffer htotal =3D 0x%x, xres =3D %d, "
+		"left =3D %d, right =3D %d, hsync =3D %d\n",
+		__FUNCTION__,
+		(((var->xres + var->left_margin + var->right_margin + var->hsync_len - 1=
) & 0xFFF) << 16) | ((var->xres - 1) & 0xFFF),
+		var->xres,
+		var->left_margin,
+		var->right_margin,
+		var->hsync_len);
+
+	writel((((var->xres + var->left_margin + var->right_margin + var->hsync_l=
en - 1) & 0xFFF) << 16) |
+	       ((var->xres - 1) & 0xFFF),
+	       fbi->regs + SM501_DC_PANEL_H_TOT);
+
+	/* program horizontal sync */
+	printk("%s: framebuffer hsync  =3D 0x%x\n", __FUNCTION__, ((var->hsync_le=
n & 0xFF) << 16 ) | ((var->xres + var->right_margin - 1) & 0x7FF));
+
+	writel(((var->hsync_len & 0xFF) << 16 ) |
+	       ((var->xres + var->right_margin - 1) & 0x7FF),
+	       fbi->regs + SM501_DC_PANEL_H_SYNC);
+
+	/* program vertical total */
+	dprintk("%s: framebuffer vtotal =3D 0x%x, yres =3D %d,"
+		" upper =3D %d, lower =3D %d, vsync =3D %d\n",
+		__FUNCTION__,
+		(((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - =
1) & 0x7FF) << 16) | ((var->yres - 1) & 0x7FF),
+		var->yres,
+		var->upper_margin,
+		var->lower_margin,
+		var->vsync_len);
+
+	writel((((var->upper_margin + var->yres + var->lower_margin + var->vsync_=
len - 1) & 0x7FF) << 16) |
+	       ((var->yres - 1) & 0x7FF),
+	       fbi->regs + SM501_DC_PANEL_V_TOT);
+
+	/* program vertical sync */
+	dprintk("%s: framebuffer vsync  =3D 0x%x\n",
+		__FUNCTION__,
+		((var->vsync_len & 0x3F) << 16) | (((var->yres + var->lower_margin - 1) =
& 0x7FF)));
+
+	writel(((var->vsync_len & 0x3F) << 16) |
+	       (((var->yres + var->lower_margin - 1) & 0x7FF)),
+	       fbi->regs + SM501_DC_PANEL_V_SYNC);
+
+	/* program control register */
+	control=3Dreadl(fbi->regs + SM501_DC_PANEL_CONTROL) & 0xCCF8;
+
+	switch(var->bits_per_pixel) {
+	case 8:
+		control |=3D 0;
+		break;
+
+	case 16:
+		control |=3D 1;
+		break;
+
+	case 32:
+		control |=3D 2;
+
+		sm501fb_setup_gamma(fbi,SM501_DC_PANEL_PALETTE);
+		break;
+
+	default:
+		break; /* uh oh */
+	}
+
+	control |=3D 1<<8;	/* enable PANEL timing */
+	control |=3D 1<<2;	/* enable PANEL graphics plane */
+
+	if((var->sync & FB_SYNC_HOR_HIGH_ACT) =3D=3D 0)
+		control |=3D 1<<12;
+
+	if((var->sync & FB_SYNC_VERT_HIGH_ACT) =3D=3D 0)
+		control |=3D 1<<13;
+
+	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
+
+	/* enable panel power */
+
+	control |=3D1<<24;//FPVDDEN
+	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
+	udelay(10000);	/* todo - better delay! */
+
+	control |=3D1<<25;//DATA
+	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
+	udelay(10000);
+
+	control |=3D1<<26;//VBIASEN
+	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
+	udelay(10000);
+
+	control |=3D1<<27;//FPEN
+	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
+
+	return 0;
+}
+
+/* from pxafb.c */
+static inline unsigned int chan_to_field(unsigned int chan,
+					 struct fb_bitfield *bf)
+{
+	chan &=3D 0xffff;
+	chan >>=3D 16 - bf->length;
+	return chan << bf->offset;
+}
+
+static int sm501fb_setcolreg_crt(unsigned regno,
+				 unsigned red, unsigned green, unsigned blue,
+				 unsigned transp, struct fb_info *info)
+{
+	struct sm501fb_par  *par =3D info->par;
+	unsigned int val;
+
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/* true-colour, use pseuo-palette */
+
+		if (regno < 16) {
+			u32 *pal =3D par->pseudo_palette;
+
+			val  =3D chan_to_field(red,   &info->var.red);
+			val |=3D chan_to_field(green, &info->var.green);
+			val |=3D chan_to_field(blue,  &info->var.blue);
+
+			pal[regno] =3D val;
+		}
+		break;
+
+	case FB_VISUAL_PSEUDOCOLOR:
+		if (regno < 256) {
+			/* currently assume RGB 5-6-5 mode */
+
+			val  =3D ((red   >>  0) & 0xf800);
+			val |=3D ((green >>  5) & 0x07e0);
+			val |=3D ((blue  >> 11) & 0x001f);
+		}
+
+		break;
+
+	default:
+		return 1;   /* unknown type */
+	}
+
+	return 0;
+}
+
+static int sm501fb_setcolreg_pnl(unsigned regno,
+				 unsigned red, unsigned green, unsigned blue,
+				 unsigned transp, struct fb_info *info)
+{
+	struct sm501fb_par  *par =3D info->par;
+	struct sm501fb_info *fbi =3D par->info;
+	unsigned int val;
+
+	/* dprintk("setcol: regno=3D%d, rgb=3D%d,%d,%d\n", regno, red, green, blu=
e); */
+
+	switch (info->fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/* true-colour, use pseuo-palette */
+
+		if (regno < 16) {
+			u32 *pal =3D par->pseudo_palette;
+
+			val  =3D chan_to_field(red,   &fbi->fb[0]->var.red);
+			val |=3D chan_to_field(green, &fbi->fb[0]->var.green);
+			val |=3D chan_to_field(blue,  &fbi->fb[0]->var.blue);
+
+			pal[regno] =3D val;
+		}
+		break;
+
+	case FB_VISUAL_PSEUDOCOLOR:
+		if (regno < 256) {
+			/* currently assume RGB 5-6-5 mode */
+
+			val  =3D ((red   >>  0) & 0xf800);
+			val |=3D ((green >>  5) & 0x07e0);
+			val |=3D ((blue  >> 11) & 0x001f);
+		}
+
+		break;
+
+	default:
+		return 1;   /* unknown type */
+	}
+
+	return 0;
+}
+
+
+/**
+ *      sm501fb_blank_crt
+ *	@blank_mode: the blank mode we want.
+ *	@info: frame buffer structure that represents a single frame buffer
+ *
+ *	Blank the screen if blank_mode !=3D 0, else unblank. Return 0 if
+ *	blanking succeeded, !=3D 0 if un-/blanking failed due to e.g. a
+ *	video mode which doesn't support it. Implements VESA suspend
+ *	and powerdown modes on hardware that supports disabling hsync/vsync:
+ *	blank_mode =3D=3D 2: suspend vsync
+ *	blank_mode =3D=3D 3: suspend hsync
+ *	blank_mode =3D=3D 4: powerdown
+ *
+ *	Returns negative errno on error, or zero on success.
+ *
+ */
+static int sm501fb_blank_crt(int blank_mode, struct fb_info *info)
+{
+	dprintk("blank(mode=3D%d, info=3D%p)\n", blank_mode, info);
+
+	if (blank_mode =3D=3D FB_BLANK_UNBLANK) {
+		dprintk("unblaking display\n");
+	} else {
+		dprintk("blanking display\n");
+	}
+
+	return 0;
+}
+
+/**
+ *      sm501fb_blank_pnl
+ *	@blank_mode: the blank mode we want.
+ *	@info: frame buffer structure that represents a single frame buffer
+ *
+ *	Blank the screen if blank_mode !=3D 0, else unblank. Return 0 if
+ *	blanking succeeded, !=3D 0 if un-/blanking failed due to e.g. a
+ *	video mode which doesn't support it. Implements VESA suspend
+ *	and powerdown modes on hardware that supports disabling hsync/vsync:
+ *	blank_mode =3D=3D 2: suspend vsync
+ *	blank_mode =3D=3D 3: suspend hsync
+ *	blank_mode =3D=3D 4: powerdown
+ *
+ *	Returns negative errno on error, or zero on success.
+ *
+ */
+static int sm501fb_blank_pnl(int blank_mode, struct fb_info *info)
+{
+	dprintk("blank(mode=3D%d, info=3D%p)\n", blank_mode, info);
+
+	if (blank_mode =3D=3D FB_BLANK_UNBLANK) {
+		dprintk("unblaking display\n");
+	} else {
+		dprintk("blanking display\n");
+	}
+
+	return 0;
+}
+
+/**
+ *	xxxfb_cursor
+ *      @info: frame buffer structure that represents a single frame buffer
+ *	@cursor: structure defining the cursor to draw.
+ *
+ *      This operation is used to set or alter the properities of the
+ *	cursor.
+ *
+ *	Returns negative errno on error, or zero on success.
+ */
+
+int sm501fb_cursor_crt(struct fb_info *info, struct fb_cursor *cursor)
+{
+	struct sm501fb_par  *par =3D info->par;
+	struct sm501fb_info *fbi =3D par->info;
+	unsigned long hwc_addr;
+	unsigned long fg, bg;
+
+	/* check not being asked to exceed capabilities */
+	if(cursor->image.width > 64)
+		return -ENXIO;
+
+	if(cursor->image.height > 64)
+		return -ENXIO;
+
+	if(cursor->image.depth > 1)
+		return -ENXIO;
+
+	hwc_addr=3Dreadl(fbi->regs + SM501_DC_CRT_HWC_ADDR);
+
+	if(cursor->enable)
+		writel(hwc_addr | 1<<31, fbi->regs + SM501_DC_CRT_HWC_ADDR);
+	else
+		writel(hwc_addr & ~(1<<31), fbi->regs + SM501_DC_CRT_HWC_ADDR);
+
+	/* set data */
+	if(cursor->set & FB_CUR_SETPOS) {
+		writel(((cursor->image.dx & 0x7FF) |
+			(cursor->image.dy & 0x7FF) <<16),
+		       fbi->regs + SM501_DC_CRT_HWC_LOC);
+	}
+
+	if(cursor->set & FB_CUR_SETHOT) {
+	}
+
+	if(cursor->set & FB_CUR_SETCMAP) {
+		bg =3D ((info->cmap.red[cursor->image.bg_color] & 0xF8) << 8) |
+			((info->cmap.green[cursor->image.bg_color] & 0xFC) << 3) |
+			((info->cmap.blue[cursor->image.bg_color] & 0xF8) >> 3);
+
+		fg =3D ((info->cmap.red[cursor->image.fg_color] & 0xF8) << 8) |
+			((info->cmap.green[cursor->image.fg_color] & 0xFC) << 3) |
+			((info->cmap.blue[cursor->image.fg_color] & 0xF8) >> 3);
+
+		writel(bg, fbi->regs + SM501_DC_CRT_HWC_COLOR_1_2);
+		writel(fg, fbi->regs + SM501_DC_CRT_HWC_COLOR_3);
+
+	}
+
+	if(cursor->set & FB_CUR_SETSIZE) {
+	}
+
+	if(cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
+	}
+
+/*
+ *      @set: 	Which fields we are altering in struct fb_cursor
+ *	@enable: Disable or enable the cursor
+ *      @rop: 	The bit operation we want to do.
+ *      @mask:  This is the cursor mask bitmap.
+ *      @dest:  A image of the area we are going to display the cursor.
+ *		Used internally by the driver.
+ *      @hot:	The hot spot.
+ *	@image:	The actual data for the cursor image.
+ *
+ *      NOTES ON FLAGS (cursor->set):
+ *
+ *      FB_CUR_SETIMAGE - the cursor image has changed (cursor->image.data)
+ *      FB_CUR_SETPOS   - the cursor position has changed (cursor->image.d=
x|dy)
+ *      FB_CUR_SETHOT   - the cursor hot spot has changed (cursor->hot.dx|=
dy)
+ *      FB_CUR_SETCMAP  - the cursor colors has changed (cursor->fg_color|=
bg_color)
+ *      FB_CUR_SETSHAPE - the cursor bitmask has changed (cursor->mask)
+ *      FB_CUR_SETSIZE  - the cursor size has changed (cursor->width|heigh=
t)
+ *      FB_CUR_SETALL   - everything has changed
+ *
+ *      NOTES ON ROPs (cursor->rop, Raster Operation)
+ *
+ *      ROP_XOR         - cursor->image.data XOR cursor->mask
+ *      ROP_COPY        - curosr->image.data AND cursor->mask
+ *
+ *      OTHER NOTES:
+ *
+ *      - fbcon only supports a 2-color cursor (cursor->image.depth =3D 1)
+ *      - The fb_cursor structure, @cursor, _will_ always contain valid
+ *        fields, whether any particular bitfields in cursor->set is set
+ *        or not.
+ */
+
+	return 0;
+}
+
+static int sm501fb_debug_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", debug ? "on" : "off");
+}
+static int sm501fb_debug_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t len)
+{
+	if (len < 1)
+		return -EINVAL;
+
+	if (strnicmp(buf, "on", 2) =3D=3D 0 ||
+	    strnicmp(buf, "1", 1) =3D=3D 0) {
+		debug =3D 1;
+		printk(KERN_DEBUG "sm501fb: Debug On\n");
+	} else if (strnicmp(buf, "off", 3) =3D=3D 0 ||
+		   strnicmp(buf, "0", 1) =3D=3D 0) {
+		debug =3D 0;
+		printk(KERN_DEBUG "sm501fb: Debug Off\n");
+	} else {
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+static DEVICE_ATTR(debug, 0666, sm501fb_debug_show, sm501fb_debug_store);
+
+static int sm501fb_debug_showfbregs(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct sm501fb_info *info =3D dev_get_drvdata(dev);
+	void __iomem *mem =3D info->regs;
+	char *ptr =3D buf;
+	int reg;
+	int res;
+
+	mem +=3D 0x200;
+
+	for (reg =3D 0; reg < 0x40; reg +=3D 4) {
+		res =3D sprintf(ptr, "%08x =3D %08x\n", reg, readl(mem + reg));
+		ptr +=3D res;
+	}
+
+	return ptr - buf;
+
+}
+
+static DEVICE_ATTR(fbregs, 0666, sm501fb_debug_showfbregs, NULL);
+
+static int sm501fb_debug_showregs(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct sm501fb_info *info =3D dev_get_drvdata(dev);
+	void __iomem *mem =3D info->regs;
+	char *ptr =3D buf;
+	int reg;
+	int res;
+
+	for (reg =3D 0; reg < 0x138; reg +=3D 4) {
+		res =3D sprintf(ptr, "%08x =3D %08x\n", reg, readl(mem + reg));
+		ptr +=3D res;
+	}
+
+	return ptr - buf;
+}
+
+
+static DEVICE_ATTR(regs, 0666, sm501fb_debug_showregs, NULL);
+
+
+static struct fb_ops sm501fb_ops_crt =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D sm501fb_check_var_crt,
+	.fb_set_par	=3D sm501fb_set_par_crt,
+	.fb_blank	=3D sm501fb_blank_crt,
+	.fb_setcolreg	=3D sm501fb_setcolreg_crt,
+	.fb_cursor	=3D sm501fb_cursor_crt,
+	.fb_fillrect	=3D cfb_fillrect,
+	.fb_copyarea	=3D cfb_copyarea,
+	.fb_imageblit	=3D cfb_imageblit,
+};
+
+static struct fb_ops sm501fb_ops_pnl =3D {
+	.owner		=3D THIS_MODULE,
+	.fb_check_var	=3D sm501fb_check_var_pnl,
+	.fb_set_par	=3D sm501fb_set_par_pnl,
+	.fb_blank	=3D sm501fb_blank_pnl,
+	.fb_setcolreg	=3D sm501fb_setcolreg_pnl,
+	.fb_fillrect	=3D cfb_fillrect,
+	.fb_copyarea	=3D cfb_copyarea,
+	.fb_imageblit	=3D cfb_imageblit,
+};
+
+static irqreturn_t sm501fb_irq(int irq, void *pw, struct pt_regs *r)
+{
+	return IRQ_HANDLED;
+}
+
+
+/* sm501fb_info_alloc
+ *
+ * creates and initialises an sm501fb_info structure
+ */
+static struct sm501fb_info * sm501fb_info_alloc(struct fb_info *fbinfo_crt,
+						struct fb_info *fbinfo_pnl)
+{
+	struct sm501fb_info *info;
+	struct sm501fb_par  *par;
+
+	info =3D kzalloc(sizeof(struct sm501fb_info), GFP_KERNEL);
+	if (info) {
+		/* set the references back */
+
+		par =3D fbinfo_crt->par;
+		par->info =3D info;
+		fbinfo_crt->pseudo_palette =3D &par->pseudo_palette;
+
+		par =3D fbinfo_pnl->par;
+		par->info =3D info;
+		fbinfo_pnl->pseudo_palette =3D &par->pseudo_palette;
+
+		/* store the two fbs into our info */
+		info->fb[HEAD_CRT] =3D fbinfo_crt;
+		info->fb[HEAD_PANNEL] =3D fbinfo_pnl;
+	}
+
+	return info;
+}
+
+int sm501_init_cursor(struct fb_info *fbi, unsigned int reg_base)
+{
+	struct sm501fb_par *par =3D fbi->par;
+	struct sm501fb_info *info =3D par->info;
+	int ret;
+
+	par->cursor_regs =3D info->regs + reg_base;
+
+	ret =3D sm501_alloc_mem(info, &par->cursor, SM501_MEMF_CURSOR, 1024);
+	if (ret < 0)
+		return ret;
+
+	/* initialise the colour registers */
+
+	writel(par->cursor.sm_addr, par->cursor_regs + SM501_OFF_HWC_ADDR);
+
+	writel(0x00, par->cursor_regs + SM501_OFF_HWC_LOC);
+	writel(0x00, par->cursor_regs + SM501_OFF_HWC_COLOR_1_2);
+	writel(0x00, par->cursor_regs + SM501_OFF_HWC_COLOR_3);
+
+	return 0;
+}
+
+/* sm501fb_info_start
+ *
+ * fills the par structure claiming resources and remapping etc.
+ *   returns 0 for success or value for faliure
+ */
+static int sm501fb_start(struct sm501fb_info *info,
+			 struct platform_device *pdev)
+{
+	struct resource	*res;
+	int ret;
+
+	info->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, info);
+
+	info->irq =3D ret =3D platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "no irq for device\n");
+		goto err_release;
+	}
+
+	/* allocate, reserve and remap resources for registers */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res =3D=3D NULL) {
+		dev_err(&pdev->dev, "no resource definition for registers\n");
+		ret =3D -ENOENT;
+		goto err_release;
+	}
+
+	printk("%s: request_mem_region(%08lx,%08lx)\n",
+	       __FUNCTION__,
+	       res->start,
+	       res->end - res->start);
+
+	info->regs_res =3D request_mem_region(res->start,
+					    res->end - res->start,
+					    pdev->name);
+
+	if (info->regs_res =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot claim registers\n");
+		ret =3D -ENXIO;
+		goto err_release;
+	}
+
+	info->regs =3D ioremap(res->start, (res->end - res->start)+1);
+	if (info->regs =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot remap registers\n");
+		ret =3D -ENXIO;
+		goto err_regs_res;
+	}
+
+	/* allocate, reserve and remap resources for frambuffer */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res =3D=3D NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		ret =3D -ENXIO;
+		goto err_regs_map;
+	}
+
+	info->fbmem_res =3D request_mem_region(res->start,
+					     (res->end - res->start)+1,
+					     pdev->name);
+	if (info->fbmem_res =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot claim framebuffer\n");
+		ret =3D -ENXIO;
+		goto err_regs_map;
+	}
+
+	info->fbmem =3D ioremap(res->start, (res->end - res->start)+1);
+	if (info->fbmem =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot remap framebuffer\n");
+		goto err_mem_res;
+	}
+
+	info->fbmem_len =3D (res->end - res->start)+1;
+
+/*	ret =3D request_irq(info->irq, sm501fb_irq, SA_SHIRQ | SA_INTERRUPT,
+	pdev->name, info);
+	if (ret) {
+	dev_err(&pdev->dev, "cannot get irq %d (%d)\n", info->irq, ret);
+	goto err_mem_map;
+	}
+*/
+
+	/* enable display controller */
+	sm501_unit_power(info->dev->parent, SM501_GATE_DISPLAY, 1);
+
+	/* setup cursors */
+
+	sm501_init_cursor(info->fb[HEAD_CRT], SM501_DC_CRT_HWC_ADDR);
+	sm501_init_cursor(info->fb[HEAD_PANNEL], SM501_DC_PANEL_HWC_ADDR);
+
+        /* TODO - enable 2d engine
+	 *      - enable list processor
+         *      - any other global hw sate */
+
+	return 0; /* everything is setup */
+
+ err_irq:
+	/*free_irq(info->irq, info);*/
+	//err_mem_map:
+	iounmap(info->fbmem);
+ err_mem_res:
+	release_mem_region(info->fbmem_res->start,
+			   (info->fbmem_res->end - info->fbmem_res->start) + 1);
+ err_regs_map:
+	iounmap(info->regs);
+ err_regs_res:
+	release_mem_region(info->regs_res->start,
+			   info->regs_res->end - info->regs_res->start);
+ err_release:
+	return ret;
+}
+
+static void sm501fb_stop(struct sm501fb_info *info)
+{
+	/* disable display controller */
+	sm501_unit_power(info->dev->parent, SM501_GATE_DISPLAY, 0);
+
+	/*free_irq(info->irq, info);*/
+	iounmap(info->fbmem);
+	release_mem_region(info->fbmem_res->start,
+			   (info->fbmem_res->end - info->fbmem_res->start) + 1);
+	iounmap(info->regs);
+	release_mem_region(info->regs_res->start,
+			   (info->regs_res->end - info->regs_res->start) + 1);
+}
+
+static void sm501fb_info_release(struct sm501fb_info *info)
+{
+	kfree(info);
+}
+
+static char driver_name_crt[] =3D "sm501fb-crt";
+static char driver_name_pnl[] =3D "sm501fb-pnl";
+
+static int __init sm501fb_probe(struct platform_device *pdev)
+{
+	struct sm501fb_info *info;
+	struct fb_info	    *fbinfo_crt;
+	struct fb_info	    *fbinfo_pnl;
+	int		     ret;
+
+	/* allocate our framebuffers */
+
+	fbinfo_crt =3D framebuffer_alloc(sizeof(struct sm501fb_par), &pdev->dev);
+	if (fbinfo_crt =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot allocate primary framebuffer\n");
+		return -ENOMEM;
+	}
+
+	fbinfo_pnl =3D framebuffer_alloc(sizeof(struct sm501fb_par), &pdev->dev);
+	if (fbinfo_pnl =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot allocate secondary framebuffer\n");
+		ret =3D -ENOMEM;
+		goto fbinfo_crt_alloc_fail;
+	}
+
+	info =3D sm501fb_info_alloc(fbinfo_crt, fbinfo_pnl);
+	if (info =3D=3D NULL) {
+		dev_err(&pdev->dev, "cannot allocate par\n");
+		ret =3D -ENOMEM;
+		goto sm501fb_alloc_fail;
+	}
+
+	/* start the framebuffers */
+
+	ret =3D sm501fb_start(info, pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot initialise SM501\n");
+		goto sm501fb_start_fail;
+	}
+
+	/* Primary framebuffer structure setup */
+
+	/* framebuffer details*/
+	fbinfo_crt->fbops		=3D &sm501fb_ops_crt;
+	fbinfo_crt->flags		=3D FBINFO_FLAG_DEFAULT;
+
+	/* crt fixed data */
+	strcpy(fbinfo_crt->fix.id, driver_name_crt);
+	fbinfo_crt->fix.type		=3D FB_TYPE_PACKED_PIXELS;
+	fbinfo_crt->fix.type_aux	=3D 0;
+	fbinfo_crt->fix.xpanstep	=3D 0;
+	fbinfo_crt->fix.ypanstep	=3D 0;
+	fbinfo_crt->fix.ywrapstep	=3D 0;
+	fbinfo_crt->fix.accel		=3D FB_ACCEL_NONE;
+
+	/* screenmode */
+	fbinfo_crt->var.nonstd		=3D 0;
+	fbinfo_crt->var.activate	=3D FB_ACTIVATE_NOW;
+	fbinfo_crt->var.accel_flags	=3D 0;
+	fbinfo_crt->var.vmode		=3D FB_VMODE_NONINTERLACED;
+	fbinfo_crt->var.bits_per_pixel  =3D 16;
+
+	ret =3D fb_find_mode(&fbinfo_crt->var, fbinfo_crt, NULL, NULL, 0, NULL, 8=
);
+
+	if (!ret || ret =3D=3D 4) {
+		printk(KERN_ERR "Failed to find mode\n");
+		ret=3D-EINVAL;
+		goto register_crt_fail;
+	}
+
+	printk("%s: screen base: 0x%p size: 0x%08lx\n", __FUNCTION__,
+	       fbinfo_crt->screen_base, fbinfo_crt->screen_size);
+
+	/* This has to been done !!! */
+	fb_alloc_cmap(&fbinfo_crt->cmap, NR_PALETTE, 0);
+
+	ret =3D sm501fb_check_var_crt(&fbinfo_crt->var, fbinfo_crt);
+
+	/* Secondary framebuffer structure setup */
+
+	/* framebuffer details*/
+	fbinfo_pnl->fbops		=3D &sm501fb_ops_pnl;
+	fbinfo_pnl->flags		=3D FBINFO_FLAG_DEFAULT;
+
+#if 0
+	fbinfo_pnl->screen_base 	=3D info->fbmem+(4096*1024); /* TODO - use a mem=
ory handler */
+	fbinfo_pnl->screen_size 	=3D info->fbmem_len - (4096*1024); /* TODO - use=
 a memory handler */
+#endif
+
+	/* crt fixed data */
+	strcpy(fbinfo_pnl->fix.id, driver_name_pnl);
+	fbinfo_pnl->fix.type		=3D FB_TYPE_PACKED_PIXELS;
+	fbinfo_pnl->fix.type_aux	=3D 0;
+	fbinfo_pnl->fix.xpanstep	=3D 0;
+	fbinfo_pnl->fix.ypanstep	=3D 0;
+	fbinfo_pnl->fix.ywrapstep	=3D 0;
+	fbinfo_pnl->fix.accel		=3D FB_ACCEL_NONE;
+#if 0
+	fbinfo_pnl->fix.smem_start 	=3D info->fbmem_res->start+(4096*1024);
+	fbinfo_pnl->fix.smem_len 	=3D info->fbmem_len - (4096*1024);
+#endif
+
+	/* screenmode */
+	fbinfo_pnl->var.nonstd		=3D 0;
+	fbinfo_pnl->var.activate	=3D FB_ACTIVATE_NOW;
+	fbinfo_pnl->var.accel_flags	=3D 0;
+	fbinfo_pnl->var.vmode		=3D FB_VMODE_NONINTERLACED;
+	fbinfo_pnl->var.bits_per_pixel  =3D 16;
+
+	/* TODO - check if display already running (setup from BIOS)
+	 * and set var accordingly. Once thats done should use set
+	 * par here to change to selected mode, will enable with
+	 * default mode if BIOS didnt already setup */
+
+	ret =3D fb_find_mode(&fbinfo_pnl->var, fbinfo_pnl, NULL, NULL, 0, NULL, 8=
);
+
+	if (!ret || ret =3D=3D 4)
+	{
+		printk(KERN_ERR "Failed to find mode\n");
+		ret=3D-EINVAL;
+		goto register_crt_fail;
+	}
+
+	printk("%s: screen base: 0x%p size: 0x%08lx\n", __FUNCTION__,
+	       fbinfo_pnl->screen_base, fbinfo_pnl->screen_size);
+
+	/* Allocate colourmap */
+	fb_alloc_cmap(&fbinfo_pnl->cmap, NR_PALETTE, 0);
+
+	/* verify mode setting */
+	ret =3D sm501fb_check_var_pnl(&fbinfo_pnl->var, fbinfo_pnl);
+
+	/* register framebuffers */
+	ret =3D register_framebuffer(fbinfo_crt);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to register CRT framebuffer: %d\n", ret);
+		goto register_crt_fail;
+	}
+
+	ret =3D register_framebuffer(fbinfo_pnl);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to register panel framebuffer: %d\n", ret);
+		goto register_pnl_fail;
+	}
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       fbinfo_crt->node, fbinfo_crt->fix.id);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       fbinfo_pnl->node, fbinfo_pnl->fix.id);
+
+	/* create device files */
+	device_create_file(&pdev->dev, &dev_attr_debug);
+	device_create_file(&pdev->dev, &dev_attr_regs);
+	device_create_file(&pdev->dev, &dev_attr_fbregs);
+
+
+	return 0;
+
+ register_pnl_fail:
+	unregister_framebuffer(fbinfo_crt);
+ register_crt_fail:
+	sm501fb_stop(info);
+ sm501fb_start_fail:
+	sm501fb_info_release(info);
+ sm501fb_alloc_fail:
+	framebuffer_release(fbinfo_pnl);
+ fbinfo_crt_alloc_fail:
+	framebuffer_release(fbinfo_crt);
+
+	return ret;
+}
+
+
+/*
+ *  Cleanup
+ */
+static int sm501fb_remove(struct platform_device *pdev)
+{
+	struct sm501fb_info *info =3D platform_get_drvdata(pdev);
+	struct fb_info	   *fbinfo_crt =3D info->fb[0];
+	struct fb_info	   *fbinfo_pnl =3D info->fb[1];
+
+	device_remove_file(&pdev->dev, &dev_attr_debug);
+	device_remove_file(&pdev->dev, &dev_attr_regs);
+	device_remove_file(&pdev->dev, &dev_attr_fbregs);
+
+	unregister_framebuffer(fbinfo_crt);
+
+	unregister_framebuffer(fbinfo_pnl);
+
+	sm501fb_stop(info);
+
+	sm501fb_info_release(info);
+
+	framebuffer_release(fbinfo_pnl);
+
+	framebuffer_release(fbinfo_crt);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+/* suspend and resume support for the lcd controller */
+
+static int sm501fb_suspend(struct platform_device *dev, pm_message_t state)
+{
+	return 0;
+}
+
+static int sm501fb_resume(struct platform_device *dev)
+{
+	return 0;
+}
+
+#else
+#define sm501fb_suspend NULL
+#define sm501fb_resume  NULL
+#endif
+
+static struct platform_driver sm501fb_driver =3D {
+	.probe		=3D sm501fb_probe,
+	.remove		=3D sm501fb_remove,
+	.suspend	=3D sm501fb_suspend,
+	.resume		=3D sm501fb_resume,
+	.driver		=3D {
+		.name	=3D "sm501-fb",
+		.owner	=3D THIS_MODULE,
+	},
+};
+
+int __devinit sm501fb_init(void)
+{
+	return platform_driver_register(&sm501fb_driver);
+}
+
+static void __exit sm501fb_cleanup(void)
+{
+	platform_driver_unregister(&sm501fb_driver);
+}
+
+
+module_init(sm501fb_init);
+module_exit(sm501fb_cleanup);
+
+MODULE_AUTHOR("Ben Dooks, Vincent Sanders");
+MODULE_DESCRIPTION("Framebuffer driver for the SM501");
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.16-orig/include/linux/sm501.h linux-2.6.16-sm501/includ=
e/linux/sm501.h
--- linux-2.6.16-orig/include/linux/sm501.h	1970-01-01 01:00:00.000000000 +=
0100
+++ linux-2.6.16-sm501/include/linux/sm501.h	2006-05-05 14:10:49.000000000 =
+0100
@@ -0,0 +1,12 @@
+/* include/linux/sm501.h
+ *
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks, Vincent Sanders
+ *
+*/
+
+extern int sm501_unit_power(struct device *dev, unsigned int unit, unsigne=
d int to);
+
+extern int sm501_set_clock(struct device *dev, int clksrc, unsigned long f=
req);
+
+extern int sm501_misc_control(struct device *dev, unsigned int func, unsig=
ned int to);
diff -urN linux-2.6.16-orig/include/linux/sm501-regs.h linux-2.6.16-sm501/i=
nclude/linux/sm501-regs.h
--- linux-2.6.16-orig/include/linux/sm501-regs.h	1970-01-01 01:00:00.000000=
000 +0100
+++ linux-2.6.16-sm501/include/linux/sm501-regs.h	2006-05-14 23:15:28.00000=
0000 +0100
@@ -0,0 +1,258 @@
+/* sm501-regs.h
+ *
+ * Copyright V.R.Sanders 2006
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Silicon motion SM501 register definitions
+ */
+
+/* System Configuration area */
+/* System config base */
+#define SM501_SYS_CONFIG		(0x000000)
+
+/* config 1 */
+#define SM501_SYSTEM_CONTROL 		(0x000000)
+#define SM501_MISC_CONTROL		(0x000004)
+
+#define SM501_MISC_DAC_POWER		(12)
+#define SM501_MISC_PNL_24BIT		(25)
+
+#define SM501_GPIO31_0_CONTROL		(0x000008)
+#define SM501_GPIO63_32_CONTROL		(0x00000C)
+#define SM501_DRAM_CONTROL		(0x000010)
+
+/* command list */
+#define SM501_ARBTRTN_CONTROL		(0x000014)
+
+/* command list */
+#define SM501_COMMAND_LIST_STATUS	(0x000024)
+
+/* interrupt debug */
+#define SM501_RAW_IRQ_STATUS		(0x000028)
+#define SM501_RAW_IRQ_CLEAR		(0x000028)
+#define SM501_IRQ_STATUS		(0x00002C)
+#define SM501_IRQ_MASK			(0x000030)
+#define SM501_DEBUG_CONTROL		(0x000034)
+
+/* power management */
+#define SM501_CURRENT_GATE		(0x000038)
+#define SM501_CURRENT_CLOCK		(0x00003C)
+#define SM501_POWER_MODE_0_GATE		(0x000040)
+#define SM501_POWER_MODE_0_CLOCK	(0x000044)
+#define SM501_POWER_MODE_1_GATE		(0x000048)
+#define SM501_POWER_MODE_1_CLOCK	(0x00004C)
+#define SM501_SLEEP_MODE_GATE		(0x000050)
+#define SM501_POWER_MODE_CONTROL	(0x000054)
+
+/* power gates for units within the 501 */
+#define SM501_GATE_HOST			(0)
+#define SM501_GATE_MEMORY		(1)
+#define SM501_GATE_DISPLAY		(2)
+#define SM501_GATE_2D_ENGINE		(3)
+#define SM501_GATE_CSC			(4)
+#define SM501_GATE_ZVPORT		(5)
+#define SM501_GATE_GPIO			(6)
+#define SM501_GATE_UART0		(7)
+#define SM501_GATE_UART1		(8)
+#define SM501_GATE_SSP			(10)
+#define SM501_GATE_USB_HOST		(11)
+#define SM501_GATE_USB_GADGET		(12)
+#define SM501_GATE_UCONTROLLER		(17)
+#define SM501_GATE_AC97			(18)
+
+/* panel clock */
+#define SM501_CLOCK_P2XCLK		(24)
+/* crt clock */
+#define SM501_CLOCK_V2XCLK		(16)
+/* main clock */
+#define SM501_CLOCK_MCLK		(8)
+/* SDRAM controller clock */
+#define SM501_CLOCK_M1XCLK		(0)
+
+/* config 2 */
+#define SM501_PCI_MASTER_BASE		(0x000058)
+#define SM501_ENDIAN_CONTROL		(0x00005C)
+#define SM501_DEVICEID			(0x000060)
+/* 0x050100A0 */
+
+#define SM501_PLLCLOCK_COUNT		(0x000064)
+#define SM501_MISC_TIMING		(0x000068)
+#define SM501_CURRENT_SDRAM_CLOCK	(0x00006C)
+
+/* GPIO base */
+#define SM501_GPIO			(0x010000)
+#define SM501_GPIO_DATA_LOW		(0x00)
+#define SM501_GPIO_DATA_HIGH		(0x04)
+#define SM501_GPIO_DDR_LOW		(0x08)
+#define SM501_GPIO_DDR_HIGH		(0x0C)
+#define SM501_GPIO_IRQ_SETUP		(0x10)
+#define SM501_GPIO_IRQ_STATUS		(0x14)
+#define SM501_GPIO_IRQ_RESET		(0x14)
+
+/* I2C controller base */
+#define SM501_I2C			(0x010040)
+#define SM501_I2C_BYTE_COUNT		(0x00)
+#define SM501_I2C_CONTROL		(0x01)
+#define SM501_I2C_STATUS		(0x02)
+#define SM501_I2C_RESET			(0x02)
+#define SM501_I2C_SLAVE_ADDRESS		(0x03)
+#define SM501_I2C_DATA			(0x04)
+
+/* SSP base */
+#define SM501_SSP			(0x020000)
+
+/* Uart 0 base */
+#define SM501_UART0			(0x030000)
+
+/* Uart 1 base */
+#define SM501_UART1			(0x030020)
+
+/* USB host port base */
+#define SM501_USB_HOST			(0x040000)
+
+/* USB slave/gadget base */
+#define SM501_USB_GADGET		(0x060000)
+
+/* USB slave/gadget data port base */
+#define SM501_USB_GADGET_DATA		(0x070000)
+
+/* Display contoller/video engine base */
+#define SM501_DC			(0x080000)
+#define SM501_DC_PANEL_CONTROL		(0x000)
+#define SM501_DC_PANEL_PANNING_CONTROL	(0x004)
+#define SM501_DC_PANEL_COLOR_KEY	(0x008)
+#define SM501_DC_PANEL_FB_ADDR		(0x00C)
+#define SM501_DC_PANEL_FB_OFFSET	(0x010)
+#define SM501_DC_PANEL_FB_WIDTH		(0x014)
+#define SM501_DC_PANEL_FB_HEIGHT	(0x018)
+#define SM501_DC_PANEL_TL_LOC		(0x01C)
+#define SM501_DC_PANEL_BR_LOC		(0x020)
+#define SM501_DC_PANEL_H_TOT		(0x024)
+#define SM501_DC_PANEL_H_SYNC		(0x028)
+#define SM501_DC_PANEL_V_TOT		(0x02C)
+#define SM501_DC_PANEL_V_SYNC		(0x030)
+#define SM501_DC_PANEL_CUR_LINE		(0x034)
+
+#define SM501_DC_VIDEO_CONTROL		(0x040)
+#define SM501_DC_VIDEO_FB0_ADDR		(0x044)
+#define SM501_DC_VIDEO_FB_WIDTH		(0x048)
+#define SM501_DC_VIDEO_FB0_LAST_ADDR	(0x04C)
+#define SM501_DC_VIDEO_TL_LOC		(0x050)
+#define SM501_DC_VIDEO_BR_LOC		(0x054)
+#define SM501_DC_VIDEO_SCALE		(0x058)
+#define SM501_DC_VIDEO_INIT_SCALE	(0x05C)
+#define SM501_DC_VIDEO_YUV_CONSTANTS	(0x060)
+#define SM501_DC_VIDEO_FB1_ADDR		(0x064)
+#define SM501_DC_VIDEO_FB1_LAST_ADDR	(0x068)
+
+#define SM501_DC_VIDEO_ALPHA_CONTROL	(0x080)
+#define SM501_DC_VIDEO_ALPHA_FB_ADDR	(0x084)
+#define SM501_DC_VIDEO_ALPHA_FB_OFFSET	(0x088)
+#define SM501_DC_VIDEO_ALPHA_FB_LAST_ADDR	(0x08C)
+#define SM501_DC_VIDEO_ALPHA_TL_LOC	(0x090)
+#define SM501_DC_VIDEO_ALPHA_BR_LOC	(0x094)
+#define SM501_DC_VIDEO_ALPHA_SCALE	(0x098)
+#define SM501_DC_VIDEO_ALPHA_INIT_SCALE	(0x09C)
+#define SM501_DC_VIDEO_ALPHA_CHROMA_KEY	(0x0A0)
+#define SM501_DC_VIDEO_ALPHA_COLOR_LOOKUP	(0x0A4)
+
+
+#define SM501_DC_PANEL_HWC_ADDR		(0x0F0)
+#define SM501_DC_PANEL_HWC_LOC		(0x0F4)
+#define SM501_DC_PANEL_HWC_COLOR_1_2	(0x0F8)
+#define SM501_DC_PANEL_HWC_COLOR_3	(0x0FC)
+
+#define SM501_OFF_HWC_ADDR		(0x00)
+#define SM501_OFF_HWC_LOC		(0x04)
+#define SM501_OFF_HWC_COLOR_1_2		(0x08)
+#define SM501_OFF_HWC_COLOR_3		(0x0C)
+
+#define SM501_DC_ALPHA_CONTROL		(0x100)
+#define SM501_DC_ALPHA_FB_ADDR		(0x104)
+#define SM501_DC_ALPHA_FB_OFFSET	(0x108)
+#define SM501_DC_ALPHA_TL_LOC		(0x10C)
+#define SM501_DC_ALPHA_BR_LOC		(0x110)
+#define SM501_DC_ALPHA_CHROMA_KEY	(0x114)
+#define SM501_DC_ALPHA_COLOR_LOOKUP	(0x118)
+
+#define SM501_DC_CRT_CONTROL		(0x200)
+#define SM501_DC_CRT_FB_ADDR		(0x204)
+#define SM501_DC_CRT_FB_OFFSET		(0x208)
+#define SM501_DC_CRT_H_TOT		(0x20C)
+#define SM501_DC_CRT_H_SYNC		(0x210)
+#define SM501_DC_CRT_V_TOT		(0x214)
+#define SM501_DC_CRT_V_SYNC		(0x218)
+#define SM501_DC_CRT_SIGNATURE_ANALYZER	(0x21C)
+#define SM501_DC_CRT_CUR_LINE		(0x220)
+#define SM501_DC_CRT_MONITOR_DETECT	(0x224)
+
+#define SM501_DC_CRT_HWC_ADDR		(0x230)
+#define SM501_DC_CRT_HWC_LOC		(0x234)
+#define SM501_DC_CRT_HWC_COLOR_1_2	(0x238)
+#define SM501_DC_CRT_HWC_COLOR_3	(0x23C)
+
+#define SM501_DC_PANEL_PALETTE		(0x400)
+
+#define SM501_DC_VIDEO_PALETTE		(0x800)
+
+#define SM501_DC_CRT_PALETTE		(0xC00)
+
+/* Zoom Video port base */
+#define SM501_ZVPORT			(0x090000)
+
+/* AC97/I2S base */
+#define SM501_AC97			(0x0A0000)
+
+/* 8051 micro controller base */
+#define SM501_UCONTROLLER		(0x0B0000)
+
+/* 8051 micro controller SRAM base */
+#define SM501_UCONTROLLER_SRAM		(0x0C0000)
+
+/* DMA base */
+#define SM501_DMA			(0x0D0000)
+
+/* 2d engine base */
+#define SM501_2D_ENGINE			(0x100000)
+#define SM501_2D_SOURCE			(0x00)
+#define SM501_2D_DESTINATION		(0x04)
+#define SM501_2D_DIMENSION		(0x08)
+#define SM501_2D_CONTROL		(0x0C)
+#define SM501_2D_PITCH			(0x10)
+#define SM501_2D_FOREGROUND		(0x14)
+#define SM501_2D_BACKGROUND		(0x18)
+#define SM501_2D_STRETCH		(0x1C)
+#define SM501_2D_COLOR_COMPARE		(0x20)
+#define SM501_2D_COLOR_COMPARE_MASK 	(0x24)
+#define SM501_2D_MASK			(0x28)
+#define SM501_2D_CLIP_TL		(0x2C)
+#define SM501_2D_CLIP_BR		(0x30)
+#define SM501_2D_MONO_PATTERN_LOW	(0x34)
+#define SM501_2D_MONO_PATTERN_HIGH	(0x38)
+#define SM501_2D_WINDOW_WIDTH		(0x3C)
+#define SM501_2D_SOURCE_BASE		(0x40)
+#define SM501_2D_DESTINATION_BASE	(0x44)
+#define SM501_2D_ALPHA			(0x48)
+#define SM501_2D_WRAP			(0x4C)
+#define SM501_2D_STATUS			(0x50)
+
+#define SM501_CSC_Y_SOURCE_BASE		(0xC8)
+#define SM501_CSC_CONSTANTS		(0xCC)
+#define SM501_CSC_Y_SOURCE_X		(0xD0)
+#define SM501_CSC_Y_SOURCE_Y		(0xD4)
+#define SM501_CSC_U_SOURCE_BASE		(0xD8)
+#define SM501_CSC_V_SOURCE_BASE		(0xDC)
+#define SM501_CSC_SOURCE_DIMENSION	(0xE0)
+#define SM501_CSC_SOURCE_PITCH		(0xE4)
+#define SM501_CSC_DESTINATION		(0xE8)
+#define SM501_CSC_DESTINATION_DIMENSION	(0xEC)
+#define SM501_CSC_DESTINATION_PITCH	(0xF0)
+#define SM501_CSC_SCALE_FACTOR		(0xF4)
+#define SM501_CSC_DESTINATION_BASE	(0xF8)
+#define SM501_CSC_CONTROL		(0xFC)
+
+/* 2d engine data port base */
+#define SM501_2D_ENGINE_DATA		(0x110000)

--BwCQnh7xodEAoBMC--

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEZ7E1iUwwPOvjHvURAmXHAKCOVzPsz6HH8iiOdy0ZONYPMIM8wACfYLV1
ef7ieH+JZhNWZpQef1VMTQk=
=X1iK
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
