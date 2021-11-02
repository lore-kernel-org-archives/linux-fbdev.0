Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88348C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Nov 2021 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8116023F
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Nov 2021 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhKBKIJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Nov 2021 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhKBKII (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 2 Nov 2021 06:08:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB381C061714
        for <linux-fbdev@vger.kernel.org>; Tue,  2 Nov 2021 03:05:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t30so7541987wra.10
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Nov 2021 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYLMuf3bD3yM/Xi9gc5DeQ7+ailWv3pCd20wKELPV+A=;
        b=cFnX21AjnJbHSPGd7EX5s7DI/2ObKunmpv40Y5AFsmpaHGoFigC1QQ5pzC3z5MD9mO
         hhFxZjOzFlZI54gPqvWGGlaYUi8wM32FpZkMDlA2coqGWnXH952IqqzxbmgccWT/ePwP
         afkf2peXtkXxbN48yhUYMpXUaLzrKSfeR5poiM2IPKp5IKWPxbMnLgRwfg2R7Kn1884P
         DHIFl8YIKWuOIQkoh+8ytDq2FG3fu2qoW78xcFJO+PPinwf+2OElqeJzCHZbahZbMJk5
         FENz9Zk5DDaZY3eloL50ChE0DGLz2gZwLIDTcgC9FynWWKbbD6pVvYyweWcAJgRiXcTs
         0ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYLMuf3bD3yM/Xi9gc5DeQ7+ailWv3pCd20wKELPV+A=;
        b=mgSu+D7kaw9/Av3ehppTdPqB4RejfRtbih9njitfuQanAYH/Bca/fGohPWdSYg9CD0
         rM1WPaI4keLxXrVKqX8CUCJS1s/tUUtGn/o8vxf1hNLL8mwMEkfjNaBMm4b6aog/AKAE
         qGrTouE8B+snOYms8ZxNPKQPw7L+yP+H+PZcIl1S5gOle9vWe3ivuiJRmiGG4UoK7KfF
         ZiVs05C9oJX1CWe0ju9QtpvJsIAKafTMmVvVlEdtrtEkD6Mqan1Exh/eplal2pNFrkRC
         CCSc9/0XQ/mVyVkTkfnu18743rsnOlb+NoWI7U2pseK0z2rHqVSo9UKVR039DAsY1RX1
         0kZA==
X-Gm-Message-State: AOAM533gnxEQzg0e5Nu+LnIts6YKjU1YP9pY+eoVMTfpwWYsA9yPKdvY
        Y+flYkOqV8a5gAzRNcpIRZU6Pg==
X-Google-Smtp-Source: ABdhPJxt3bN1oRHkd5fsk2sQswWJgq8yAvVNc4ziZAfnf50krWHiOnJpCEsjC4BOSZeaqYq2/ywl3w==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr34185086wrx.155.1635847532426;
        Tue, 02 Nov 2021 03:05:32 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p13sm2315273wmi.0.2021.11.02.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 03:05:32 -0700 (PDT)
From:   Corentin LABBE <clabbe@baylibre.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Corentin LABBE <clabbe@baylibre.com>
Subject: [PATCH] backlight: led_bl: Add support for an "enable" GPIO
Date:   Tue,  2 Nov 2021 10:04:55 +0000
Message-Id: <20211102100455.2016610-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jean-Jacques Hiblot <jjhiblot@ti.com>

This patch adds support for an "enable GPIO".

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Corentin LABBE <clabbe@baylibre.com>
---
 drivers/video/backlight/led_bl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index f54d256e2d54..ebd7acc32980 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -8,6 +8,7 @@
 
 #include <linux/backlight.h>
 #include <linux/leds.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -15,6 +16,7 @@ struct led_bl_data {
 	struct device		*dev;
 	struct backlight_device	*bl_dev;
 	struct led_classdev	**leds;
+	struct gpio_desc        *enable_gpio;
 	bool			enabled;
 	int			nb_leds;
 	unsigned int		*levels;
@@ -35,6 +37,9 @@ static void led_bl_set_brightness(struct led_bl_data *priv, int level)
 	for (i = 0; i < priv->nb_leds; i++)
 		led_set_brightness(priv->leds[i], bkl_brightness);
 
+	if (!priv->enabled)
+		gpiod_set_value_cansleep(priv->enable_gpio, 1);
+
 	priv->enabled = true;
 }
 
@@ -48,6 +53,9 @@ static void led_bl_power_off(struct led_bl_data *priv)
 	for (i = 0; i < priv->nb_leds; i++)
 		led_set_brightness(priv->leds[i], LED_OFF);
 
+	if (priv->enabled)
+		gpiod_set_value_cansleep(priv->enable_gpio, 0);
+
 	priv->enabled = false;
 }
 
@@ -209,6 +217,11 @@ static int led_bl_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->bl_dev);
 	}
 
+	priv->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
+						    GPIOD_OUT_LOW);
+	if (IS_ERR(priv->enable_gpio))
+		return PTR_ERR(priv->enable_gpio);
+
 	for (i = 0; i < priv->nb_leds; i++)
 		led_sysfs_disable(priv->leds[i]);
 
-- 
2.25.1

