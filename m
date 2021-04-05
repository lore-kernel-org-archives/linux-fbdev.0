Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A973C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon,  5 Apr 2021 10:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191D761278
	for <linux-fbdev@archiver.kernel.org>; Mon,  5 Apr 2021 10:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhDEKAr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 5 Apr 2021 06:00:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhDEKAq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 5 Apr 2021 06:00:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDR0z32CGznYlh;
        Mon,  5 Apr 2021 17:57:55 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 18:00:31 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] backlight: backlight: Use DEFINE_MUTEX() for mutex lock
Date:   Mon, 5 Apr 2021 18:14:40 +0800
Message-ID: <20210405101440.14937-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/video/backlight/backlight.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 537fe1b376ad..d7a09c422547 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -64,7 +64,7 @@
  */
 
 static struct list_head backlight_dev_list;
-static struct mutex backlight_dev_list_mutex;
+static DEFINE_MUTEX(backlight_dev_list_mutex);
 static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
@@ -757,7 +757,6 @@ static int __init backlight_class_init(void)
 	backlight_class->dev_groups = bl_device_groups;
 	backlight_class->pm = &backlight_class_dev_pm_ops;
 	INIT_LIST_HEAD(&backlight_dev_list);
-	mutex_init(&backlight_dev_list_mutex);
 	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
 	return 0;

