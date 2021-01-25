Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E285C433E0
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 03:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F2622583
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 03:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhAYJQm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jan 2021 04:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbhAYJPz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8CC061355;
        Mon, 25 Jan 2021 00:44:11 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id z21so8445114pgj.4;
        Mon, 25 Jan 2021 00:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kql6/H7XE4iGCcMOEzKNPSUD4IIdZnFwuOgOy/87akg=;
        b=BZw5Rn+MdGlWCL+t7+pLH/7drROvvcmFubGAs87DVdRv+OxYf6B1mMv++cK/pjW/4v
         fm/K6XZHZTev3BBNa4QcPMmF12GtAwGDSahGRnoOWZtF9iMN2J00naXvOGhySynpEpl7
         00cl72haOnL2RztGq3aVriAUiipIIIHHgVTYv2JQMmRmMO/CjQG4JPkJPQ4i841X/tqY
         tA5rPkEY5nn/jJuc589vusw6sxipiu4hqTB7c6BHb+NgRhg8PxQvooDq3NvAlKD75C7i
         bS6r6G0/JC3z6ERS1WDDTVWnkVTYurzxvM26Lat8dqC8mfP3au/sgClPBvyc/8IjENmM
         yBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kql6/H7XE4iGCcMOEzKNPSUD4IIdZnFwuOgOy/87akg=;
        b=SFzqnrCByNO/jM2ZsKzC3PEYuB8n2ZuuOXripfKh6SNF2USOIkUdBCeVx5pILG7Wdj
         tu9UucEevkre9ur/4osfJ+y//FkZtneUXwIr7Slx0cTmWTkiQIZhHY1qJtr2RQxuQ3UE
         UsCCp79RN5ZDUzqtQLtNT4cw3L7sCAp6CmwrUk4zpaSKGCjxr+FZs3aO4lfHP9lrNyQC
         BSlGwo71EwxVPM+sgtq2YGUSvuhApb+GKgwov+YgVRYxN1fnBBmGTJSk4ZIiPb22T2XU
         4n3WJmMvdZFTfVjA+O3bHGzlKbRvY2w61z2Hl3YQJ0aGbsyCazPU4SEMXTgAaG6lgp5f
         dGDw==
X-Gm-Message-State: AOAM531nlVUED3T8sSGXtR3yqzxLSPW7p6aVL9jHxbYY5O/6zCSUduY9
        HIA4/GWsntRzUr8m4WrRQJ4=
X-Google-Smtp-Source: ABdhPJx0Jqei25/t9AkDDGOL0Y8Uik/RfREQCpOF1yCy/AilZuI1RTNjilmyI+ENKpeIqoaAQT0mRw==
X-Received: by 2002:a05:6a00:2385:b029:1b6:1603:4ea3 with SMTP id f5-20020a056a002385b02901b616034ea3mr9950604pfc.40.1611564251051;
        Mon, 25 Jan 2021 00:44:11 -0800 (PST)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 145sm15521010pfu.8.2021.01.25.00.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 00:44:10 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     colin.king@canonical.com, oliver.graute@kococonnector.com,
        zhangxuezhi1@yulong.com, mh12gx2825@gmail.com, sbrivio@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbtft: add tearing signal detect
Date:   Mon, 25 Jan 2021 16:44:12 +0800
Message-Id: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>

For st7789v ic,add tearing signal detect to avoid screen tearing

Signed-off-by: carlis.zhang_cp <zhangxuezhi1@yulong.com>
---
v2:add release te gpio after irq request fail
---
 drivers/staging/fbtft/fb_st7789v.c | 134 ++++++++++++++++++++++++++++++++++++-
 drivers/staging/fbtft/fbtft.h      |   1 +
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3a280cc..5426276 100644
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
@@ -66,6 +69,38 @@ enum st7789v_command {
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
+static void enable_spi_panel_te_irq(struct fbtft_par *par, bool enable)
+{
+	static int te_irq_count;
+
+	if (!par->gpio.te) {
+		pr_err("%s:%d,SPI panel TE GPIO not configured\n",
+		       __func__, __LINE__);
+		return;
+	}
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
@@ -82,6 +117,29 @@ enum st7789v_command {
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
@@ -137,6 +195,9 @@ static int init_display(struct fbtft_par *par)
 	 */
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
+    /*Tearing Effect Line On*/
+	if (par->gpio.te)
+		write_reg(par, 0x35, 0x00);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	if (HSD20_IPS)
@@ -145,6 +206,76 @@ static int init_display(struct fbtft_par *par)
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
+	int rc, ret = 0;
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
+			enable_spi_panel_te_irq(par, true);
+			reinit_completion(&spi_panel_te);
+			rc = wait_for_completion_timeout(&spi_panel_te,
+							 msecs_to_jiffies(SPI_PANEL_TE_TIMEOUT));
+			if (rc == 0)
+				pr_err("wait panel TE time out\n");
+		}
+		ret = par->fbtftops.write(par, par->txbuf.buf,
+								startbyte_size + to_copy * 2);
+		if (par->gpio.te)
+			enable_spi_panel_te_irq(par, false);
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
@@ -259,6 +390,7 @@ static int blank(struct fbtft_par *par, bool on)
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

