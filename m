From: Bernhard Fischer <yght@users.sourceforge.net>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
	controller
Date: Tue, 11 Jul 2006 15:24:02 +0200
Message-ID: <20060711132402.GB1533@aon.at>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il> <44B18F68.2080802@gmail.com>
	<44B3954D.4040302@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0IDk-00032Z-BW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:24:12 -0700
Received: from warsl404pip2.highway.telekom.at ([195.3.96.113]
	helo=email.aon.at) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1G0IDj-0006uD-Ni for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 11 Jul 2006 06:24:12 -0700
Received: from m866p024.adsl.highway.telekom.at (HELO s37.loc) ([62.47.140.56])
	(envelope-sender <yght@users.sourceforge.net>)
	by smarthub79.highway.telekom.at (qmail-ldap-1.03) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	11 Jul 2006 13:24:02 -0000
Content-Disposition: inline
In-Reply-To: <44B3954D.4040302@compulab.co.il>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

Could some kind soul do a recursive s/timming/timing/g in
drivers/video, please? TIA.

A few cosmetic remarks regarding the mbx driver below..

On Tue, Jul 11, 2006 at 02:10:53PM +0200, Mike Rapoport wrote:
>--- a/drivers/video/Kconfig
>+++ b/drivers/video/Kconfig
>@@ -1518,6 +1518,16 @@ config FB_PXA_PARAMETERS
> 
> 	  <file:Documentation/fb/pxafb.txt> describes the available parameters.
> 
>+config FB_MBX
>+	tristate "2700G LCD framebuffer support"
>+	depends on FB && ARCH_PXA
>+	select FB_CFB_FILLRECT
>+	select FB_CFB_COPYAREA
>+	select FB_CFB_IMAGEBLIT
>+	---help---
>+

A tad more description would be nice:
	  Intel 2700G (Marathon) Graphics Accelerator Frame Buffer
	  Driver

>+	  If unsure, say N.
>+
> config FB_W100
> 	tristate "W100 frame buffer support"
> 	depends on FB && PXA_SHARPSL

>diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
>new file mode 100644
>index 0000000..c41a678
>--- /dev/null
>+++ b/drivers/video/mbx/mbxfb.c

>+#define MAX_PALETTES	16
>+
>+/* FIXME: take care of different chip reivsions with different sizes

s/reivsions/revisions/

>+#ifdef CONFIG_PM
>+/*
>+ * Power management hooks.  Note that we won't be called from IRQ context,
>+ * unlike the blank functions above, so we may sleep.
>+ */
>+static int mbxfb_suspend(struct platform_device *dev, pm_message_t state)
>+{
>+	/* make frame buffer memory enter self-refresh mode */
>+	writel(LMPWR_MC_PWR_SRM, LMPWR);
>+	while (LMPWRSTAT != LMPWRSTAT_MC_PWR_SRM)
>+		; /* empty statement */
>+
>+	/* reset the device, since it's initial state is 'mostly sleeping' */
>+	writel(SYSRST_RST, SYSRST);
>+	return 0;
>+}
>+
>+static int mbxfb_resume(struct platform_device *dev)
>+{
>+	struct fb_info *fbi = (struct fb_info *)platform_get_drvdata(dev);
>+
>+	enable_clocks(fbi);
>+/* 	setup_graphics(fbi); */
>+/* 	setup_display(fbi); */
>+
>+	writel((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
>+	return 0;
>+}

IIRC it was already stated that it is better to only set the .suspend
and .resume ops depending on CONFIG_PM (see below instead of the #if
#else #endif stanza here).
>+#else
>+#define mbxfb_suspend	NULL
>+#define mbxfb_resume	NULL
>+#endif

>+static struct platform_driver mbxfb_driver = {
>+	.probe = mbxfb_probe,
>+	.remove = mbxfb_remove,

#ifdef CONFIG_PM

>+	.suspend = mbxfb_suspend,
>+	.resume = mbxfb_resume,

#endif /* CONFIG_PM */

>+	.driver = {
>+		.name = "mbx-fb",
>+	},
>+};

cheers,


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
