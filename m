Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24014C2BB48
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Dec 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD48C22795
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Dec 2020 13:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439697AbgLNNdy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:33:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9877 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439684AbgLNNdp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Dec 2020 08:33:45 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cvj4734skz7G86;
        Mon, 14 Dec 2020 21:32:23 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:32:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <krzk@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fbdev: s3c2410fb: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:33:17 +0800
Message-ID: <20201214133317.3622-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/fbdev/s3c2410fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index d8ae5258de46..d8da6bf3775d 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -411,7 +411,7 @@ static void s3c2410fb_activate_var(struct fb_info *info)
 	/* set lcd address pointers */
 	s3c2410fb_set_lcdaddr(info);
 
-	fbi->regs.lcdcon1 |= S3C2410_LCDCON1_ENVID,
+	fbi->regs.lcdcon1 |= S3C2410_LCDCON1_ENVID;
 	writel(fbi->regs.lcdcon1, regs + S3C2410_LCDCON1);
 }
 
-- 
2.22.0

