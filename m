From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] i810fb: make probe of DDC3 optional
Date: Wed, 25 Jan 2006 08:17:18 +0100
Message-ID: <20060125071718.GA7757@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1euF-00010G-Uk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:17:27 -0800
Received: from fnoeppeil48.netpark.at ([217.175.205.176] helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1F1euE-0003PK-7K
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:17:27 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com


Some time before 2.6.15, a third DDC channel was added to i810fb.
On systems where these ddc pins are not connected, the probe
takes about 10 seconds.

Introduce a config option to disable the probe on ddc channel 3.
Reduces boot time on my i815 laptop by 10 seconds.


diff -Naurp linux-2.6.15/drivers/video/Kconfig linux-2.6.15-b/drivers/video/Kconfig
--- linux-2.6.15/drivers/video/Kconfig	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-b/drivers/video/Kconfig	2006-01-25 08:02:54.772567000 +0100
@@ -728,6 +728,16 @@ config FB_I810_I2C
 	select I2C_ALGOBIT
 	help
 
+config FB_I810_I2C_NODDC3
+	bool "Disable probing on DDC3"
+	depends on FB_I810_I2C
+	default y
+	help
+	  Select this if you want to skip the probe of DDC3. On I810 where
+	  the DDC3 pins are not connected, probing will take a very long time,
+	  enabling this option will skip this probe altogether, shortening
+	  boot/module-load time by about 10 seconds.
+
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
 	depends on FB && EXPERIMENTAL && PCI && X86_32
diff -Naurp linux-2.6.15/drivers/video/i810/i810-i2c.c linux-2.6.15-b/drivers/video/i810/i810-i2c.c
--- linux-2.6.15/drivers/video/i810/i810-i2c.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15-b/drivers/video/i810/i810-i2c.c	2006-01-25 08:00:20.822567000 +0100
@@ -190,6 +190,11 @@ int i810_probe_i2c_connector(struct fb_i
         u8 *edid = NULL;
         int i;
 
+#ifdef CONFIG_FB_I810_I2C_NODDC3
+	if (conn == 3)
+		return 1;
+#endif
+
 	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn);
 	if (conn < 4) {
 		for (i = 0; i < 3; i++) {


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
