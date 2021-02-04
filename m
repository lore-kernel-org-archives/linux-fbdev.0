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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39496C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Feb 2021 12:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E588664F53
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Feb 2021 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhBDM2N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Feb 2021 07:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbhBDM2L (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 4 Feb 2021 07:28:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D5C0613ED;
        Thu,  4 Feb 2021 04:27:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s24so1609991pjp.5;
        Thu, 04 Feb 2021 04:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Y3d3B6KufnGucplOiax9QznTkziFjxSJfMH4cZHo4s=;
        b=rU3JUdGZ7yQLykF3SVVkpovurDjbu/b1I7R4gv9FXt2mYPoNZo2ndxz5iZX2WyKkI1
         r2GCR/d8zDF2HADzWos3Nkk3qCup9q2mA0RLapoh+LXVbJUMM5M5S7krRdI6ehba0qo1
         t742rawdSDddtTcExEMWzcLo8VYTHUyBosGLIXemh7FmZm+bsVM44YEw6oi/EWQX2O4V
         xSaTHbk4xMRZIggpm77P8maV+rvyKrQWPeA9KjpQ3Ap1fj1FC9oSKvlrguklK7KBweLB
         eOg5JnzDE2Ogp4awqOyuOUHodoUkZk4jBfk2DO+/T51qypGBJOo3R/VKALJaX9Bkib1e
         CPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Y3d3B6KufnGucplOiax9QznTkziFjxSJfMH4cZHo4s=;
        b=HbGjAO8AvyW8tp2UN0Ahspb9wkRRsB6tuR7bDhsjevk9lZGnxuBaDk9Sqga66iLJSD
         y68FQmxlNlI6W2osNEJz57upOBkdbQxDI+Cd440dOwgQofHBbrcQ8t/fix3wGnZ/ggEs
         3gMtPXdaSAnmF61GcC6LIN51o9vA0XHhofO8SZscFVqrAI/8lgBd0Lv1/erX5G69TLBb
         LjGhjG2zXPPCkl9pdMkumCTKHb3gBUzHfNk9DYVvHCnyt47veUxJpehyKxqe4EUTw4ai
         C+igJmh0VspDkOsP36fM+O250ufng9fvTjVVvdxOLxeTUnc7EDaF4sx72r+I9KlN/xR/
         nXtw==
X-Gm-Message-State: AOAM5313E9GC/l6QZLJBGLtlCPtQNdPE91wzO/GD1ItUm6z9J/nFPOxM
        x4TmqH4IuCMX5JBKKzSqSe2xT6izXz5iv+1i
X-Google-Smtp-Source: ABdhPJxJq48W+Supw/2PYsdt0uVcGO6NCvm73L3BI3+oiJGMtXAJadL0egPJIncoiVwgcWpL6VqS1Q==
X-Received: by 2002:a17:902:aa08:b029:e0:52c:ab81 with SMTP id be8-20020a170902aa08b02900e0052cab81mr7933796plb.83.1612441651258;
        Thu, 04 Feb 2021 04:27:31 -0800 (PST)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id l10sm5270700pjt.6.2021.02.04.04.27.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 04:27:30 -0800 (PST)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     colin.king@canonical.com, oliver.graute@kococonnector.com,
        zhangxuezhi1@yulong.com, mh12gx2825@gmail.com, sbrivio@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v14] staging: fbtft: add tearing signal detect
Date:   Thu,  4 Feb 2021 20:27:34 +0800
Message-Id: <1612441654-150036-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Carlis <zhangxuezhi1@yulong.com>

For st7789v IC, when we need continuous full screen refresh, it is best to
wait for the tearing effect line signal to arrive to avoid screen tearing.

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
v14: change to define TE completion and TE irq only in st7789v.
v13: change TE completion to par data struct member and add a new
     function to deal te gpio request, add new write_vmem function.
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
 drivers/staging/fbtft/fb_st7789v.c | 115 +++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 3a280cc..ee8866d 100644
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
@@ -66,6 +70,62 @@ enum st7789v_command {
 #define MADCTL_MX BIT(6) /* bitmask for column address order */
 #define MADCTL_MY BIT(7) /* bitmask for page address order */
 
+/* 60Hz for 16.6ms, configured as 2*16.6ms */
+#define PANEL_TE_TIMEOUT_MS  33
+
+static struct completion panel_te; /* completion for panel TE line */
+static int irq_te; /* Linux IRQ for LCD TE line */
+
+static irqreturn_t panel_te_handler(int irq, void *data)
+{
+	complete(&panel_te);
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
+	if (!te) {
+		irq_te = 0;
+		return 0;
+	}
+
+	irq = gpiod_to_irq(te);
+
+	/* GPIO is locked as an IRQ, we may drop the reference */
+	gpiod_put(te);
+
+	if (irq < 0)
+		return irq;
+
+	irq_te = irq;
+	init_completion(&panel_te);
+
+	/* The effective state is high and lasts no more than 1000 microseconds */
+	rc = devm_request_irq(dev, irq_te, panel_te_handler,
+			      IRQF_TRIGGER_RISING, "TE_GPIO", par);
+	if (rc)
+		return dev_err_probe(dev, rc, "TE IRQ request failed.\n");
+
+	disable_irq_nosync(irq_te);
+
+	return 0;
+}
+
 /**
  * init_display() - initialize the display controller
  *
@@ -82,6 +142,12 @@ enum st7789v_command {
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
@@ -137,6 +203,10 @@ static int init_display(struct fbtft_par *par)
 	 */
 	write_reg(par, PWCTRL1, 0xA4, 0xA1);
 
+	/* TE line output is off by default when powering on */
+	if (irq_te)
+		write_reg(par, MIPI_DCS_SET_TEAR_ON, 0x00);
+
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	if (HSD20_IPS)
@@ -145,6 +215,50 @@ static int init_display(struct fbtft_par *par)
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
+	if (irq_te) {
+		enable_irq(irq_te);
+		reinit_completion(&panel_te);
+		ret = wait_for_completion_timeout(&panel_te,
+						  msecs_to_jiffies(PANEL_TE_TIMEOUT_MS));
+		if (ret == 0)
+			dev_err(dev, "wait panel TE timeout\n");
+
+		disable_irq(irq_te);
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
@@ -259,6 +373,7 @@ static int blank(struct fbtft_par *par, bool on)
 	.gamma = HSD20_IPS_GAMMA,
 	.fbtftops = {
 		.init_display = init_display,
+		.write_vmem = write_vmem,
 		.set_var = set_var,
 		.set_gamma = set_gamma,
 		.blank = blank,
-- 
1.9.1

