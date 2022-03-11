Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CEC433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Mar 2022 02:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiCKC7D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiCKC7C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Mar 2022 21:59:02 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 18:57:57 PST
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E30506C5;
        Thu, 10 Mar 2022 18:57:56 -0800 (PST)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 11 Mar
 2022 10:56:53 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 11 Mar
 2022 10:56:50 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <deller@gmx.de>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] video: fbdev: fix warning comparing pointer to 0
Date:   Fri, 11 Mar 2022 10:56:48 +0800
Message-ID: <1646967409-27868-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix the following coccicheck warning:
drivers/video/fbdev/offb.c:415:13-14: WARNING comparing pointer to 0

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/video/fbdev/offb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 4501e84..afdb6aa 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -412,7 +412,7 @@ static void __init offb_init_fb(const char *name,
 
 	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
 
-	if (info == 0) {
+	if (!info) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-- 
2.7.4

