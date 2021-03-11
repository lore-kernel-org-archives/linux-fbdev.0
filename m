Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEBC433E9
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Mar 2021 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290C664FE0
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Mar 2021 12:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhCKMWf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:22:35 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:59314 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhCKMWE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Mar 2021 07:22:04 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id B49D9400279;
        Thu, 11 Mar 2021 20:14:32 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] video: fbdev: delete redundant printing of return value
Date:   Thu, 11 Mar 2021 20:14:27 +0800
Message-Id: <1615464868-18594-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS0pOSUxKQkpDHk8dVkpNSk5PTU9DTEhLSUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46FSo6NT8NEwIVPw4sThYR
        Dk4KCh9VSlVKTUpOT01PQ0xISENPVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSkxCSDcG
X-HM-Tid: 0a782135bbfad991kuwsb49d9400279
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

platform_get_irq() has already checked and printed the return value, 
the printing here is nothing special, it is not necessary at all.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/fbdev/s3c2410fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index d8ae525..72dd092
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -847,10 +847,8 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), &pdev->dev);
 	if (!fbinfo)
-- 
2.7.4

