Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771BC4332F
	for <linux-fbdev@archiver.kernel.org>; Sat, 10 Dec 2022 11:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLJLnR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 10 Dec 2022 06:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLJLnQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 10 Dec 2022 06:43:16 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Dec 2022 03:43:05 PST
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA7E1140B9
        for <linux-fbdev@vger.kernel.org>; Sat, 10 Dec 2022 03:43:05 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 3y8gpaJiRNF1W3y8gp0xrM; Sat, 10 Dec 2022 12:35:32 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 12:35:32 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michal Januszewski <spock@gentoo.org>,
        Helge Deller <deller@gmx.de>,
        Antonino Daplas <adaplas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] video: fbdev: uvesafb: Fixes an error handling path in uvesafb_probe()
Date:   Sat, 10 Dec 2022 12:35:22 +0100
Message-Id: <0eba6acb70fa1270d8cf798afd11ce342aa7e8e1.1670671944.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If an error occurs after a successful uvesafb_init_mtrr() call, it must be
undone by a corresponding arch_phys_wc_del() call, as already done in the
remove function.

This has been added in the remove function in commit 63e28a7a5ffc
("uvesafb: Clean up MTRR code")

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Unsure about the Fixes tag, maybe it is 63e28a7a5ffc

Change in v2:
  - add arch_phys_wc_del() at the right place in the error handling path

v1 (a long time ago!):
https://lore.kernel.org/all/dd2a4806d3a570ab84947806f38a494454fd0245.1622994310.git.christophe.jaillet@wanadoo.fr/
---
 drivers/video/fbdev/uvesafb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 00d789b6c0fa..0e3cabbec4b4 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1758,6 +1758,7 @@ static int uvesafb_probe(struct platform_device *dev)
 out_unmap:
 	iounmap(info->screen_base);
 out_mem:
+	arch_phys_wc_del(par->mtrr_handle);
 	release_mem_region(info->fix.smem_start, info->fix.smem_len);
 out_reg:
 	release_region(0x3c0, 32);
-- 
2.34.1

