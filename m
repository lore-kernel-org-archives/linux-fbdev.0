Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE98C6FA86
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Sep 2022 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiINKYD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiINKX1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Sep 2022 06:23:27 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E997B78D;
        Wed, 14 Sep 2022 03:23:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPn2vp8_1663151001;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPn2vp8_1663151001)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 18:23:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] video: fbdev: arkfb: Remove the unused function dac_read_reg()
Date:   Wed, 14 Sep 2022 18:23:01 +0800
Message-Id: <20220914102301.87981-3-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220914102301.87981-1-jiapeng.chong@linux.alibaba.com>
References: <20220914102301.87981-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The function dac_read_reg() is defined in the arkfb.c file, but not
called elsewhere, so delete this unused function.

drivers/video/fbdev/arkfb.c:322:18: warning: unused function 'dac_read_reg'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2155
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/video/fbdev/arkfb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index a317d9fe1d67..5f8fec9e5fd4 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -318,14 +318,6 @@ struct dac_info
 	void *data;
 };
 
-
-static inline u8 dac_read_reg(struct dac_info *info, u8 reg)
-{
-	u8 code[2] = {reg, 0};
-	info->dac_read_regs(info->data, code, 1);
-	return code[1];
-}
-
 static inline void dac_read_regs(struct dac_info *info, u8 *code, int count)
 {
 	info->dac_read_regs(info->data, code, count);
-- 
2.20.1.7.g153144c

