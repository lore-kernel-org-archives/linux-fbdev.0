Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F6ECAAD8
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Sep 2022 09:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiIWJrV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiIWJqk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 23 Sep 2022 05:46:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08533F2749
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 02:45:55 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYnGG0zqzzMpS4;
        Fri, 23 Sep 2022 17:41:10 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:45:53 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 17:45:52 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <deller@gmx.de>,
        <shawnguo@kernel.org>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] video: fbdev: imxfb: Remove redundant dev_err call
Date:   Fri, 23 Sep 2022 18:20:07 +0800
Message-ID: <20220923102007.19870-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

devm_ioremap_resource() prints error message in itself. Remove the
dev_err call to avoid redundant error message.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 drivers/video/fbdev/imxfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 94f3bc637fc8..51fde1b2a793 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -972,7 +972,6 @@ static int imxfb_probe(struct platform_device *pdev)
 
 	fbi->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fbi->regs)) {
-		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
 		ret = PTR_ERR(fbi->regs);
 		goto failed_ioremap;
 	}
-- 
2.17.1

