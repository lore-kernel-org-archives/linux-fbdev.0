Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DC4C6FA8A
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Sep 2022 10:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiINKYE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Sep 2022 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiINKXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Sep 2022 06:23:23 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE07C324;
        Wed, 14 Sep 2022 03:23:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VPn2vi9_1663150986;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VPn2vi9_1663150986)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 18:23:16 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] video: fbdev: controlfb: Remove the unused function VAR_MATCH()
Date:   Wed, 14 Sep 2022 18:22:59 +0800
Message-Id: <20220914102301.87981-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The function VAR_MATCH is defined in the controlfb.c file, but not
called elsewhere, so delete this unused function.

drivers/video/fbdev/controlfb.c:111:19: warning: unused function 'VAR_MATCH'.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2153
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/video/fbdev/controlfb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index aba46118b208..6bbcd9fc864e 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -108,13 +108,6 @@ static inline int PAR_EQUAL(struct fb_par_control *x, struct fb_par_control *y)
 	return (!DIRTY(cmode) && !DIRTY(xres) && !DIRTY(yres)
 		&& !DIRTY(vxres) && !DIRTY(vyres));
 }
-static inline int VAR_MATCH(struct fb_var_screeninfo *x, struct fb_var_screeninfo *y)
-{
-	return (!DIRTY(bits_per_pixel) && !DIRTY(xres)
-		&& !DIRTY(yres) && !DIRTY(xres_virtual)
-		&& !DIRTY(yres_virtual)
-		&& !DIRTY_CMAP(red) && !DIRTY_CMAP(green) && !DIRTY_CMAP(blue));
-}
 
 struct fb_info_control {
 	struct fb_info		info;
-- 
2.20.1.7.g153144c

