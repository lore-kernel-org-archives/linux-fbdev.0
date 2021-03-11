Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30355C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Mar 2021 12:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7E564FA7
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Mar 2021 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhCKMyf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:54:35 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:59340 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhCKMWE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Mar 2021 07:22:04 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A611A40013E;
        Thu, 11 Mar 2021 20:14:16 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Wang Qing <wangqing@vivo.com>, Sam Ravnborg <sam@ravnborg.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: delete redundant printing of return value
Date:   Thu, 11 Mar 2021 20:14:09 +0800
Message-Id: <1615464851-18433-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkxITE8YGE9DTB9JVkpNSk5PTU9DTkxLT05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NE06Hzo*Cj8JCwIMEQ8BThcd
        N0wwCSxVSlVKTUpOT01PQ05MSEJIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQk1LNwY+
X-HM-Tid: 0a7821357d84d991kuwsa611a40013e
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/fbdev/pxafb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index f1551e0..780ac1f
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2326,11 +2326,9 @@ static int pxafb_probe(struct platform_device *dev)
 	}
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no IRQ defined\n");
+	if (irq < 0)
 		ret = -ENODEV;
 		goto failed_free_mem;
-	}
 
 	ret = devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fbi);
 	if (ret) {
-- 
2.7.4

