Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C6C00140
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Jul 2022 02:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiG2Cev (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jul 2022 22:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiG2Cev (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jul 2022 22:34:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7B27B1F0;
        Thu, 28 Jul 2022 19:34:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvBMc35pnzWfby;
        Fri, 29 Jul 2022 10:30:52 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:34:47 +0800
Received: from huawei.com (10.175.113.25) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 10:34:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>
CC:     <u.kleine-koenig@pengutronix.de>, <deller@gmx.de>
Subject: [PATCH -next] video: fbdev: imxfb: fix return value check in imxfb_probe()
Date:   Fri, 29 Jul 2022 10:41:34 +0800
Message-ID: <20220729024134.159942-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If devm_ioremap_resource() fails, it never return NULL, replace
NULL test with IS_ERR().

Fixes: b083c22d5114 ("video: fbdev: imxfb: Convert request_mem_region + ioremap to devm_ioremap_resource")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/imxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index c48477893dd0..d97d7456d15a 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -971,9 +971,9 @@ static int imxfb_probe(struct platform_device *pdev)
 	}
 
 	fbi->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (fbi->regs == NULL) {
+	if (IS_ERR(fbi->regs)) {
 		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(fbi->regs);
 		goto failed_ioremap;
 	}
 
-- 
2.25.1

