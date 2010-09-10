From: Donghwa Lee <dh09.lee@samsung.com>
Date: Fri, 10 Sep 2010 00:45:51 +0000
Subject: [PATCH V2] drivers: lcd: Add support ld9040 amoled panel driver
Message-Id: <1284079551-9881-1-git-send-email-dh09.lee@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch is ld9040 amoled panel driver version2.
It is similar to s6e63m0 panel driver and use spi gpio
to send panel information.

Original prefix of this patch was "s3c-fb", but it is modified
to "drivers: lcd:". And wrong defined Makefile option was corrected.

Thank you for your review.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
---
 drivers/video/backlight/Kconfig  |    7 +
 drivers/video/backlight/Makefile |    1 +
 drivers/video/backlight/ld9040.c |  687 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 695 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/backlight/ld9040.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index e54a337..b8381d0 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -109,6 +109,13 @@ config LCD_S6E63M0
 	  If you have an S6E63M0 LCD Panel, say Y to enable its
 	  LCD control driver.
 
+config LCD_LD9040
+	bool "LD9040 AMOLED LCD Driver"
+	depends on SPI && BACKLIGHT_CLASS_DEVICE
+	help
+	  If you have an LD9040 LCD Panel, say Y to enable its
+	  LCD control driver.
+
 endif # LCD_CLASS_DEVICE
 
 #
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 44c0f81..a52248e 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_LCD_VGG2432A4)	   += vgg2432a4.o
 obj-$(CONFIG_LCD_TDO24M)	   += tdo24m.o
 obj-$(CONFIG_LCD_TOSA)		   += tosa_lcd.o
 obj-$(CONFIG_LCD_S6E63M0)	+= s6e63m0.o
