Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5443C43461
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79ECC6113D
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Apr 2021 14:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbhDPOU6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:20:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:57094 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244572AbhDPOU5 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Apr 2021 10:20:57 -0400
IronPort-SDR: Pcd2FiXgdEIu4fETzFWLpJVo7DhrtsrnCFlk8RahInBCajBWk1iWSYxQBkt8NCjA6qMXK/eajo
 5Xx+grbkncaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="174539407"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="174539407"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:20:32 -0700
IronPort-SDR: i8HAIRV/04OnOlv8pP6aUvzfhU1pfFZ1M3bJrCgT1N4m+EKDHH7AD/tgUEEEJvfgT999b6p9PU
 dpyi3S3xEESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425615126"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2021 07:20:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2391ABA; Fri, 16 Apr 2021 17:20:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jan=20Sebastian=20G=C3=B6tte?= <linux@jaseg.net>,
        Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v2 2/4] fbtft: Rectify GPIO handling
Date:   Fri, 16 Apr 2021 17:20:42 +0300
Message-Id: <20210416142044.17766-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
References: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The infamous commit c440eee1a7a1 ("Staging: fbtft: Switch to
the GPIO descriptor interface") broke GPIO handling completely.
It has already four commits to rectify and it seems not enough.
In order to fix the mess here we:

  1) Set default to "inactive" for all requested pins

  2) Fix CS, RD, and WR pins polarity since it's active low and
     GPIO descriptor interface takes it into consideration from
     the Device Tree or ACPI

  3) Consolidate chip activation (CS assert) under default
     ->reset() callback

To summarize the expectations about polarity for GPIOs:

   #RD			Low
   #WR			Low
   #CS			Low
   #RESET		Low
   DC or RS		High
   RW			High
   Data	0 .. 15		High

See also Adafruit learning course [1] for the example of the schematics.

While at it, drop unneeded NULL checks, since GPIO API is tolerant to that.

[1]: https://learn.adafruit.com/adafruit-2-8-and-3-2-color-tft-touchscreen-breakout-v2/downloads

Fixes: 92e3e884887c ("Staging: fbtft: Fix GPIO handling")
Fixes: b918d1c27066 ("Staging: fbtft: Fix reset assertion when using gpio descriptor")
Fixes: dbc4f989c878 ("Staging: fbtft: Fix probing of gpio descriptor")
Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")
Cc: Jan Sebastian Götte <linux@jaseg.net>
Cc: Phil Reid <preid@electromag.com.au>
Cc: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: shrunk by splitting some stuff to the separate changes (Greg)
 drivers/staging/fbtft/fb_agm1264k-fl.c | 16 ++++++++--------
 drivers/staging/fbtft/fb_bd663474.c    |  4 ----
 drivers/staging/fbtft/fb_ili9163.c     |  4 ----
 drivers/staging/fbtft/fb_ili9320.c     |  1 -
 drivers/staging/fbtft/fb_ili9325.c     |  4 ----
 drivers/staging/fbtft/fb_ili9340.c     |  1 -
 drivers/staging/fbtft/fb_s6d1121.c     |  4 ----
 drivers/staging/fbtft/fb_sh1106.c      |  1 -
 drivers/staging/fbtft/fb_ssd1289.c     |  4 ----
 drivers/staging/fbtft/fb_ssd1325.c     |  2 --
 drivers/staging/fbtft/fb_ssd1331.c     |  6 ++----
 drivers/staging/fbtft/fb_ssd1351.c     |  1 -
 drivers/staging/fbtft/fb_upd161704.c   |  4 ----
 drivers/staging/fbtft/fb_watterott.c   |  1 -
 drivers/staging/fbtft/fbtft-bus.c      |  3 +--
 drivers/staging/fbtft/fbtft-core.c     | 13 ++++++-------
 drivers/staging/fbtft/fbtft-io.c       | 12 ++++++------
 17 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index 4dfc22d05a40..207d578547cd 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -181,12 +181,12 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	/* select chip */
 	if (*buf) {
 		/* cs1 */
-		gpiod_set_value(par->CS0, 1);
-		gpiod_set_value(par->CS1, 0);
-	} else {
-		/* cs0 */
 		gpiod_set_value(par->CS0, 0);
 		gpiod_set_value(par->CS1, 1);
+	} else {
+		/* cs0 */
+		gpiod_set_value(par->CS0, 1);
+		gpiod_set_value(par->CS1, 0);
 	}
 
 	gpiod_set_value(par->RS, 0); /* RS->0 (command mode) */
