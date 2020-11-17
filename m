Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF91C6379D
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 06:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0645C246B0
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 06:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKQGPb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 17 Nov 2020 01:15:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8101 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQGP3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 17 Nov 2020 01:15:29 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZwf14qq2zLmrg;
        Tue, 17 Nov 2020 14:15:05 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Nov 2020
 14:15:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <b.zolnierkie@samsung.com>, <yangyingliang@huawei.com>
Subject: [PATCH] video: fbdev: atmel_lcdfb: fixe return error code in atmel_lcdfb_of_init()
Date:   Tue, 17 Nov 2020 14:13:50 +0800
Message-ID: <20201117061350.3453742-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If devm_kzalloc() failed after first time, atmel_lcdfb_of_init()
cann't return -ENOMEM, fix this by putting the error code in loop.

Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 8c1d47e52b1a..355b6120dc4f 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -987,8 +987,8 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	}
 
 	INIT_LIST_HEAD(&pdata->pwr_gpios);
-	ret = -ENOMEM;
 	for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
+		ret = -ENOMEM;
 		gpiod = devm_gpiod_get_index(dev, "atmel,power-control",
 					     i, GPIOD_ASIS);
 		if (IS_ERR(gpiod))
-- 
2.25.1

