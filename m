Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CDBC433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Nov 2021 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23C261205
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Nov 2021 11:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhKDLzO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDLzO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 4 Nov 2021 07:55:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B40C061714;
        Thu,  4 Nov 2021 04:52:36 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bq14so5349853qkb.1;
        Thu, 04 Nov 2021 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEj6bCr3w4Ms+m1RU60Hcm+FAOJ4d8yd2N73VNFTfd0=;
        b=mrQ6Of4s3v6Ccg2apzzdjspvbk4NPScYzDtabmQaAxEJC4iNw07qwda1qNANqY7KAP
         190e52AZEmBu6AEgJ3Z+CjLLNUkXu165GhxjZYEhrA0YQXcs82bQTLA9EaC+h0W5BkKi
         gxvo+nAxW+5GydXQjsDCm9VWwaPlx+VHVBW5AAKLyutWREknBPPCwjM8g8qIYvVTJzNr
         CdUdoGuZZtLKhoXvxZsDrG4DJsq4sCGMrlP2y0/jJF0G2xHl7sSUs2995xWilz7vf2EP
         tglOuG4jFfnp4TxHjnxUeFZbm6HzBSJXjMjhvh/E5+o610CgLRAwB8U+3LBFz7lvdKtt
         64Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEj6bCr3w4Ms+m1RU60Hcm+FAOJ4d8yd2N73VNFTfd0=;
        b=jnlbyoOvmaW0BLSAAjm7R16Zs5n88tUG9sdDF6dLctvg1vgAfLBGX0GulV12ny6UB9
         /ZI/nJNkfbW+SOrda0AtWHLyADL7xDS+7cMw4uzZqVC/5a5frxlAU2hycPEy4mMHMVm8
         BM+OFy3PSUUwwu16eylFPOArSY7j53zI2xU/M/zKkuch0ooMFVMUiOSnV7eu2keZIv8J
         rJocNwpyhpTQbaBLhvFPrjdKJJrExpcKAbOfmdCpBI9eNxAzDyr7anK0fPFshuNz6NAa
         qQO4v1EfGPRt+1hzKiMyKmyQIaYuSyYNsI5nXP6jF+I3THfZIpM1q65owoiShFNQ5ZuO
         oOnA==
X-Gm-Message-State: AOAM530LGgLaKwaYBm40Nc87g+hLnVg9GxGwLhIIe3HMK+uEu7hlpS28
        V/XGGNsZpnjaWP4E9jKbt/e1TOg/S2w=
X-Google-Smtp-Source: ABdhPJwNewhxjYRmZA4neTjQcNtlBxYfKrJlI3qVWNpGxig3My1dBO3r00nsSgxuR5nIx8p0PRZhSA==
X-Received: by 2002:a05:620a:4411:: with SMTP id v17mr39322514qkp.431.1636026755561;
        Thu, 04 Nov 2021 04:52:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o20sm3532718qkp.100.2021.11.04.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:52:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     bernie@plugable.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] video: udlfb: replace snprintf in show functions with  sysfs_emit
Date:   Thu,  4 Nov 2021 11:52:29 +0000
Message-Id: <20211104115229.31821-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/video/fbdev/udlfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index b9cdd02c1000..90f48b71fd8f 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1426,7 +1426,7 @@ static ssize_t metrics_bytes_rendered_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			atomic_read(&dlfb->bytes_rendered));
 }
 
@@ -1434,7 +1434,7 @@ static ssize_t metrics_bytes_identical_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			atomic_read(&dlfb->bytes_identical));
 }
 
@@ -1442,7 +1442,7 @@ static ssize_t metrics_bytes_sent_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			atomic_read(&dlfb->bytes_sent));
 }
 
@@ -1450,7 +1450,7 @@ static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-	return snprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			atomic_read(&dlfb->cpu_kcycles_used));
 }
 
-- 
2.25.1

