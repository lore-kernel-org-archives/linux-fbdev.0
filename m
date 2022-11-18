Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E9C4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Nov 2022 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbiKRJC3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiKRJCS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Nov 2022 04:02:18 -0500
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD2D85A13;
        Fri, 18 Nov 2022 01:02:17 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id CD3DE1E80D9F;
        Fri, 18 Nov 2022 16:58:49 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k8SQIVuQR-0f; Fri, 18 Nov 2022 16:58:47 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 51EE31E80D70;
        Fri, 18 Nov 2022 16:58:40 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] video: fbdev: fix spelling mistake "paramaters"->"parameters"
Date:   Fri, 18 Nov 2022 17:00:50 +0800
Message-Id: <20221118090050.22148-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There is a spelling mistake in comment. Fix it.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/video/fbdev/controlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 6bbcd9fc864e..77dbf94aae5f 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -376,7 +376,7 @@ static int read_control_sense(struct fb_info_control *p)
 #define CONTROL_PIXCLOCK_MIN	5000	/* ~ 200 MHz dot clock */
 
 /*
- * calculate the clock paramaters to be sent to CUDA according to given
+ * calculate the clock parameters to be sent to CUDA according to given
  * pixclock in pico second.
  */
 static int calc_clock_params(unsigned long clk, unsigned char *param)
-- 
2.11.0

