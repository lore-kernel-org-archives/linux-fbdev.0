Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20E0C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 06:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839AD610FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Sep 2021 06:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhIGGY4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:24:56 -0400
Received: from mx20.baidu.com ([111.202.115.85]:53922 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230342AbhIGGY4 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 7 Sep 2021 02:24:56 -0400
Received: from BJHW-Mail-Ex12.internal.baidu.com (unknown [10.127.64.35])
        by Forcepoint Email with ESMTPS id D034EC052D97E104049F;
        Tue,  7 Sep 2021 14:23:45 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 14:23:45 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 14:23:45 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] backlight: l4f00242t03: Add a single error handling block at the end of the function.
Date:   Tue, 7 Sep 2021 14:23:39 +0800
Message-ID: <20210907062339.1828-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex30.internal.baidu.com (172.31.51.24) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex12_2021-09-07 14:23:45:833
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A single error handling block at the end of the function could
be brought in to make code a little more concise.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/video/backlight/l4f00242t03.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 46f97d1c3d21..c6f540f1b507 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -65,14 +65,12 @@ static void l4f00242t03_lcd_init(struct spi_device *spi)
 	ret = regulator_set_voltage(priv->core_reg, 2800000, 2800000);
 	if (ret) {
 		dev_err(&spi->dev, "failed to set the core regulator voltage.\n");
-		regulator_disable(priv->io_reg);
-		return;
+		goto err_disable_reg;
 	}
 	ret = regulator_enable(priv->core_reg);
 	if (ret) {
 		dev_err(&spi->dev, "failed to enable the core regulator.\n");
-		regulator_disable(priv->io_reg);
-		return;
+		goto err_disable_reg;
 	}
 
 	l4f00242t03_reset(priv->reset);
@@ -80,6 +78,10 @@ static void l4f00242t03_lcd_init(struct spi_device *spi)
 	gpiod_set_value(priv->enable, 1);
 	msleep(60);
 	spi_write(spi, (const u8 *)cmd, ARRAY_SIZE(cmd) * sizeof(u16));
+	return;
+
+err_disable_reg:
+	regulator_disable(priv->io_reg);
 }
 
 static void l4f00242t03_lcd_powerdown(struct spi_device *spi)
-- 
2.25.1

