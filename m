Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF048C43462
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42936115C
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Apr 2021 09:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhDIJnl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Apr 2021 05:43:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16118 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhDIJni (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Apr 2021 05:43:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGtRq6rH5z19L9M;
        Fri,  9 Apr 2021 17:41:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:18 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] video: fbdev: vermilion: use DEFINE_MUTEX() for mutex lock and LIST_HEAD() for list head
Date:   Fri, 9 Apr 2021 17:51:43 +0800
Message-ID: <20210409095143.2294091-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().
list head can be initialized automatically with LIST_HEAD()
rather than explicitly calling INIT_LIST_HEAD().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/video/fbdev/vermilion/vermilion.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index ff61605b8764..689170d25bc8 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -35,9 +35,9 @@
 
 #define VML_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)) >> 16)
 
-static struct mutex vml_mutex;
-static struct list_head global_no_mode;
-static struct list_head global_has_mode;
+static DEFINE_MUTEX(vml_mutex);
+static LIST_HEAD(global_no_mode);
+static LIST_HEAD(global_has_mode);
 static struct fb_ops vmlfb_ops;
 static struct vml_sys *subsys = NULL;
 static char *vml_default_mode = "1024x768@60";
@@ -1058,9 +1058,6 @@ static int __init vmlfb_init(void)
 #endif
 
 	printk(KERN_DEBUG MODULE_NAME ": initializing\n");
-	mutex_init(&vml_mutex);
-	INIT_LIST_HEAD(&global_no_mode);
-	INIT_LIST_HEAD(&global_has_mode);
 
 	return pci_register_driver(&vmlfb_pci_driver);
 }

