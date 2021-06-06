Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C5C47096
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Jun 2021 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C503610E7
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Jun 2021 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFFPsZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Jun 2021 11:48:25 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:43101 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhFFPsV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Jun 2021 11:48:21 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d04 with ME
        id DrmV2500P21Fzsu03rmVAo; Sun, 06 Jun 2021 17:46:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 06 Jun 2021 17:46:30 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     spock@gentoo.org, adaplas@gmail.com, akpm@linux-foundation.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] video: fbdev: uvesafb: Fixes an error handling path in 'uvesafb_probe()'
Date:   Sun,  6 Jun 2021 17:46:28 +0200
Message-Id: <dd2a4806d3a570ab84947806f38a494454fd0245.1622994310.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If an error occurs after a successful 'uvesafb_init_mtrr()' call, it must
be undone by a corresponding 'arch_phys_wc_del()' call, as already done in
the remove function.

This has been added in the remove function in commit 63e28a7a5ffc
("uvesafb: Clean up MTRR code")

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Unsure about the Fixes tag, maybe it is 63e28a7a5ffc
---
 drivers/video/fbdev/uvesafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 4df6772802d7..a7e606520dfc 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1757,6 +1757,7 @@ static int uvesafb_probe(struct platform_device *dev)
 
 out_unmap:
 	iounmap(info->screen_base);
+	arch_phys_wc_del(par->mtrr_handle);
 out_mem:
 	release_mem_region(info->fix.smem_start, info->fix.smem_len);
 out_reg:
-- 
2.30.2

