Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA3C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 04:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF9E60F50
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Sep 2021 04:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbhIQEjh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:39:37 -0400
Received: from mx24.baidu.com ([111.206.215.185]:36810 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239754AbhIQEjc (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Sep 2021 00:39:32 -0400
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 00:39:29 EDT
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id EF4F84E4D0413A9999FC;
        Fri, 17 Sep 2021 12:22:23 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 17 Sep 2021 12:22:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 12:22:23 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] fbdev: pxa168fb: Make use of the helper function dev_err_probe()
Date:   Fri, 17 Sep 2021 12:22:08 +0800
Message-ID: <20210917042213.17689-2-caihuoqing@baidu.com>
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
 drivers/video/fbdev/pxa168fb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 47e6a1d0d229..35cf806a9219 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -606,10 +606,9 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	}
 
 	clk = devm_clk_get(&pdev->dev, "LCDCLK");
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get LCDCLK");
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "unable to get LCDCLK");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
-- 
2.25.1