+obj-$(CONFIG_LCD_LD9040)	+= ld9040.o
 
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_ATMEL_PWM)    += atmel-pwm-bl.o
diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
new file mode 100644
index 0000000..7a2109f
--- /dev/null
+++ b/drivers/video/backlight/ld9040.c
@@ -0,0 +1,687 @@
+/*
+ * ld9040 AMOLED LCD panel driver.
+ *
+ * Author: Donghwa Lee  <dh09.lee@samsung.com>
+ *
+ * Derived from drivers/video/omap/lcd-apollon.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/wait.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/lcd.h>
+#include <linux/backlight.h>
+
+#define SLEEPMSEC		0x1000
+#define ENDDEF			0x2000
+#define	DEFMASK			0xFF00
+#define COMMAND_ONLY		0xFE
+#define DATA_ONLY		0xFF
+
+#define POWER_IS_ON(pwr)	((pwr) <= FB_BLANK_NORMAL)
+
+struct ld9040 {
+	struct device			*dev;
+	struct spi_device		*spi;
+	unsigned int			power;
+	struct lcd_device		*ld;
+	struct lcd_platform_data	*lcd_pd;
+};
+
+static const unsigned short SEQ_SWRESET[] = {
+	0x01, COMMAND_ONLY,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_USER_SETTING[] = {
+	0xF0, 0x5A,
+
+	DATA_ONLY, 0x5A,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_ELVSS[] = {
+	0xB1, 0x0B,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x16,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_GTCON[] = {
+	0xF7, 0x09,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_GAMMA_SET1[] = {
+	0xF9, 0x18,
+
+	DATA_ONLY, 0x9A,
+	DATA_ONLY, 0xB0,
+	DATA_ONLY, 0xAB,
+	DATA_ONLY, 0xC4,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0xAA,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0xA1,
+	DATA_ONLY, 0xB5,
+	DATA_ONLY, 0xB0,
+	DATA_ONLY, 0xC7,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0xC5,
+	DATA_ONLY, 0x24,
+	DATA_ONLY, 0xA7,
+	DATA_ONLY, 0xAC,
+	DATA_ONLY, 0x9A,
+	DATA_ONLY, 0xB6,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0xE5,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_GAMMA_CTRL[] = {
+	0xFB, 0x00,
+
+	DATA_ONLY, 0x5A,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_APON[] = {
+	0xF3, 0x00,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x0A,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_DISPCTL[] = {
+	0xF2, 0x02,
+
+	DATA_ONLY, 0x03,
+	DATA_ONLY, 0x1C,
+	DATA_ONLY, 0x10,
+	DATA_ONLY, 0x10,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_SLPOUT[] = {
+	0x11, COMMAND_ONLY,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_SLPIN[] = {
+	0x10, COMMAND_ONLY,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_DISPON[] = {
+	0x29, COMMAND_ONLY,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_DISPOFF[] = {
+	0x28, COMMAND_ONLY,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VCI1_1ST_EN[] = {
+	0xF3, 0x10,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VL1_EN[] = {
+	0xF3, 0x11,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VL2_EN[] = {
+	0xF3, 0x13,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VCI1_2ND_EN[] = {
+	0xF3, 0x33,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VL3_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VREG1_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0x01,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VGH_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0x11,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VGL_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0x31,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x02,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VMOS_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xB1,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VINT_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xF1,
+	/* DATA_ONLY, 0x71,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VBH_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xF9,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_VBL_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFD,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_GAM_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFF,
+	/* DATA_ONLY, 0x73,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_SD_AMP_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFF,
+	/* DATA_ONLY, 0x73,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x80,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_GLS_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFF,
+	/* DATA_ONLY, 0x73,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x81,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_ELS_EN[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFF,
+	/* DATA_ONLY, 0x73,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x83,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static const unsigned short SEQ_EL_ON[] = {
+	0xF3, 0x37,
+
+	DATA_ONLY, 0xFF,
+	/* DATA_ONLY, 0x73,	VMOS/VBL/VBH not used */
+	DATA_ONLY, 0x87,
+	DATA_ONLY, 0x00,
+	DATA_ONLY, 0x03,
+	/* DATA_ONLY, 0x02,	VMOS/VBL/VBH not used */
+	ENDDEF, 0x00
+};
+
+static int ld9040_spi_write_byte(struct ld9040 *lcd, int addr, int data)
+{
+	u16 buf[1];
+	struct spi_message msg;
+
+	struct spi_transfer xfer = {
+		.len		= 2,
+		.tx_buf		= buf,
+	};
+
+	buf[0] = (addr << 8) | data;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	return spi_sync(lcd->spi, &msg);
+}
+
+static int ld9040_spi_write(struct ld9040 *lcd, unsigned char address,
+	unsigned char command)
+{
+	int ret = 0;
+
+	if (address != DATA_ONLY)
+		ret = ld9040_spi_write_byte(lcd, 0x0, address);
+	if (command != COMMAND_ONLY)
+		ret = ld9040_spi_write_byte(lcd, 0x1, command);
+
+	return ret;
+}
+
+static int ld9040_panel_send_sequence(struct ld9040 *lcd,
+	const unsigned short *wbuf)
+{
+	int ret = 0, i = 0;
+
+	while ((wbuf[i] & DEFMASK) != ENDDEF) {
+		if ((wbuf[i] & DEFMASK) != SLEEPMSEC) {
+			ret = ld9040_spi_write(lcd, wbuf[i], wbuf[i+1]);
+			if (ret)
+				break;
+		} else
+			udelay(wbuf[i+1]*1000);
+		i += 2;
+	}
+
+	return ret;
+}
+
+static int ld9040_ldi_init(struct ld9040 *lcd)
+{
+	int ret, i;
+	const unsigned short *init_seq[] = {
+		SEQ_USER_SETTING,
+		SEQ_ELVSS,
+		SEQ_GTCON,
+		SEQ_GAMMA_SET1,
+		SEQ_GAMMA_CTRL,
+		SEQ_SLPOUT,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
+		ret = ld9040_panel_send_sequence(lcd, init_seq[i]);
+		mdelay(5);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int ld9040_ldi_enable(struct ld9040 *lcd)
+{
+	int ret = 0;
+
+	ret = ld9040_panel_send_sequence(lcd, SEQ_DISPON);
+
+	return ret;
+}
+
+static int ld9040_ldi_disable(struct ld9040 *lcd)
+{
+	int ret;
+
+	ret = ld9040_panel_send_sequence(lcd, SEQ_DISPOFF);
+
+	return ret;
+}
+
+static int ld9040_power_on(struct ld9040 *lcd)
+{
+	int ret = 0;
+	struct lcd_platform_data *pd = NULL;
+	pd = lcd->lcd_pd;
+	if (!pd) {
+		dev_err(lcd->dev, "platform data is NULL.\n");
+		return -EFAULT;
+	}
+
+	if (!pd->power_on) {
+		dev_err(lcd->dev, "power_on is NULL.\n");
+		return -EFAULT;
+	} else {
+		pd->power_on(lcd->ld, 1);
+		mdelay(pd->power_on_delay);
+	}
+
+	if (!pd->reset) {
+		dev_err(lcd->dev, "reset is NULL.\n");
+		return -EFAULT;
+	} else {
+		pd->reset(lcd->ld);
+		mdelay(pd->reset_delay);
+	}
+
+	ret = ld9040_ldi_init(lcd);
+	if (ret) {
+		dev_err(lcd->dev, "failed to initialize ldi.\n");
+		return ret;
+	}
+
+	ret = ld9040_ldi_enable(lcd);
+	if (ret) {
+		dev_err(lcd->dev, "failed to enable ldi.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ld9040_power_off(struct ld9040 *lcd)
+{
+	int ret = 0;
+	struct lcd_platform_data *pd = NULL;
+
+	pd = lcd->lcd_pd;
+	if (!pd) {
+		dev_err(lcd->dev, "platform data is NULL.\n");
+		return -EFAULT;
+	}
+
+	ret = ld9040_ldi_disable(lcd);
+	if (ret) {
+		dev_err(lcd->dev, "lcd setting failed.\n");
+		return -EIO;
+	}
+
+	mdelay(pd->power_off_delay);
+
+	if (!pd->power_on) {
+		dev_err(lcd->dev, "power_on is NULL.\n");
+		return -EFAULT;
+	} else
+		pd->power_on(lcd->ld, 0);
+
+	return 0;
+}
+
+static int ld9040_power(struct ld9040 *lcd, int power)
+{
+	int ret = 0;
+
+	if (POWER_IS_ON(power) && !POWER_IS_ON(lcd->power))
+		ret = ld9040_power_on(lcd);
+	else if (!POWER_IS_ON(power) && POWER_IS_ON(lcd->power))
+		ret = ld9040_power_off(lcd);
+
+	if (!ret)
+		lcd->power = power;
+
+	return ret;
+}
+
+static int ld9040_set_power(struct lcd_device *ld, int power)
+{
+	struct ld9040 *lcd = lcd_get_data(ld);
+
+	if (power != FB_BLANK_UNBLANK && power != FB_BLANK_POWERDOWN &&
+		power != FB_BLANK_NORMAL) {
+		dev_err(lcd->dev, "power value should be 0, 1 or 4.\n");
+		return -EINVAL;
+	}
+
+	return ld9040_power(lcd, power);
+}
+
+static int ld9040_get_power(struct lcd_device *ld)
+{
+	struct ld9040 *lcd = lcd_get_data(ld);
+
+	return lcd->power;
+}
+
+static struct lcd_ops ld9040_lcd_ops = {
+	.set_power = ld9040_set_power,
+	.get_power = ld9040_get_power,
+};
+
+
+static int __init ld9040_probe(struct spi_device *spi)
+{
+	int ret = 0;
+	struct ld9040 *lcd = NULL;
+	struct lcd_device *ld = NULL;
+
+	lcd = kzalloc(sizeof(struct ld9040), GFP_KERNEL);
+	if (!lcd)
+		return -ENOMEM;
+
+	/* ld9040 lcd panel uses 3-wire 9bits SPI Mode. */
+	spi->bits_per_word = 9;
+
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi setup failed.\n");
+		goto out_free_lcd;
+	}
+
+	lcd->spi = spi;
+	lcd->dev = &spi->dev;
+
+	lcd->lcd_pd = (struct lcd_platform_data *)spi->dev.platform_data;
+	if (!lcd->lcd_pd) {
+		dev_err(&spi->dev, "platform data is NULL.\n");
+		goto out_free_lcd;
+	}
+
+	ld = lcd_device_register("ld9040", &spi->dev, lcd, &ld9040_lcd_ops);
+	if (IS_ERR(ld)) {
+		ret = PTR_ERR(ld);
+		goto out_free_lcd;
+	}
+
+	lcd->ld = ld;
+
+	/*
+	 * if lcd panel was on from bootloader like u-boot then
+	 * do not lcd on.
+	 */
+	if (!lcd->lcd_pd->lcd_enabled) {
+		/*
+		 * if lcd panel was off from bootloader then
+		 * current lcd status is powerdown and then
+		 * it enables lcd panel.
+		 */
+		lcd->power = FB_BLANK_POWERDOWN;
+
+		ld9040_power(lcd, FB_BLANK_UNBLANK);
+	} else
+		lcd->power = FB_BLANK_UNBLANK;
+
+	dev_set_drvdata(&spi->dev, lcd);
+
+	dev_info(&spi->dev, "ld9040 panel driver has been probed.\n");
+	return 0;
+
+out_free_lcd:
+	kfree(lcd);
+	return ret;
+}
+
+static int __devexit ld9040_remove(struct spi_device *spi)
+{
+	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
+
+	ld9040_power(lcd, FB_BLANK_POWERDOWN);
+	lcd_device_unregister(lcd->ld);
+	kfree(lcd);
+
+	return 0;
+}
+
+#if defined(CONFIG_PM)
+unsigned int beforepower;
+
+static int ld9040_suspend(struct spi_device *spi, pm_message_t mesg)
+{
+	int ret = 0;
+	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
+
+	dev_dbg(&spi->dev, "lcd->power = %d\n", lcd->power);
+
+	beforepower = lcd->power;
+
+	/*
+	 * when lcd panel is suspend, lcd panel becomes off
+	 * regardless of status.
+	 */
+	ret = ld9040_power(lcd, FB_BLANK_POWERDOWN);
+
+	return ret;
+}
+
+static int ld9040_resume(struct spi_device *spi)
+{
+	int ret = 0;
+	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
+
+	/*
+	 * after suspended, if lcd panel status is FB_BLANK_UNBLANK
+	 * (at that time, power is FB_BLANK_UNBLANK) then
+	 * it changes that status to FB_BLANK_POWERDOWN to get lcd on.
+	 */
+	if (beforepower = FB_BLANK_UNBLANK)
+		lcd->power = FB_BLANK_POWERDOWN;
+
+	dev_dbg(&spi->dev, "power = %d\n", beforepower);
+
+	ret = ld9040_power(lcd, beforepower);
+
+	return ret;
+}
+#else
+#define ld9040_suspend		NULL
+#define ld9040_resume		NULL
+#endif
+
+/* Power down all displays on reboot, poweroff or halt. */
+static void ld9040_shutdown(struct spi_device *spi)
+{
+	struct ld9040 *lcd = dev_get_drvdata(&spi->dev);
+
+	ld9040_power(lcd, FB_BLANK_POWERDOWN);
+}
+
+static struct spi_driver ld9040_driver = {
+	.driver = {
+		.name	= "ld9040",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ld9040_probe,
+	.remove		= __devexit_p(ld9040_remove),
+	.shutdown	= ld9040_shutdown,
+	.suspend	= ld9040_suspend,
+	.resume		= ld9040_resume,
+};
+
+static int __init ld9040_init(void)
+{
+	return spi_register_driver(&ld9040_driver);
+}
+
+static void __exit ld9040_exit(void)
+{
+	spi_unregister_driver(&ld9040_driver);
+}
+
+module_init(ld9040_init);
+module_exit(ld9040_exit);
+
+MODULE_AUTHOR("Donghwa Lee <dh09.lee@samsung.com>");
+MODULE_DESCRIPTION("ld9040 LCD Driver");
+MODULE_LICENSE("GPL");
+
-- 
1.6.0.4

