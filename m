Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B887C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 04:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F132A60F93
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 04:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244480AbhIQEYG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:24:06 -0400
Received: from mx22.baidu.com ([220.181.50.185]:52778 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244399AbhIQEXx (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Sep 2021 00:23:53 -0400
Received: from BJHW-MAIL-EX04.internal.baidu.com (unknown [10.127.64.14])
        by Forcepoint Email with ESMTPS id 78C4A4A5BDB8D0256D64;
        Fri, 17 Sep 2021 12:22:30 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 12:22:30 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 12:22:29 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] fbdev: s3c-fb: Make use of the helper function dev_err_probe()
Date:   Fri, 17 Sep 2021 12:22:11 +0800
Message-ID: <20210917042213.17689-5-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917042213.17689-1-caihuoqing@baidu.com>
References: <20210917042213.17689-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/video/fbdev/s3c-fb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 3b134e1bbc38..459d159879a3 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1392,18 +1392,17 @@ static int s3c_fb_probe(struct platform_device *pdev)
 	spin_lock_init(&sfb->slock);
 
 	sfb->bus_clk = devm_clk_get(dev, "lcd");
-	if (IS_ERR(sfb->bus_clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(sfb->bus_clk);
-	}
+	if (IS_ERR(sfb->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(sfb->bus_clk),
+				     "failed to get bus clock\n");
 
 	clk_prepare_enable(sfb->bus_clk);
 
 	if (!sfb->variant.has_clksel) {
 		sfb->lcd_clk = devm_clk_get(dev, "sclk_fimd");
 		if (IS_ERR(sfb->lcd_clk)) {
-			dev_err(dev, "failed to get lcd clock\n");
-			ret = PTR_ERR(sfb->lcd_clk);
+			ret = dev_err_probe(dev, PTR_ERR(sfb->lcd_clk),
+					    "failed to get lcd clock\n");
 			goto err_bus_clk;
 		}
 
-- 
2.25.1

