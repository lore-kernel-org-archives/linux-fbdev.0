Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEDEC4338F
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Aug 2021 14:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6932361077
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Aug 2021 14:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhHLOEK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:04:10 -0400
Received: from mx21.baidu.com ([220.181.3.85]:50538 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235893AbhHLOEK (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Aug 2021 10:04:10 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id 3682D7A95E85EEDD6734;
        Thu, 12 Aug 2021 22:03:40 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 12 Aug 2021 22:03:40 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 12 Aug 2021 22:03:39 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] video: fbdev: au1200fb: Make use of dma_mmap_coherent()
Date:   Thu, 12 Aug 2021 22:03:32 +0800
Message-ID: <20210812140332.506-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-MAIL-EX04.internal.baidu.com (10.127.64.14) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

replace dma_mmap_attrs() with dma_mmap_coherent() kindly.
BTW, fix indentation.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/video/fbdev/au1200fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index c00e01a17368..81c315454428 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1233,8 +1233,8 @@ static int au1200fb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	struct au1200fb_device *fbdev = info->par;
 
-	return dma_mmap_attrs(fbdev->dev, vma, fbdev->fb_mem, fbdev->fb_phys,
-			fbdev->fb_len, 0);
+	return dma_mmap_coherent(fbdev->dev, vma,
+				 fbdev->fb_mem, fbdev->fb_phys, fbdev->fb_len);
 }
 
 static void set_global(u_int cmd, struct au1200_lcd_global_regs_t *pdata)
-- 
2.25.1

