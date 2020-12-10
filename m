Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F9BC4361B
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Dec 2020 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2037C2310D
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Dec 2020 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbgLJOul (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:50:41 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:24003 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389634AbgLJOud (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Dec 2020 09:50:33 -0500
Received: from localhost.localdomain ([92.131.12.169])
        by mwinf5d15 with ME
        id 2eoj2400H3eqQsk03eokPw; Thu, 10 Dec 2020 15:48:48 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Dec 2020 15:48:48 +0100
X-ME-IP: 92.131.12.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     daniel.vetter@ffwll.ch, grandmaster@al2klimov.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] video: fbdev: Use framebuffer_release instead of kfree to free a frame buffer
Date:   Thu, 10 Dec 2020 15:48:08 +0100
Message-Id: <20201210144808.64384-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use 'framebuffer_release()' instead of 'kfree()' to undo a
'framebuffer_alloc()' call, both in the error handling path of the probe
function and in remove function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/ep93xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index ba33b4dce0df..80a70e5796b8 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -566,7 +566,7 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 failed_videomem:
 	fb_dealloc_cmap(&info->cmap);
 failed_cmap:
-	kfree(info);
+	framebuffer_release(info);
 
 	return err;
 }
@@ -584,7 +584,7 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 	if (fbi->mach_info->teardown)
 		fbi->mach_info->teardown(pdev);
 
-	kfree(info);
+	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.27.0

