From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] au1200fb: configurable number of planes
Date: Tue, 6 Feb 2007 13:39:23 +0100
Message-ID: <20070206123923.GA10337@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEPbg-00014d-2h for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 04:39:32 -0800
Received: from fnoeppeil48.netpark.at ([217.175.205.176]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEPbf-000837-BX
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 04:39:31 -0800
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sf.net

Hello,

I was trying to get a 1366x768 tft panel to work with au1200fb, and
discovered that memory allocation for the last 2 of the 4 fbdevs
created by au1200fb.c failed (one fb requires 2049kbytes, for which
dma_alloc_coherent()/get_free_pages() would try to get 4096kb).

This following patch makes the number of fbdevs to register 
configurable via a module parameter.

---

Introduce option to au1200fb to specify the number of fbdevs to create
at the commandline. This saves a lot of unused memory when the 3 additional 
planes are not required.
Also, memory requirements for large panels (e.g. 1366x768) are quite
high (~2MB per plane) and memory allocation for planes 2 and 3 may fail,
which unfortunately aborts driver installation.

Example:
video=au1200fb:panel:bs,devices:2

By default all 4 planes are created.


Signed-off-by:  Manuel Lauss  <mano@roarinelk.homelinux.net>


--- linux-2.6.20/drivers/video/au1200fb.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.20-work/drivers/video/au1200fb.c	2007-02-06 14:01:09.411742000 +0100
@@ -49,10 +49,6 @@
 #include <asm/mach-au1x00/au1xxx_pm.h>
 #endif
 
-#ifndef CONFIG_FB_AU1200_DEVS
-#define CONFIG_FB_AU1200_DEVS 4
-#endif
-
 #define DRIVER_NAME "au1200fb"
 #define DRIVER_DESC "LCD controller driver for AU1200 processors"
 
@@ -157,7 +153,7 @@ struct au1200fb_device {
 	dma_addr_t    		fb_phys;
 };
 
-static struct au1200fb_device _au1200fb_devices[CONFIG_FB_AU1200_DEVS];
+static struct au1200fb_device _au1200fb_devices[4];
 /********************************************************************/
 
 /* LCD controller restrictions */
@@ -173,6 +169,7 @@ static struct au1200fb_device _au1200fb_
 /********************************************************************/
 
 static struct au1200_lcd *lcd = (struct au1200_lcd *) AU1200_LCD_ADDR;
+static int device_count = 4;	/* number of fb devices to create */
 static int window_index = 2; /* default is zero */
 static int panel_index = 2; /* default is zero */
 static struct window_settings *win;
@@ -711,7 +812,7 @@ static int fbinfo2index (struct fb_info 
 {
 	int i;
 
-	for (i = 0; i < CONFIG_FB_AU1200_DEVS; ++i) {
+	for (i = 0; i < device_count; ++i) {
 		if (fb_info == (struct fb_info *)(&_au1200fb_devices[i].fb_info))
 			return i;
 	}
@@ -1632,7 +1733,7 @@ static int au1200fb_drv_probe(struct dev
 	if (!dev)
 		return -EINVAL;
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) {
+	for (plane = 0; plane < device_count; ++plane) {
 		bpp = winbpp(win->w[plane].mode_winctrl1);
 		if (win->w[plane].xres == 0)
 			win->w[plane].xres = panel->Xres;
@@ -1727,7 +1828,7 @@ static int au1200fb_drv_remove(struct de
 	/* Turn off the panel */
 	au1200_setpanel(NULL);
 
-	for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane)
+	for (plane = 0; plane < device_count; ++plane)
 	{
 		fbdev = &_au1200fb_devices[plane];
 
@@ -1779,7 +1880,7 @@ static struct device_driver au1200fb_dri
 static void au1200fb_setup(void)
 {
 	char* options = NULL;
-	char* this_opt;
+	char* this_opt, *endptr;
 	int num_panels = ARRAY_SIZE(known_lcd_panels);
 	int panel_idx = -1;
 
@@ -1792,7 +1893,6 @@ static void au1200fb_setup(void)
 			if (!strncmp(this_opt, "panel:", 6)) {
 				int i;
 				long int li;
-				char *endptr;
 				this_opt += 6;
 				/* First check for index, which allows
 				 * to short circuit this mess */
@@ -1824,6 +1924,12 @@ static void au1200fb_setup(void)
 				nohwcursor = 1;
 			}
 
+			else if (strncmp(this_opt, "devices:", 8) == 0) {
+				this_opt += 8;
+				device_count = simple_strtol(this_opt, &endptr, 0);
+				if ((device_count < 0) || (device_count > 4))
+					device_count = 4;	/* set default */
+			}
 			/* Unsupported option */
 			else {
 				print_warn("Unsupported option \"%s\"", this_opt);
@@ -1847,7 +1953,7 @@ static int au1200fb_pm_callback(au1xxx_p
 		{
 			int plane;
 			au1200_setpanel(panel);
-			for (plane = 0; plane < CONFIG_FB_AU1200_DEVS; ++plane) 	{
+			for (plane = 0; plane < device_count; ++plane) 	{
 				struct au1200fb_device *fbdev;
 				fbdev = &_au1200fb_devices[plane];
 				au1200fb_fb_set_par(&fbdev->fb_info);

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
