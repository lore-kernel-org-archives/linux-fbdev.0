Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB5C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 06:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiBAG0l (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 01:26:41 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57970 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234051AbiBAG0l (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 01:26:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V3Mz0Lg_1643696798;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3Mz0Lg_1643696798)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Feb 2022 14:26:39 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] video: fbdev: pxa3xx-gcu: Remove unnecessary print function dev_err()
Date:   Tue,  1 Feb 2022 14:26:33 +0800
Message-Id: <20220201062633.102519-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220201062633.102519-1-yang.lee@linux.alibaba.com>
References: <20220201062633.102519-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warning:
./drivers/video/fbdev/pxa3xx-gcu.c:615:2-9: line 615 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 9239ecd34169..ea52c018bb51 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -612,7 +612,6 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	/* request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no IRQ defined: %d\n", irq);
 		return irq;
 	}
 
-- 
2.20.1.7.g153144c

