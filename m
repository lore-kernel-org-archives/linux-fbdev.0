Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BDC433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Nov 2022 09:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiKWJbT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiKWJbA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Nov 2022 04:31:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003F41B9D6
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Nov 2022 01:29:45 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHG6C2QY1zHw5Q;
        Wed, 23 Nov 2022 17:29:07 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:29:43 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <deller@gmx.de>, <cuigaosheng1@huawei.com>,
        <alexander.sverdlin@gmail.com>, <sam@ravnborg.org>,
        <nikita.shubin@maquefel.me>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH] video: ep93xx: Add missing clk_disable_unprepare in ep93xxfb_probe()
Date:   Wed, 23 Nov 2022 17:29:43 +0800
Message-ID: <20221123092943.2259585-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The clk_disable_unprepare() should be called in the error handling
of register_framebuffer(), fix it.

Fixes: 0937a7b3625d ("video: ep93xx: Prepare clock before using it")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 2398b3d48fed..305f1587bd89 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -552,12 +552,14 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 
 	err = register_framebuffer(info);
 	if (err)
-		goto failed_check;
+		goto failed_framebuffer;
 
 	dev_info(info->dev, "registered. Mode = %dx%d-%d\n",
 		 info->var.xres, info->var.yres, info->var.bits_per_pixel);
 	return 0;
 
+failed_framebuffer:
+	clk_disable_unprepare(fbi->clk);
 failed_check:
 	if (fbi->mach_info->teardown)
 		fbi->mach_info->teardown(pdev);
-- 
2.25.1