@@ -384,8 +384,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	}
 	kfree(convert_buf);
 
-	gpiod_set_value(par->CS0, 1);
-	gpiod_set_value(par->CS1, 1);
+	gpiod_set_value(par->CS0, 0);
+	gpiod_set_value(par->CS1, 0);
 
 	return ret;
 }
@@ -406,10 +406,10 @@ static int write(struct fbtft_par *par, void *buf, size_t len)
 		for (i = 0; i < 8; ++i)
 			gpiod_set_value(par->gpio.db[i], data & (1 << i));
 		/* set E */
-		gpiod_set_value(par->EPIN, 1);
+		gpiod_set_value(par->EPIN, 0);
 		udelay(5);
 		/* unset E - write */
-		gpiod_set_value(par->EPIN, 0);
+		gpiod_set_value(par->EPIN, 1);
 		udelay(1);
 	}
 
diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index e2c7646588f8..1629c2c440a9 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -24,9 +23,6 @@
 
 static int init_display(struct fbtft_par *par)
 {
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	par->fbtftops.reset(par);
 
 	/* Initialization sequence from Lib_UTFT */
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index 05648c3ffe47..6582a2c90aaf 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
@@ -77,9 +76,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	write_reg(par, MIPI_DCS_SOFT_RESET); /* software reset */
 	mdelay(500);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE); /* exit sleep */
diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index f2e72d14431d..a8f4c618b754 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index c9aa4cb43123..16d3b17ca279 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -85,9 +84,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	bt &= 0x07;
 	vc &= 0x07;
 	vrh &= 0x0f;
diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/fb_ili9340.c
index 415183c7054a..704236bcaf3f 100644
--- a/drivers/staging/fbtft/fb_ili9340.c
+++ b/drivers/staging/fbtft/fb_ili9340.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <video/mipi_display.h>
 
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index 8c7de3290343..62f27172f844 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -29,9 +28,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	/* Initialization sequence from Lib_UTFT */
 
 	write_reg(par, 0x0011, 0x2004);
diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 6f7249493ea3..7b9ab39e1c1a 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index 7a3fe022cc69..f27bab38b3ec 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 
 #include "fbtft.h"
 
@@ -28,9 +27,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	write_reg(par, 0x00, 0x0001);
 	write_reg(par, 0x03, 0xA8A4);
 	write_reg(par, 0x0C, 0x0000);
diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/fb_ssd1325.c
index 8a3140d41d8b..796a2ac3e194 100644
--- a/drivers/staging/fbtft/fb_ssd1325.c
+++ b/drivers/staging/fbtft/fb_ssd1325.c
@@ -35,8 +35,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	gpiod_set_value(par->gpio.cs, 0);
-
 	write_reg(par, 0xb3);
 	write_reg(par, 0xf0);
 	write_reg(par, 0xae);
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index 37622c9462aa..ec5eced7f8cb 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -81,8 +81,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	va_start(args, len);
 
 	*buf = (u8)va_arg(args, unsigned int);
-	if (par->gpio.dc)
-		gpiod_set_value(par->gpio.dc, 0);
+	gpiod_set_value(par->gpio.dc, 0);
 	ret = par->fbtftops.write(par, par->buf, sizeof(u8));
 	if (ret < 0) {
 		va_end(args);
@@ -104,8 +103,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 			return;
 		}
 	}
