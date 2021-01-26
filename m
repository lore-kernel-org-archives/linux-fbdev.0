Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699CC43332
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 12:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B7D2312B
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 12:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbhAZMlV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbhAZMlR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 07:41:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3621C0611C2;
        Tue, 26 Jan 2021 04:40:36 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d4so9713145plh.5;
        Tue, 26 Jan 2021 04:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HqB8ShkPpKgbh75SDLmBozCvKjDXfCshAB9pnex5YAo=;
        b=YkC3a2VqMxRZZEAHB/LFJ8jMLKJ0RQ84lldRRwm0DU4oV3geCKNpczFFy04WEh3rzJ
         hbjBpFzDslzkqfsBTnn8U2oLJfBRfRBx0C9ozt6BQYRtgQGeA2SA+WortjTUKSimsaOt
         IbQggQ2JLQ/jcHzFWyJ6mvB1qcxXlGmijvOqULkMxiieAjWgsiZh4Ouw208IFWf7wIPp
         TXSlDSKLcqEZaGkguWIz4aIS1hRsoBPW6Z6X1nN7ni+4BrGynWQl7PhAP/tBspkPKkQE
         4iQEoXhuo45rioNtt0iScbWzw8+hIwAPcJqaYZAV6MODtDxpPTbPTaHIaWsBi2y9qkpP
         QqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HqB8ShkPpKgbh75SDLmBozCvKjDXfCshAB9pnex5YAo=;
        b=SgI20u5dkEA4/hRx9XFHzwV9a7kgQb4k1P6ANVRxm1fXNZNe02wyCzIToywmL4ZG0M
         pf7BhG2kJk1eVtBIOswfdFw1EIYQ+86IMU7Oa5VHmmkpXGJeveAOuVZS0+r1jq/1UkJg
         RtNsFFZi3uizYLjAnRfzMz6nZ3CWGhbl/ghqeyxregxsVUtaK0IZi+ucrN4Wwc/1qqCb
         YVkONZeSYDN8fu7Wn5LBnJGy0R7LrarwGfqqebv4GG7IcQixPSkWGaYVeh7cQ+yUxxO1
         NPsMtb813MNKeB9VH7/R7f11K5P6zCe0TM5y+LucIgMj+IrTUaMPxH/3ZANmPVqFxvp8
         jF9Q==
X-Gm-Message-State: AOAM530lTCIZsfPgiGCr04h5QVp5angI/T8L2WRidwpcQbnn/50QUQcz
        h//htqR6c6MGjw2sG8i+aPg=
X-Google-Smtp-Source: ABdhPJxNn0PzimxAkurriDPiQqgEE1O9MMOJxN32hirkqygEYr56tU4+ndfSpn/mmwNfYX4NiydL9w==
X-Received: by 2002:a17:902:ed11:b029:de:2f19:4db1 with SMTP id b17-20020a170902ed11b02900de2f194db1mr5891927pld.20.1611664836233;
        Tue, 26 Jan 2021 04:40:36 -0800 (PST)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c185sm4987427pfb.178.2021.01.26.04.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 04:40:35 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     colin.king@canonical.com, oliver.graute@kococonnector.com,
        zhangxuezhi1@yulong.com, mh12gx2825@gmail.com, sbrivio@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] fbtft: add tearing signal detect
Date:   Tue, 26 Jan 2021 20:40:35 +0800
Message-Id: <1611664835-150687-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: zhangxuezhi <zhangxuezhi1@yulong.com>

For st7789v ic,add tearing signal detect to avoid screen tearing

Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
---
v4:modify some code style and change te irq set function name
---
 drivers/staging/fbtft/fb_st7789v.c | 128 ++++++++++++++++++++++++++++++++++++-
 drivers/staging/fbtft/fbtft.h      |   1 +
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3a280cc..11a490de 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -9,9 +9,12 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/module.h>
 #include <video/mipi_display.h>
-
+#include <linux/gpio/consumer.h>
 #include "fbtft.h"
 
 #define DRVNAME "fb_st7789v"
