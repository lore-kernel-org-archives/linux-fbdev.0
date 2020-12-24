Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3626AC43381
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Dec 2020 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FD522287
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Dec 2020 13:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLXN01 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Dec 2020 08:26:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9648 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLXN00 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Dec 2020 08:26:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1rR03Cw7z15jDV;
        Thu, 24 Dec 2020 21:25:00 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:25:37 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <b.zolnierkie@samsung.com>, <dri-devel@lists.freedesktop.org>,
        <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] vermilion.c: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:26:14 +0800
Message-ID: <20201224132614.31846-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

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

