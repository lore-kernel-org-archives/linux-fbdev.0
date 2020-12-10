Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E9C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Dec 2020 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04DD2310E
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Dec 2020 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgLJOwH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:52:07 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:23558 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391867AbgLJOvx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Dec 2020 09:51:53 -0500
Received: from localhost.localdomain ([92.131.12.169])
        by mwinf5d15 with ME
        id 2eq8240093eqQsk03eq8ax; Thu, 10 Dec 2020 15:50:09 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Dec 2020 15:50:09 +0100
X-ME-IP: 92.131.12.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     daniel.vetter@ffwll.ch, grandmaster@al2klimov.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] video: fbdev: Fix a dev_err format specifier
Date:   Thu, 10 Dec 2020 15:49:32 +0100
Message-Id: <20201210144932.64436-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

'phys_addr' is of type 'dma_addr_t'.
Use '%pad' instead of '%x' to print this variable in an error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/ep93xx-fb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 80a70e5796b8..6b5a63b80ffa 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -436,9 +436,8 @@ static int ep93xxfb_alloc_videomem(struct fb_info *info)
 	 * least.
 	 */
 	if (check_screenpage_bug && phys_addr & (1 << 27)) {
-		dev_err(info->dev, "ep93xx framebuffer bug. phys addr (0x%x) "
-			"has bit 27 set: cannot init framebuffer\n",
-			phys_addr);
+		dev_err(info->dev, "ep93xx framebuffer bug. phys addr (%pad) has bit 27 set: cannot init framebuffer\n",
+			&phys_addr);
 
 		dma_free_coherent(info->dev, fb_size, virt_addr, phys_addr);
 		return -ENOMEM;
-- 
2.27.0

