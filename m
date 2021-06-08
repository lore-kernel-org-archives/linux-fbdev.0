Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD73CC47082
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Jun 2021 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4CE61185
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Jun 2021 12:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhFHMQJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:16:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3799 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhFHMQJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Jun 2021 08:16:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzpv80J0FzWsdF;
        Tue,  8 Jun 2021 20:09:24 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:14:14 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:14:14 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <daniel.vetter@ffwll.ch>, <penguin-kernel@i-love.sakura.ne.jp>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] fbdev: convert list_for_each to entry variant
Date:   Tue, 8 Jun 2021 20:32:49 +0800
Message-ID: <1623155569-61744-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 65dae05..753ecc8 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -130,14 +130,12 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 	struct fb_var_screeninfo var;
 	struct fb_modelist *modelist;
 	struct fb_videomode *mode;
-	struct list_head *pos;
 	size_t i;
 	int err;
 
 	memset(&var, 0, sizeof(var));
 
-	list_for_each(pos, &fb_info->modelist) {
-		modelist = list_entry(pos, struct fb_modelist, list);
+	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
@@ -198,13 +196,11 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	unsigned int i;
-	struct list_head *pos;
 	struct fb_modelist *modelist;
 	const struct fb_videomode *mode;
 
 	i = 0;
-	list_for_each(pos, &fb_info->modelist) {
-		modelist = list_entry(pos, struct fb_modelist, list);
+	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, i, mode);
 	}
-- 
2.6.2

