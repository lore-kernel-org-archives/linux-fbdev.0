Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB5C4338F
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Aug 2021 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DBC60041
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Aug 2021 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhHKQ6w (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Aug 2021 12:58:52 -0400
Received: from mail.ispras.ru ([83.149.199.84]:37606 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhHKQ6v (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Aug 2021 12:58:51 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id DA74440A2BD8;
        Wed, 11 Aug 2021 16:58:26 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     dri-devel@lists.freedesktop.org
Cc:     Evgeny Novikov <novikov@ispras.ru>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>
Subject: [PATCH] video: fbdev: w100fb: Reset global state
Date:   Wed, 11 Aug 2021 19:58:26 +0300
Message-Id: <20210811165826.23752-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

w100fb_probe() did not reset the global state to its initial state. This
can result in invocation of iounmap() even when there was not the
appropriate successful call of ioremap(). For instance, this may be the
case if first probe fails after two successful ioremap() while second
probe fails when first ioremap() fails. The similar issue is with
w100fb_remove(). The patch fixes both bugs.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
---
 drivers/video/fbdev/w100fb.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index d96ab28f8ce4..4e641a780726 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -770,12 +770,18 @@ static int w100fb_probe(struct platform_device *pdev)
 		fb_dealloc_cmap(&info->cmap);
 		kfree(info->pseudo_palette);
 	}
-	if (remapped_fbuf != NULL)
+	if (remapped_fbuf != NULL) {
 		iounmap(remapped_fbuf);
-	if (remapped_regs != NULL)
+		remapped_fbuf = NULL;
+	}
+	if (remapped_regs != NULL) {
 		iounmap(remapped_regs);
-	if (remapped_base != NULL)
+		remapped_regs = NULL;
+	}
+	if (remapped_base != NULL) {
 		iounmap(remapped_base);
+		remapped_base = NULL;
+	}
 	if (info)
 		framebuffer_release(info);
 	return err;
@@ -795,8 +801,11 @@ static int w100fb_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&info->cmap);
 
 	iounmap(remapped_base);
+	remapped_base = NULL;
 	iounmap(remapped_regs);
+	remapped_regs = NULL;
 	iounmap(remapped_fbuf);
+	remapped_fbuf = NULL;
 
 	framebuffer_release(info);
 
-- 
2.26.2