@@ -66,6 +69,32 @@ enum st7789v_command {
 #define MADCTL_MX BIT(6) /* bitmask for column address order */
 #define MADCTL_MY BIT(7) /* bitmask for page address order */
 
+#define SPI_PANEL_TE_TIMEOUT	400
+static struct mutex te_mutex;/*mutex for tearing line*/
+static struct completion spi_panel_te;
+
+static irqreturn_t spi_panel_te_handler(int irq, void *data)
+{
+	complete(&spi_panel_te);
+	return IRQ_HANDLED;
+}
+
+static void set_spi_panel_te_irq_status(struct fbtft_par *par, bool enable)
+{
+	static int te_irq_count;
+
+	mutex_lock(&te_mutex);
+
+	if (enable) {
+		if (++te_irq_count == 1)
+			enable_irq(gpiod_to_irq(par->gpio.te));
+	} else {
+		if (--te_irq_count == 0)
+			disable_irq(gpiod_to_irq(par->gpio.te));
+	}
+	mutex_unlock(&te_mutex);
+}
+
 /**
  * init_display() - initialize the display controller
  *
@@ -82,6 +111,29 @@ enum st7789v_command {
  */
 static int init_display(struct fbtft_par *par)
 {
+	int rc;
+	struct device *dev = par->info->device;
+
+	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0, GPIOD_IN);
+	if (par->gpio.te) {
+		init_completion(&spi_panel_te);
+		mutex_init(&te_mutex);
+		rc = devm_request_irq(dev,
+				      gpiod_to_irq(par->gpio.te),
+				     spi_panel_te_handler, IRQF_TRIGGER_RISING,
+				     "TE_GPIO", par);
+		if (rc) {
+			pr_err("TE request_irq failed.\n");
+			devm_gpiod_put(dev, par->gpio.te);
+			par->gpio.te = NULL;
+		} else {
+			disable_irq_nosync(gpiod_to_irq(par->gpio.te));
+			pr_info("TE request_irq completion.\n");
+		}
+	} else {
+		pr_err("%s:%d, TE gpio not specified\n",
+		       __func__, __LINE__);
+	}
 	/* turn off sleep mode */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	mdelay(120);
@@ -137,6 +189,9 @@ static int init_display(struct fbtft_par *par)
 	 */
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
+    /*Tearing Effect Line On*/
+	if (par->gpio.te)
+		write_reg(par, 0x35, 0x00);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	if (HSD20_IPS)
@@ -145,6 +200,76 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
 
+/*****************************************************************************
+ *
+ *   int (*write_vmem)(struct fbtft_par *par);
+ *
+ *****************************************************************************/
+
+/* 16 bit pixel over 8-bit databus */
+int st7789v_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
+{
+	u16 *vmem16;
+	__be16 *txbuf16 = par->txbuf.buf;
+	size_t remain;
+	size_t to_copy;
+	size_t tx_array_size;
+	int i;
+	int ret = 0;
+	size_t startbyte_size = 0;
+
+	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "st7789v ---%s(offset=%zu, len=%zu)\n",
+		      __func__, offset, len);
+
+	remain = len / 2;
+	vmem16 = (u16 *)(par->info->screen_buffer + offset);
+
+	if (par->gpio.dc)
+		gpiod_set_value(par->gpio.dc, 1);
+
+	/* non buffered write */
+	if (!par->txbuf.buf)
+		return par->fbtftops.write(par, vmem16, len);
+
+	/* buffered write */
+	tx_array_size = par->txbuf.len / 2;
+
+	if (par->startbyte) {
+		txbuf16 = par->txbuf.buf + 1;
+		tx_array_size -= 2;
+		*(u8 *)(par->txbuf.buf) = par->startbyte | 0x2;
+		startbyte_size = 1;
+	}
+
+	while (remain) {
+		to_copy = min(tx_array_size, remain);
+		dev_dbg(par->info->device, "    to_copy=%zu, remain=%zu\n",
+			to_copy, remain - to_copy);
+
+		for (i = 0; i < to_copy; i++)
+			txbuf16[i] = cpu_to_be16(vmem16[i]);
+
+		vmem16 = vmem16 + to_copy;
+		if (par->gpio.te) {
+			set_spi_panel_te_irq_status(par, true);
+			reinit_completion(&spi_panel_te);
+			ret = wait_for_completion_timeout(&spi_panel_te,
+							  msecs_to_jiffies(SPI_PANEL_TE_TIMEOUT));
+			if (ret == 0)
+				pr_err("wait panel TE time out\n");
+		}
+		ret = par->fbtftops.write(par, par->txbuf.buf,
+					 startbyte_size + to_copy * 2);
+		if (par->gpio.te)
+			set_spi_panel_te_irq_status(par, false);
+		if (ret < 0)
+			return ret;
+		remain -= to_copy;
+	}
+
+	return ret;
+}
+
 /**
  * set_var() - apply LCD properties like rotation and BGR mode
  *
@@ -259,6 +384,7 @@ static int blank(struct fbtft_par *par, bool on)
 	.gamma = HSD20_IPS_GAMMA,
 	.fbtftops = {
 		.init_display = init_display,
+		.write_vmem = st7789v_write_vmem16_bus8,
 		.set_var = set_var,
 		.set_gamma = set_gamma,
 		.blank = blank,
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 76f8c09..93bac05 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -212,6 +212,7 @@ struct fbtft_par {
 		struct gpio_desc *wr;
 		struct gpio_desc *latch;
 		struct gpio_desc *cs;
+		struct gpio_desc *te;
 		struct gpio_desc *db[16];
 		struct gpio_desc *led[16];
 		struct gpio_desc *aux[16];
-- 
1.9.1

