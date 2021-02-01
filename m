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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D7AC433DB
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 13:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EFB64E7A
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 13:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhBANjE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 08:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBANjC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 08:39:02 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9BC061573;
        Mon,  1 Feb 2021 05:38:20 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o16so12097973pgg.5;
        Mon, 01 Feb 2021 05:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7Caf+TB7h06nb0xxu/+sgOXyFULnYGYCV3FXEmFfuj0=;
        b=HnJZZN66mPlNbBSAdES3ijMvErvph2BvCvS/hx6+qoXWGuh2iYq9FY0h7ET9B3EhQY
         Fh3kK+qIVAF6WlCVVAj/K26djrrq8irbt5Q/c26ZNc6wqPGAk1YecW97F0tP7602ox2P
         ITC6IJfE6d9qw/FvuB6a/l2wgtzUZ5nnwCWhCxK+MuGQ481xH6/mi/172gtL9L/gIvaY
         QD0pmjB87eUeOKgxQdA2+1/TG4LBc377OhIfwQtbg10mkFLndBtQ7T4MzHPylaF2kZ+o
         phphNUb7mopfNTi08AuwWztiTEQBfsKEHJ1hdc3WCjPQYCe4eGVB/Om+dY3cc9auB1rz
         pO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Caf+TB7h06nb0xxu/+sgOXyFULnYGYCV3FXEmFfuj0=;
        b=C4dcXXGfI0H5Bz0i1Fcm7RqiBUYbOeJEj2NODH675b+lbp/6HFUArY2xxBFXzdVC3O
         txqoK2UU8DvFXMOacni173nGwml8yfUuQc4yGqKmrVs3BkTxdFicv5fAgPOZ6OYI8KBU
         ziQJ4ns+W2Q4L4Jfl8wWG+hP6m1UAtfSuq7yRJ7m4rS0bzQALgvMfmOH8ETcBz2Pv7ar
         tIotB7FZ6aL3N1LVV71ZjsGsNOwjG0z+kXoC/08XpIqpP/CtXRQkQkDM6z+s9eDjMMBP
         pbpanUj8g8phpPC/cCcMlSmJK7Vl3RTVUEd11J4qPCE3Phu01QbZLkidQY0nteix1Jp9
         Bfxg==
X-Gm-Message-State: AOAM531WaaJ3QX7P7B+llaOHozOHYASs+cXTpbvcHeqroobYMAE8fSm+
        HJ8nqAPfjgdQUPAkYPAKpJQ=
X-Google-Smtp-Source: ABdhPJwUgQ7Es/Fic0jA/FSGL4cg/vEKJivgdQ/LGulL6iqxcF4SmqtgM7X+Buc+5Cg5X9pR4g3ZKg==
X-Received: by 2002:a63:5221:: with SMTP id g33mr16966842pgb.202.1612186700238;
        Mon, 01 Feb 2021 05:38:20 -0800 (PST)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id bj18sm15670597pjb.40.2021.02.01.05.38.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 05:38:19 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     colin.king@canonical.com, oliver.graute@kococonnector.com,
        zhangxuezhi1@yulong.com, mh12gx2825@gmail.com, sbrivio@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13] staging: fbtft: add tearing signal detect
Date:   Mon,  1 Feb 2021 21:38:24 +0800
Message-Id: <1612186704-161451-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Carlis <zhangxuezhi1@yulong.com>

For st7789v IC, when we need continuous full screen refresh, it is best to
wait for the tearing effect line signal to arrive to avoid screen tearing.

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
v13: change TE completion to par data struct member and add a new
     function to deal te gpio request, move wait logic to fbtft_write_vmem16_bus8.
v12: change dev_err to dev_err_probe and add space in comments start, and
     delete te_mutex, change te wait logic.
v11: remove devm_gpio_put and change a dev_err to dev_info.
v10: additional notes.
v9: change pr_* to dev_*.
v8: delete a log line.
v7: return error value when request fail.
v6: add te gpio request fail deal logic.
v5: fix log print.
v4: modify some code style and change te irq set function name.
v3: modify author and signed-off-by name.
v2: add release te gpio after irq request fail.
---
 drivers/staging/fbtft/fb_st7789v.c | 112 +++++++++++++++++++++++++++++++++++++
 drivers/staging/fbtft/fbtft.h      |   5 ++
 2 files changed, 117 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3a280cc..7b41bad 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -7,9 +7,13 @@
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/module.h>
+
 #include <video/mipi_display.h>
 
 #include "fbtft.h"
