From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 5/8] lcd: add corgibl_limit_intensity()
	to corgi_lcd
Date: Fri, 29 Aug 2008 15:28:20 +0800
Message-ID: <f17812d70808290028x785161f4m907d20e876cafe0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYyP7-0001C2-WD for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:28:22 -0700
Received: from yw-out-1718.google.com ([74.125.46.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYyP7-0003Gt-KY
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 Aug 2008 00:28:21 -0700
Received: by yw-out-1718.google.com with SMTP id 6so54634ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 29 Aug 2008 00:28:21 -0700 (PDT)
Content-Disposition: inline
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
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-fbdev-devel@lists.sourceforge.net

This is not generic enough, added here for backward compatibility.
And make this an individual commit so future revert will be a bit
easier.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/video/backlight/corgi_lcd.c |   27 +++++++++++++++++++++++++++
 include/linux/spi/corgi_lcd.h       |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/corgi_lcd.c
b/drivers/video/backlight/corgi_lcd.c
index bf69e50..068f148 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -86,6 +86,7 @@ struct corgi_lcd {
 	struct lcd_device	*lcd_dev;
 	struct backlight_device	*bl_dev;

+	int	limit_mask;
 	int	intensity;
 	int	power;
 	int	mode;
@@ -97,6 +98,11 @@ struct corgi_lcd {

 static int corgi_ssp_lcdtg_send(struct corgi_lcd *lcd, int reg, uint8_t val);

+static struct corgi_lcd *the_corgi_lcd;
+static unsigned long corgibl_flags;
+#define CORGIBL_SUSPENDED     0x01
+#define CORGIBL_BATTLOW       0x02
+
 /*
  * This is only a psuedo I2C interface. We can't use the standard kernel
  * routines as the interface is write only. We just assume the data is acked...
@@ -413,9 +419,25 @@ static int corgi_bl_update_status(struct
backlight_device *bd)
 	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
 		intensity = 0;

+	if (corgibl_flags & CORGIBL_SUSPENDED)
+		intensity = 0;
+	if (corgibl_flags & CORGIBL_BATTLOW)
+		intensity &= lcd->limit_mask;
+
 	return corgi_bl_set_intensity(lcd, intensity);
 }

+void corgibl_limit_intensity(int limit)
+{
+	if (limit)
+		corgibl_flags |= CORGIBL_BATTLOW;
+	else
+		corgibl_flags &= ~CORGIBL_BATTLOW;
+
+	backlight_update_status(the_corgi_lcd->bl_dev);
+}
+EXPORT_SYMBOL(corgibl_limit_intensity);
+
 static struct backlight_ops corgi_bl_ops = {
 	.get_brightness	= corgi_bl_get_intensity,
 	.update_status  = corgi_bl_update_status,
@@ -426,6 +448,7 @@ static int corgi_lcd_suspend(struct spi_device
*spi, pm_message_t state)
 {
 	struct corgi_lcd *lcd = dev_get_drvdata(&spi->dev);

+	corgibl_flags |= CORGIBL_SUSPENDED;
 	corgi_bl_set_intensity(lcd, 0);
 	corgi_lcd_set_power(lcd->lcd_dev, FB_BLANK_POWERDOWN);
 	return 0;
@@ -435,6 +458,7 @@ static int corgi_lcd_resume(struct spi_device *spi)
 {
 	struct corgi_lcd *lcd = dev_get_drvdata(&spi->dev);

+	corgibl_flags &= ~CORGIBL_SUSPENDED;
 	corgi_lcd_set_power(lcd->lcd_dev, FB_BLANK_UNBLANK);
 	backlight_update_status(lcd->bl_dev);
 	return 0;
@@ -488,6 +512,9 @@ static int __devinit corgi_lcd_probe(struct spi_device *spi)
 	dev_set_drvdata(&spi->dev, lcd);
 	corgi_lcd_set_power(lcd->lcd_dev, FB_BLANK_UNBLANK);
 	backlight_update_status(lcd->bl_dev);
+
+	lcd->limit_mask = pdata->limit_mask;
+	the_corgi_lcd = lcd;
 	return 0;

 err_unregister_lcd:
diff --git a/include/linux/spi/corgi_lcd.h b/include/linux/spi/corgi_lcd.h
index 3c53ac2..b6161aa 100644
--- a/include/linux/spi/corgi_lcd.h
+++ b/include/linux/spi/corgi_lcd.h
@@ -8,6 +8,7 @@ struct corgi_lcd_platform_data {
 	int	init_mode;
 	int	max_intensity;
 	int	default_intensity;
+	int	limit_mask;

 	void (*notify)(int intensity);
 	void (*kick_battery)(void);
-- 
1.5.4.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
