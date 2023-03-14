Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF33C74A44
	for <linux-fbdev@archiver.kernel.org>; Tue, 14 Mar 2023 05:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCNFm3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 14 Mar 2023 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCNFm2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 14 Mar 2023 01:42:28 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AAC76AA;
        Mon, 13 Mar 2023 22:42:27 -0700 (PDT)
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VdqljY2_1678772543)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 13:42:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 3/3] video: fbdev: xilinxfb: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 14 Mar 2023 13:42:19 +0800
Message-Id: <20230314054219.80441-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
References: <20230314054219.80441-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/video/fbdev/xilinxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index c17cfffd9a84..7911354827dc 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -273,8 +273,7 @@ static int xilinxfb_assign(struct platform_device *pdev,
 	if (drvdata->flags & BUS_ACCESS_FLAG) {
 		struct resource *res;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		drvdata->regs = devm_ioremap_resource(&pdev->dev, res);
+		drvdata->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(drvdata->regs))
 			return PTR_ERR(drvdata->regs);
 
-- 
2.20.1.7.g153144c

