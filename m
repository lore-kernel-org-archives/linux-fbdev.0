Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A3C47083
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 03:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8859761396
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Jun 2021 03:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFBD1f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Jun 2021 23:27:35 -0400
Received: from m12-16.163.com ([220.181.12.16]:58171 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhFBD1f (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Jun 2021 23:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hCjNx
        bHkM7idDtVYQL2Q4f8U61IqG0gepdecr463U5U=; b=S4qRZUn8nSOGPmxQ0Nugq
        H6nwe8dTK5MEX9MBMAqZXiuuDfFX+pLQHr1dvfqrVPrvcLMcFxxRsuJ0Ljtf/RCW
        hKl4+LT8Fr66YZ4ISIPYAWuDn+MapflAGGen2cPshvAMUoi/8KxSXQl352cNYhu8
        lDSMGwe4Io5S0ntMk5Myok=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAA3PBg8+rZgOTXqug--.28168S2;
        Wed, 02 Jun 2021 11:25:49 +0800 (CST)
From:   lijian_8010a29@163.com
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: kyro: STG4000OverlayDevice.c: Fix a typo
Date:   Wed,  2 Jun 2021 11:24:50 +0800
Message-Id: <20210602032450.90703-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAA3PBg8+rZgOTXqug--.28168S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DWrWUur4rKr1rAF1fJFb_yoW3KFg_Cw
        1IvFsxX3y8GFW0g3ZxJry3ZryYvFWUZr95WF1qqas5Xry3X393Xw4jvr18KrnYqrZxu3Zr
        WFsFqr4rA3yfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnu6wJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBER2lUFaEEj9bzwAAsS
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'thses' to 'these'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 7a09178024a6..46f17020c8cd 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -60,7 +60,10 @@ typedef struct _OVRL_SRC_DEST {
 	u32 ulDstX2;
 	u32 ulDstY2;
 
-	/*clipped pixel pos of source data within buffer thses need to be 128 bit word aligned */
+	/*
+	 * clipped pixel pos of source data within buffer
+	 * these need to be 128 bit word aligned
+	 */
 	u32 ulSrcX1;
 	u32 ulSrcY1;
 	u32 ulSrcX2;
-- 
2.25.1


