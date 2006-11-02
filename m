From: akpm@osdl.org
Subject: [patch 07/25] various fbdev files: mark structs
	and array read-only
Date: Wed, 01 Nov 2006 21:50:22 -0800
Message-ID: <200611020550.kA25oMgF002300@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTD-0007Xx-J0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:31 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTD-0007Bt-6i
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:31 -0800
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
Cc: akpm@osdl.org, deller@gmx.de

From: Helge Deller <deller@gmx.de>

- move some structs and arrays to the read-only (.rodata) section

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/backlight/backlight.c |    2 +-
 drivers/video/backlight/lcd.c       |    2 +-
 drivers/video/cfbimgblt.c           |    8 ++++----
 drivers/video/console/sticon.c      |    2 +-
 drivers/video/fbcvt.c               |    2 +-
 drivers/video/fbmon.c               |    2 +-
 drivers/video/fbsysfs.c             |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/video/backlight/backlight.c~various-fbdev-files-mark-structs drivers/video/backlight/backlight.c
--- a/drivers/video/backlight/backlight.c~various-fbdev-files-mark-structs
+++ a/drivers/video/backlight/backlight.c
@@ -142,7 +142,7 @@ static struct class backlight_class = {
 	.store	= _store,					\
 }
 
-static struct class_device_attribute bl_class_device_attributes[] = {
+static const struct class_device_attribute bl_class_device_attributes[] = {
 	DECLARE_ATTR(power, 0644, backlight_show_power, backlight_store_power),
 	DECLARE_ATTR(brightness, 0644, backlight_show_brightness,
 		     backlight_store_brightness),
diff -puN drivers/video/backlight/lcd.c~various-fbdev-files-mark-structs drivers/video/backlight/lcd.c
--- a/drivers/video/backlight/lcd.c~various-fbdev-files-mark-structs
+++ a/drivers/video/backlight/lcd.c
@@ -121,7 +121,7 @@ static struct class lcd_class = {
 	.store	= _store,					\
 }
 
-static struct class_device_attribute lcd_class_device_attributes[] = {
+static const struct class_device_attribute lcd_class_device_attributes[] = {
 	DECLARE_ATTR(power, 0644, lcd_show_power, lcd_store_power),
 	DECLARE_ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast),
 	DECLARE_ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),
diff -puN drivers/video/cfbimgblt.c~various-fbdev-files-mark-structs drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c~various-fbdev-files-mark-structs
+++ a/drivers/video/cfbimgblt.c
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
diff -puN drivers/video/console/sticon.c~various-fbdev-files-mark-structs drivers/video/console/sticon.c
--- a/drivers/video/console/sticon.c~various-fbdev-files-mark-structs
+++ a/drivers/video/console/sticon.c
@@ -345,7 +345,7 @@ static void sticon_save_screen(struct vc
 {
 }
 
-static struct consw sti_con = {
+static const struct consw sti_con = {
 	.owner			= THIS_MODULE,
 	.con_startup		= sticon_startup,
 	.con_init		= sticon_init,
diff -puN drivers/video/fbcvt.c~various-fbdev-files-mark-structs drivers/video/fbcvt.c
--- a/drivers/video/fbcvt.c~various-fbdev-files-mark-structs
+++ a/drivers/video/fbcvt.c
@@ -57,7 +57,7 @@ struct fb_cvt_data {
 	u32 status;
 };
 
-static int fb_cvt_vbi_tab[] = {
+static const unsigned char fb_cvt_vbi_tab[] = {
 	4,        /* 4:3      */
 	5,        /* 16:9     */
 	6,        /* 16:10    */
diff -puN drivers/video/fbmon.c~various-fbdev-files-mark-structs drivers/video/fbmon.c
--- a/drivers/video/fbmon.c~various-fbdev-files-mark-structs
+++ a/drivers/video/fbmon.c
@@ -58,7 +58,7 @@ struct broken_edid {
 	u32 fix;
 };
 
-static struct broken_edid brokendb[] = {
+static const struct broken_edid brokendb[] = {
 	/* DEC FR-PCXAV-YZ */
 	{
 		.manufacturer = "DEC",
diff -puN drivers/video/fbsysfs.c~various-fbdev-files-mark-structs drivers/video/fbsysfs.c
--- a/drivers/video/fbsysfs.c~various-fbdev-files-mark-structs
+++ a/drivers/video/fbsysfs.c
@@ -487,7 +487,7 @@ static ssize_t show_bl_curve(struct devi
 /* When cmap is added back in it should be a binary attribute
  * not a text one. Consideration should also be given to converting
  * fbdev to use configfs instead of sysfs */
-static struct device_attribute device_attrs[] = {
+static const struct device_attribute device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
 	__ATTR(console, S_IRUGO|S_IWUSR, show_console, store_console),
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
