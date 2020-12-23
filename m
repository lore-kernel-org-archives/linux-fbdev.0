Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9CC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Dec 2020 14:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923142313C
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Dec 2020 14:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgLWOKn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Dec 2020 09:10:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9984 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgLWOKn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Dec 2020 09:10:43 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1FSW4myMzhvyl;
        Wed, 23 Dec 2020 22:09:15 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:09:48 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] vermilion.c: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:10:23 +0800
Message-ID: <20201223141023.32122-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/fbdev/vermilion/vermilion.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index ff61605b8764..cf41f3c50af8 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -35,7 +35,7 @@
 
 #define VML_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
 
-static struct mutex vml_mutex;
+static DEFINE_MUTEX(vml_mutex);
 static struct list_head global_no_mode;
 static struct list_head global_has_mode;
 static struct fb_ops vmlfb_ops;
@@ -1058,7 +1058,6 @@ static int __init vmlfb_init(void)
 #endif
 
 	printk(KERN_DEBUG MODULE_NAME ": initializing\n");
-	mutex_init(&vml_mutex);
 	INIT_LIST_HEAD(&global_no_mode);
 	INIT_LIST_HEAD(&global_has_mode);
 
-- 
2.22.0

