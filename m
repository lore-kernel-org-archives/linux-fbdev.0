Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45370C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiBKJTz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:19:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348476AbiBKJTw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8FC1034
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIKkJ875AEpR+7YUjcgsz5f6Y/JgzppmeREtshSR4sw=;
        b=RgwJDR2hSfV8t5flCujQkFC3tod6dx91KytaRjPYut39zLFiFqF3XWTUiNXT5F1Z6G8GQw
        4LanOoJNgk9l8/kaNdIv92/vBJvKJYd3vIkBWq71FvMj6dol2kIzGHFYSP/CeLvE6aGuou
        o1NChWs8uFXSLkoCyLpI7gyvEY8pPqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-zBUB45izOMWPXrPN4lPhRQ-1; Fri, 11 Feb 2022 04:19:45 -0500
X-MC-Unique: zBUB45izOMWPXrPN4lPhRQ-1
Received: by mail-wr1-f70.google.com with SMTP id q8-20020adfb188000000b001e33a8cdbf4so3614805wra.16
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dIKkJ875AEpR+7YUjcgsz5f6Y/JgzppmeREtshSR4sw=;
        b=VIKEMpujCRm6vUDEmr4qGiVSfxv2XcnlSkjziOk2wqY7kcEXtL4sNHzOm2QzrZx5Vb
         NOBcVilSVW1rrvdjR2w4htkxGopN75g857jafnnN4/T0Pbs6aj31kIXYpyQfG1ZqSB9I
         Hg4n2UCE1wqDO6jSJVuAumUivT/jI5s28bEeEJxYuIxsYSTUehjQqtdHSPf9+IiuZtjX
         3lNag4WqoIeo6LX5q7dp9VjagzRl1S5/d+o3MZPX+1LDl62zbZp+8IuSxSkSJjjkqPJF
         9uiOrR60DP4aRAnCti2e807pmlBj0rwk/E0o0lc+lZTz+zh9FpUNtLdZ7nkaInxTriST
         H5cg==
X-Gm-Message-State: AOAM533dLfUrmuU612k+d/avJjEhMsJ6jmVs/a/uBgExD4Zj5pjaxY76
        53RO//bnE4F3jpl0JoUE699+PXdVNbcdj4DCB2I88swSugKZh/T3Q38feLbuUeH1+acujaAhbzE
        Tqvx3hMS6KxYHK2v0LcRhsHc=
X-Received: by 2002:a5d:5907:: with SMTP id v7mr607747wrd.46.1644571182825;
        Fri, 11 Feb 2022 01:19:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPSz2Ki81nzLTNdIiv7nGBJl0BSYtYtKiRuPhLqayIfVPV/PE3H270y/+FPcT9rZK9IlKFwQ==
X-Received: by 2002:a5d:5907:: with SMTP id v7mr607729wrd.46.1644571182587;
        Fri, 11 Feb 2022 01:19:42 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm3805578wmq.33.2022.02.11.01.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:19:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v4 4/6] drm/solomon: Add SSD130x OLED displays I2C support
Date:   Fri, 11 Feb 2022 10:19:25 +0100
Message-Id: <20220211091927.2988283-5-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The ssd130x driver only provides the core support for these devices but it
does not have any bus transport logic. Add a driver to interface over I2C.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v4:
- Remove unnecessary casting (Geert Uytterhoeven)
- Remove redundant blank lines (Andy Shevchenko)
- Remove comma after of_device_id table terminator (Andy Shevchenko)

Changes in v3:
- Add a separate driver for SSD130X chips I2C support (Andy Shevchenko)

 drivers/gpu/drm/solomon/Kconfig       |   9 ++
 drivers/gpu/drm/solomon/Makefile      |   1 +
 drivers/gpu/drm/solomon/ssd130x-i2c.c | 116 ++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/gpu/drm/solomon/ssd130x-i2c.c

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 7720a7039e8d..5861c3ab7c45 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -10,3 +10,12 @@ config DRM_SSD130X
 	  the appropriate bus transport in your chip also must be selected.
 
 	  If M is selected the module will be called ssd130x.
+
+config DRM_SSD130X_I2C
+	tristate "DRM support for Solomon SSD130x OLED displays (I2C bus)"
+	depends on DRM_SSD130X && I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if the SSD130x OLED display is connected via I2C bus.
+
+	  If M is selected the module will be called ssd130x-i2c.
diff --git a/drivers/gpu/drm/solomon/Makefile b/drivers/gpu/drm/solomon/Makefile
index f685addb19fe..4bfc5acb0447 100644
--- a/drivers/gpu/drm/solomon/Makefile
+++ b/drivers/gpu/drm/solomon/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DRM_SSD130X)	+= ssd130x.o
+obj-$(CONFIG_DRM_SSD130X_I2C)	+= ssd130x-i2c.o
diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
new file mode 100644
index 000000000000..3126aeda4ced
--- /dev/null
+++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DRM driver for Solomon SSD130x OLED displays (I2C bus)
+ *
+ * Copyright 2022 Red Hat Inc.
+ * Author: Javier Martinez Canillas <javierm@redhat.com>
+ *
+ * Based on drivers/video/fbdev/ssd1307fb.c
+ * Copyright 2012 Free Electrons
+ */
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "ssd130x.h"
+
+#define DRIVER_NAME	"ssd130x-i2c"
+#define DRIVER_DESC	"DRM driver for Solomon SSD130x OLED displays (I2C)"
+
+static const struct regmap_config ssd130x_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ssd130x_i2c_probe(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &ssd130x_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ssd130x = ssd130x_probe(&client->dev, regmap);
+	if (IS_ERR(ssd130x))
+		return PTR_ERR(ssd130x);
+
+	i2c_set_clientdata(client, ssd130x);
+
+	return 0;
+}
+
+static int ssd130x_i2c_remove(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x = i2c_get_clientdata(client);
+
+	return ssd130x_remove(ssd130x);
+}
+
+static void ssd130x_i2c_shutdown(struct i2c_client *client)
+{
+	struct ssd130x_device *ssd130x = i2c_get_clientdata(client);
+
+	ssd130x_shutdown(ssd130x);
+}
+
+static struct ssd130x_deviceinfo ssd130x_ssd1305_deviceinfo = {
+	.default_vcomh = 0x34,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 7,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1306_deviceinfo = {
+	.default_vcomh = 0x20,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 8,
+	.need_chargepump = 1,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1307_deviceinfo = {
+	.default_vcomh = 0x20,
+	.default_dclk_div = 2,
+	.default_dclk_frq = 12,
+	.need_pwm = 1,
+};
+
+static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
+	.default_vcomh = 0x34,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 10,
+};
+
+static const struct of_device_id ssd130x_of_match[] = {
+	{
+		.compatible = "solomon,ssd1305fb-i2c",
+		.data = &ssd130x_ssd1305_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1306fb-i2c",
+		.data = &ssd130x_ssd1306_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1307fb-i2c",
+		.data = &ssd130x_ssd1307_deviceinfo,
+	},
+	{
+		.compatible = "solomon,ssd1309fb-i2c",
+		.data = &ssd130x_ssd1309_deviceinfo,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ssd130x_of_match);
+
+static struct i2c_driver ssd130x_i2c_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ssd130x_of_match,
+	},
+	.probe_new = ssd130x_i2c_probe,
+	.remove = ssd130x_i2c_remove,
+	.shutdown = ssd130x_i2c_shutdown,
+};
+module_i2c_driver(ssd130x_i2c_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Javier Martinez Canillas <javierm@redhat.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

