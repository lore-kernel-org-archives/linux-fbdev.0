Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33CBC433DB
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6461364EE1
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 04:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhCAEIR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 28 Feb 2021 23:08:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13388 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhCAEIN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 28 Feb 2021 23:08:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dpmrq0xQxz7rVY;
        Mon,  1 Mar 2021 12:05:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 12:07:22 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <daniel.vetter@ffwll.ch>, <grandmaster@al2klimov.de>,
        <dri-devel@lists.freedesktop.org>
CC:     <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] video: fbdev: fix use of 'dma_map_single'
Date:   Mon, 1 Mar 2021 12:05:09 +0800
Message-ID: <1614571509-40078-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

DMA_TO_DEVICE synchronisation must be done after the last modification
of the memory region by the software and before it is handed off to
the device.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/video/fbdev/grvga.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index 24818b2..25ae9ef 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -435,6 +435,8 @@ static int grvga_probe(struct platform_device *dev)
 			retval = -ENOMEM;
 			goto dealloc_cmap;
 		}
+
+		memset((unsigned long *) virtual_start, 0, grvga_mem_size);
 	} else {	/* Allocate frambuffer memory */
 
 		unsigned long page;
@@ -449,6 +451,7 @@ static int grvga_probe(struct platform_device *dev)
 			goto dealloc_cmap;
 		}
 
+		memset((unsigned long *) virtual_start, 0, grvga_mem_size);
 		physical_start = dma_map_single(&dev->dev, (void *)virtual_start, grvga_mem_size, DMA_TO_DEVICE);
 
 		/* Set page reserved so that mmap will work. This is necessary
@@ -463,8 +466,6 @@ static int grvga_probe(struct platform_device *dev)
 		par->fb_alloced = 1;
 	}
 
-	memset((unsigned long *) virtual_start, 0, grvga_mem_size);
-
 	info->screen_base = (char __iomem *) virtual_start;
 	info->fix.smem_start = physical_start;
 	info->fix.smem_len   = grvga_mem_size;
-- 
2.8.1