@@ -66,6 +70,59 @@ enum st7789v_command {
 #define MADCTL_MX BIT(6) /* bitmask for column address order */
 #define MADCTL_MY BIT(7) /* bitmask for page address order */
 
+/* 60Hz for 16.6ms, configured as 2*16.6ms */
+#define PANEL_TE_TIMEOUT_MS  33
+
+static irqreturn_t panel_te_handler(int irq, void *data)
+{
+	struct fbtft_par *par = (struct fbtft_par *)data;
+
+	complete(&par->panel_te);
+	return IRQ_HANDLED;
+}
+
+/*
+ * init_tearing_effect_line() - init tearing effect line.
+ * @par: FBTFT parameter object.
+ *
+ * Return: 0 on success, or a negative error code otherwise.
+ */
+static int init_tearing_effect_line(struct fbtft_par *par)
+{
+	struct device *dev = par->info->device;
+	struct gpio_desc *te;
+	int rc, irq;
+
+	te = gpiod_get_optional(dev, "te", GPIOD_IN);
+	if (IS_ERR(te))
+		return dev_err_probe(dev, PTR_ERR(te), "Failed to request te GPIO\n");
+
+	/* if te is NULL, indicating no configuration, directly return success */
+	if (!te)
+		return 0;
+
+	irq = gpiod_to_irq(te);
+
+	/* GPIO is locked as an IRQ, we may drop the reference */
+	gpiod_put(te);
+
+	if (irq < 0)
+		return irq;
+
+	par->irq_te = irq;
+	init_completion(&par->panel_te);
+
+	/* The effective state is high and lasts no more than 1000 microseconds */
+	rc = devm_request_irq(dev, par->irq_te, panel_te_handler,
+			      IRQF_TRIGGER_RISING, "TE_GPIO", par);
+	if (rc)
+		return dev_err_probe(dev, rc, "TE IRQ request failed.\n");
+
+	disable_irq_nosync(par->irq_te);
+
+	return 0;
+}
+
 /**
  * init_display() - initialize the display controller
  *
@@ -82,6 +139,12 @@ enum st7789v_command {
  */
 static int init_display(struct fbtft_par *par)
 {
+	int rc;
+
+	rc = init_tearing_effect_line(par);
+	if (rc)
+		return rc;
+
 	/* turn off sleep mode */
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	mdelay(120);
@@ -137,6 +200,10 @@ static int init_display(struct fbtft_par *par)
 	 */
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
+	/* TE line output is off by default when powering on */
+	if (par->irq_te)
+		write_reg(par, MIPI_DCS_SET_TEAR_ON, 0x00);
+
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	if (HSD20_IPS)
@@ -145,6 +212,50 @@ static int init_display(struct fbtft_par *par)
 	return 0;
 }
 
+/*
+ * write_vmem() - write data to display.
+ * @par: FBTFT parameter object.
+ * @offset: offset from screen_buffer.
+ * @len: the length of data to be writte.
+ *
+ * Return: 0 on success, or a negative error code otherwise.
+ */
+static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
+{
+	struct device *dev = par->info->device;
+	int ret;
+
+	if (par->irq_te) {
+		enable_irq(par->irq_te);
+		reinit_completion(&par->panel_te);
+		ret = wait_for_completion_timeout(&par->panel_te,
+						  msecs_to_jiffies(PANEL_TE_TIMEOUT_MS));
+		if (ret == 0)
+			dev_err(dev, "wait panel TE timeout\n");
+
+		disable_irq(par->irq_te);
+	}
+
+	ret = 0;
+	switch (par->pdata->display.buswidth) {
+	case 8:
+		ret = fbtft_write_vmem16_bus8(par, offset, len);
+		break;
+	case 9:
+		ret = fbtft_write_vmem16_bus9(par, offset, len);
+		break;
+	case 16:
+		ret = fbtft_write_vmem16_bus16(par, offset, len);
+		break;
+	default:
+		dev_err(dev, "Unsupported buswidth %d\n",
+			par->pdata->display.buswidth);
+		break;
+	}
+
+	return ret;
+}
+
 /**
  * set_var() - apply LCD properties like rotation and BGR mode
  *
@@ -259,6 +370,7 @@ static int blank(struct fbtft_par *par, bool on)
 	.gamma = HSD20_IPS_GAMMA,
 	.fbtftops = {
 		.init_display = init_display,
+		.write_vmem = write_vmem,
 		.set_var = set_var,
 		.set_gamma = set_gamma,
 		.blank = blank,
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 76f8c09..61c7207 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/spi/spi.h>
 #include <linux/platform_device.h>
+#include <linux/completion.h>
 
 #define FBTFT_ONBOARD_BACKLIGHT 2
 
@@ -165,6 +166,8 @@ struct fbtft_platform_data {
  *             Format: 6 bit Device id + RS bit + RW bit
  * @fbtftops: FBTFT operations provided by driver or device (platform_data)
  * @dirty_lock: Protects dirty_lines_start and dirty_lines_end
+ * @panel_te: completion for panel TE line
+ * @irq_te: Linux IRQ for LCD TE line
  * @dirty_lines_start: Where to begin updating display
  * @dirty_lines_end: Where to end updating display
  * @gpio.reset: GPIO used to reset display
@@ -203,6 +206,8 @@ struct fbtft_par {
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
 	spinlock_t dirty_lock;
+	struct completion panel_te;
+	int irq_te;
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
-- 
1.9.1

