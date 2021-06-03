Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8207C47097
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5FE613AE
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFCIBP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Jun 2021 04:01:15 -0400
Received: from m12-13.163.com ([220.181.12.13]:48155 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFCIBO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 3 Jun 2021 04:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MG1lq
        JY+aPmdBeo5Cm5Dp5IGRQlMjpO0NQ3s+uGv+kQ=; b=a+XG4OMJ+CIqHv0EbzAJ+
        WDYDdmOIIf8ysFxEUcY9A28yGFGuRiUCsu6+eHsL65mKxwbL2V7YzyqYeccMqkQW
        bs7ajAK9upgk58Sm50cAelmz1ajbOMu8/BgVPyY69+uaILUZdw30ED7nvEiT/aKI
        YzWxDP1XXMQrfLRvBXB/YA=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowABHT7vbi7hgTcsYEQ--.16506S2;
        Thu, 03 Jun 2021 15:59:24 +0800 (CST)
From:   lijian_8010a29@163.com
To:     FlorianSchandinat@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: via: viafbdev.c:  Fix a typo
Date:   Thu,  3 Jun 2021 15:58:26 +0800
Message-Id: <20210603075826.64932-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABHT7vbi7hgTcsYEQ--.16506S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4kAw4xJF15AF1DJF48Xrb_yoWfGFX_Cr
        1kZr9rXryvvw40kryrta17uFWqyrW7ZFn3XF42gr93CFW7Zr1rZr1UZFn2qrWjgF47XFyD
        Wr4agws5CryfCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe5UUUUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbi3xymUGB0GawFEgAAsD
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'ouput' to 'output'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 22deb340a048..86a8f080bb97 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -766,7 +766,7 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	if (info->flags & FBINFO_HWACCEL_DISABLED || info != viafbinfo)
 		return -ENODEV;
 
-	/* LCD ouput does not support hw cursors (at least on VN896) */
+	/* LCD output does not support hw cursors (at least on VN896) */
 	if ((chip_name == UNICHROME_CLE266 && viapar->iga_path == IGA2) ||
 		viafb_LCD_ON)
 		return -ENODEV;
-- 
2.25.1


