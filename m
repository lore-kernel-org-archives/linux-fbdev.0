From: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/5] various fbdev files: mark structs
	and array read-only
Date: Thu, 14 Sep 2006 22:01:34 +0200
Message-ID: <200609142201.34219.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eUbCFKvC3fppn8w"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNxXp-00076A-RB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Sep 2006 13:10:45 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GNxXm-0002js-WC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Sep 2006 13:10:45 -0700
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
To: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

--Boundary-00=_eUbCFKvC3fppn8w
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

- move some structs and arrays to the read-only (.rodata) section

Signed-off-by: Helge Deller <deller@gmx.de>

--Boundary-00=_eUbCFKvC3fppn8w
Content-Type: text/plain;
  charset="us-ascii";
  name="patch2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch2.diff"

- move some structs and arrays to the read-only (.rodata) section

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..f439a58 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -142,7 +142,7 @@ static struct class backlight_class = {
 	.store	= _store,					\
 }
 
-static struct class_device_attribute bl_class_device_attributes[] = {
+static const struct class_device_attribute bl_class_device_attributes[] = {
 	DECLARE_ATTR(power, 0644, backlight_show_power, backlight_store_power),
 	DECLARE_ATTR(brightness, 0644, backlight_show_brightness,
 		     backlight_store_brightness),
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index bc8ab00..58c37d4 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -121,7 +121,7 @@ static struct class lcd_class = {
 	.store	= _store,					\
 }
 
-static struct class_device_attribute lcd_class_device_attributes[] = {
+static const struct class_device_attribute lcd_class_device_attributes[] = {
 	DECLARE_ATTR(power, 0644, lcd_show_power, lcd_store_power),
 	DECLARE_ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast),
 	DECLARE_ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),


diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 4f78f23..f6cc623 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -451,7 +451,7 @@ static ssize_t show_bl_curve(struct clas
 /* When cmap is added back in it should be a binary attribute
  * not a text one. Consideration should also be given to converting
  * fbdev to use configfs instead of sysfs */
-static struct class_device_attribute class_device_attrs[] = {
+static const struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
 	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),



diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 45586aa..57b21e5 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -345,7 +345,7 @@ static void sticon_save_screen(struct vc
 {
 }
 
-static struct consw sti_con = {
+static const struct consw sti_con = {
 	.owner			= THIS_MODULE,
 	.con_startup		= sticon_startup,
 	.con_init		= sticon_init,


diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index de93139..6b385c3 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -58,7 +58,7 @@ struct broken_edid {
 	u32 fix;
 };
 
-static struct broken_edid brokendb[] = {
+static const struct broken_edid brokendb[] = {
 	/* DEC FR-PCXAV-YZ */
 	{
 		.manufacturer = "DEC",
diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index b549899..0847c5e 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -57,7 +57,7 @@ struct fb_cvt_data {
 	u32 status;
 };
 
-static int fb_cvt_vbi_tab[] = {
+static const unsigned char fb_cvt_vbi_tab[] = {
 	4,        /* 4:3      */
 	5,        /* 16:9     */
 	6,        /* 16:10    */
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 51d3538..2610044 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -42,7 +42,7 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-static u32 cfb_tab8[] = {
+static const u32 cfb_tab8[] = {
 #if defined(__BIG_ENDIAN)
     0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
     0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
@@ -58,7 +58,7 @@ static u32 cfb_tab8[] = {
 #endif
 };
 
-static u32 cfb_tab16[] = {
+static const u32 cfb_tab16[] = {
 #if defined(__BIG_ENDIAN)
     0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
 #elif defined(__LITTLE_ENDIAN)
@@ -68,7 +68,7 @@ static u32 cfb_tab16[] = {
 #endif
 };
 
-static u32 cfb_tab32[] = {
+static const u32 cfb_tab32[] = {
 	0x00000000, 0xffffffff
 };
 
@@ -218,7 +218,7 @@ static inline void fast_imageblit(const 
 	u32 bit_mask, end_mask, eorx, shift;
 	const char *s = image->data, *src;
 	u32 __iomem *dst;
-	u32 *tab = NULL;
+	const u32 *tab = NULL;
 	int i, j, k;
 		
 	switch (bpp) {





--Boundary-00=_eUbCFKvC3fppn8w
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_eUbCFKvC3fppn8w
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Boundary-00=_eUbCFKvC3fppn8w--
