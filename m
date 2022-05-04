Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C04C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 13:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350644AbiEDNtT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350790AbiEDNs6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 09:48:58 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25408559E;
        Wed,  4 May 2022 06:45:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VCBzW9x_1651671915;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCBzW9x_1651671915)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 May 2022 21:45:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     deller@gmx.de
Cc:     adaplas@gmail.com, thomas@winischhofer.net,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] video: fbdev: clean up some inconsistent indenting
Date:   Wed,  4 May 2022 21:45:14 +0800
Message-Id: <20220504134514.19623-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Eliminate the follow smatch warnings:
drivers/video/fbdev/nvidia/nv_hw.c:1512 NVLoadStateExt() warn:
inconsistent indenting
drivers/video/fbdev/sis/sis_main.c:4265 sisfb_post_300_rwtest() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/video/fbdev/nvidia/nv_hw.c | 8 ++++----
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_hw.c b/drivers/video/fbdev/nvidia/nv_hw.c
index 9b0a324bb1b4..75afaa07e7eb 100644
--- a/drivers/video/fbdev/nvidia/nv_hw.c
+++ b/drivers/video/fbdev/nvidia/nv_hw.c
@@ -1509,10 +1509,10 @@ void NVLoadStateExt(struct nvidia_par *par, RIVA_HW_STATE * state)
 	NV_WR32(par->PFIFO, 0x0495 * 4, 0x00000001);
 	NV_WR32(par->PFIFO, 0x0140 * 4, 0x00000001);
 
-    if (!state) {
-	    par->CurrentState = NULL;
-	    return;
-    }
+	if (!state) {
+		par->CurrentState = NULL;
+		return;
+	}
 
 	if (par->Architecture >= NV_ARCH_10) {
 		if (par->twoHeads) {
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index f28fd69d5eb7..07acbe72fbaa 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -4262,7 +4262,7 @@ static int sisfb_post_300_rwtest(struct sis_video_info *ivideo, int iteration,
 	unsigned int k, RankCapacity, PageCapacity, BankNumHigh, BankNumMid;
 	unsigned int PhysicalAdrOtherPage, PhysicalAdrHigh, PhysicalAdrHalfPage;
 
-	 for(k = 0; k < ARRAY_SIZE(SiS_DRAMType); k++) {
+	for (k = 0; k < ARRAY_SIZE(SiS_DRAMType); k++) {
 
 		RankCapacity = buswidth * SiS_DRAMType[k][3];
 
-- 
2.20.1.7.g153144c