-	if (par->gpio.dc)
-		gpiod_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 	va_end(args);
 }
 
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 900b28d826b2..cf263a58a148 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -2,7 +2,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c77832ae5e5b..c680160d6380 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
@@ -26,9 +25,6 @@ static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
 
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
-
 	/* Initialization sequence from Lib_UTFT */
 
 	/* register reset */
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 76b25df376b8..a57e1f4feef3 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67b17..3d422bc11641 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -135,8 +135,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
-	if (par->gpio.dc)
-		gpiod_set_value(par->gpio.dc, 1);
+	gpiod_set_value(par->gpio.dc, 1);
 
 	/* non buffered write */
 	if (!par->txbuf.buf)
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4f362dad4436..67c3b1975a4d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -38,8 +38,7 @@ int fbtft_write_buf_dc(struct fbtft_par *par, void *buf, size_t len, int dc)
 {
 	int ret;
 
-	if (par->gpio.dc)
-		gpiod_set_value(par->gpio.dc, dc);
+	gpiod_set_value(par->gpio.dc, dc);
 
 	ret = par->fbtftops.write(par, buf, len);
 	if (ret < 0)
@@ -79,7 +78,7 @@ static int fbtft_request_one_gpio(struct fbtft_par *par,
 	int ret = 0;
 
 	*gpiop = devm_gpiod_get_index_optional(dev, name, index,
-					       GPIOD_OUT_HIGH);
+					       GPIOD_OUT_LOW);
 	if (IS_ERR(*gpiop)) {
 		ret = PTR_ERR(*gpiop);
 		dev_err(dev,
@@ -226,11 +225,15 @@ static void fbtft_reset(struct fbtft_par *par)
 {
 	if (!par->gpio.reset)
 		return;
+
 	fbtft_par_dbg(DEBUG_RESET, par, "%s()\n", __func__);
+
 	gpiod_set_value_cansleep(par->gpio.reset, 1);
 	usleep_range(20, 40);
 	gpiod_set_value_cansleep(par->gpio.reset, 0);
 	msleep(120);
+
+	gpiod_set_value_cansleep(par->gpio.cs, 1);  /* Activate chip */
 }
 
 static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
@@ -922,8 +925,6 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 		goto out_free;
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	index = -1;
 	val = values[++index];
@@ -1018,8 +1019,6 @@ int fbtft_init_display(struct fbtft_par *par)
 	}
 
 	par->fbtftops.reset(par);
-	if (par->gpio.cs)
-		gpiod_set_value(par->gpio.cs, 0);  /* Activate chip */
 
 	i = 0;
 	while (i < FBTFT_MAX_INIT_SEQUENCE) {
diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index 0863d257d762..de1904a443c2 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -142,12 +142,12 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u8 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpiod_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 1);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 1); /* used as delay */
 		} else {
 			for (i = 0; i < 8; i++) {
 				if ((data & 1) != (prev_data & 1))
@@ -165,7 +165,7 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 #endif
 
 		/* Pullup /WR */
-		gpiod_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 0);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u8 *)buf;
@@ -192,12 +192,12 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 		data = *(u16 *)buf;
 
 		/* Start writing by pulling down /WR */
-		gpiod_set_value(par->gpio.wr, 0);
+		gpiod_set_value(par->gpio.wr, 1);
 
 		/* Set data */
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		if (data == prev_data) {
-			gpiod_set_value(par->gpio.wr, 0); /* used as delay */
+			gpiod_set_value(par->gpio.wr, 1); /* used as delay */
 		} else {
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
@@ -215,7 +215,7 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 #endif
 
 		/* Pullup /WR */
-		gpiod_set_value(par->gpio.wr, 1);
+		gpiod_set_value(par->gpio.wr, 0);
 
 #ifndef DO_NOT_OPTIMIZE_FBTFT_WRITE_GPIO
 		prev_data = *(u16 *)buf;
-- 
2.30.2

