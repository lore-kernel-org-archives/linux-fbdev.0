Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B5C433EF
	for <linux-fbdev@archiver.kernel.org>; Sun,  5 Jun 2022 09:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiFEJA5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 5 Jun 2022 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEJA5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 5 Jun 2022 05:00:57 -0400
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jun 2022 02:00:52 PDT
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92E45529
        for <linux-fbdev@vger.kernel.org>; Sun,  5 Jun 2022 02:00:52 -0700 (PDT)
X-QQ-mid: bizesmtp73t1654419559tv8kcgm9
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 16:59:14 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: DHpJGCbtM4nx5RtduTeQ1jE8RQDF4LyMBrhXEEUK5EHEg7aO/KdFUpyIc2BSy
        yrMUqW6RJu/KdMaqHn7JDRxSJhkSf6H0FZDCWN6wYxoXaFUyorcimuMghjbT+fIYMlZ3ceP
        9+UIYN7uAA1WAyy6HFr1mJfzJHtV6lr3VL54fOqp9ZRrK+vjLHUz9JaOE+dbSl7FZAX8INu
        lg2OcHdwF6v0xvPt0DBQsyIEbosSgH0tizfuxGl1r+PpzLcxVYzyTWKg92tNpqBk7j8pSN2
        mL+Y2oIs/J7hyiv7x6KuIDAkQ4EkPF2X2XRcpzuSyCNQ7Q9y0nalf1x6qEAE8j8NhTyXrXq
        yy4kRcGFg9uwU9D91nCulRkiG+FuQ==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] fbdev: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 16:59:13 +0800
Message-Id: <20220605085913.11682-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Delete the redundant word 'its'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/video/fbdev/skeletonfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/skeletonfb.c b/drivers/video/fbdev/skeletonfb.c
index bcacfb6934fa..3d4d78362ede 100644
--- a/drivers/video/fbdev/skeletonfb.c
+++ b/drivers/video/fbdev/skeletonfb.c
@@ -96,7 +96,7 @@ static const struct fb_fix_screeninfo xxxfb_fix = {
 
     /*
      * 	Modern graphical hardware not only supports pipelines but some 
-     *  also support multiple monitors where each display can have its  
+     *  also support multiple monitors where each display can have
      *  its own unique data. In this case each display could be  
      *  represented by a separate framebuffer device thus a separate 
      *  struct fb_info. Now the struct xxx_par represents the graphics
-- 
2.36.1


