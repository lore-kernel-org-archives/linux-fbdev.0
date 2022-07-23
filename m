Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA85CCA48C
	for <linux-fbdev@archiver.kernel.org>; Sat, 23 Jul 2022 17:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiGWR6N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 23 Jul 2022 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiGWR6A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 23 Jul 2022 13:58:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BC1AD98
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Jul 2022 10:57:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oFJNq-0007Ta-NT; Sat, 23 Jul 2022 19:57:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oFJNo-002l3q-OS; Sat, 23 Jul 2022 19:57:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oFJNn-007377-W8; Sat, 23 Jul 2022 19:57:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] video: fb: imxfb: Convert request_mem_region + ioremap to devm_ioremap_resource
Date:   Sat, 23 Jul 2022 19:57:20 +0200
Message-Id: <20220723175720.76933-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723175720.76933-1-u.kleine-koenig@pengutronix.de>
References: <20220723175720.76933-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2623; h=from:subject; bh=Sy7hObGjRzDQwuWl0g+BIDpZmNz70z1J61p/X002VA4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi3DZ7c07zI1Wue2I1wIRCwc9P6REz8lW6VqXalEtb /3TjSj+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtw2ewAKCRDB/BR4rcrsCZt6CA CLEMPoV04R060xaKZZ4hha1Qld9Qp9OSVf7Fn8V+8ec7pQIzNgbW/x4AP/7wZt+mLjpXUSh5n0cSeA K1yX01Rh/CSBQYZSmqclsvspVprvjj6JrHzUfEQsuaT7ngvBIbHctZRaKT8UwsHv+ElUtIj6BBAiDG Fa3/JVJ+Kv/8+jOAJA23hV88Q2eNFdr6L3miMV1OP3o45F0U2w4cTpn5sEgLdJlUeeGfkEDnCaiRJt WA8FZPEQKKwSFJJaaQx0ti3RMMvV5MXa4za222ANSGfkrbvTLC8/Q0NGraPFYqBXD3aYV6gcNfAF3s tuup3wl0PWwnuX5q3xk3sfRpmgNN2m
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This has several advantages:

 - No need for manual undo of the two functions in the error path and
   the remove function.
 - Drops error handling in .remove()
   Note that returning early in .remove() yields resource leaks that
   often result in access of freed memory or unmapped registers later.
 - Fixes a resource leak
   request_mem_region allocates memory for the returned pointer that was
   never freed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/imxfb.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index fa6a19c1ae9b..c48477893dd0 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -937,13 +937,6 @@ static int imxfb_probe(struct platform_device *pdev)
 		info->fix.smem_len = max_t(size_t, info->fix.smem_len,
 				m->mode.xres * m->mode.yres * bytes_per_pixel);
 
-	res = request_mem_region(res->start, resource_size(res),
-				DRIVER_NAME);
-	if (!res) {
-		ret = -EBUSY;
-		goto failed_req;
-	}
-
 	fbi->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(fbi->clk_ipg)) {
 		ret = PTR_ERR(fbi->clk_ipg);
@@ -977,7 +970,7 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_getclock;
 	}
 
-	fbi->regs = ioremap(res->start, resource_size(res));
+	fbi->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (fbi->regs == NULL) {
 		dev_err(&pdev->dev, "Cannot map frame buffer registers\n");
 		ret = -ENOMEM;
@@ -1049,11 +1042,9 @@ static int imxfb_probe(struct platform_device *pdev)
 	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
 failed_map:
-	iounmap(fbi->regs);
 failed_ioremap:
 failed_getclock:
 	release_mem_region(res->start, resource_size(res));
-failed_req:
 failed_of_parse:
 	kfree(info->pseudo_palette);
 failed_init:
@@ -1065,11 +1056,6 @@ static int imxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct imxfb_info *fbi = info->par;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
 
 	imxfb_disable_controller(fbi);
 
@@ -1077,8 +1063,6 @@ static int imxfb_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&info->cmap);
 	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_buffer,
 		    fbi->map_dma);
-	iounmap(fbi->regs);
-	release_mem_region(res->start, resource_size(res));
 	kfree(info->pseudo_palette);
 	framebuffer_release(info);
 
-- 
2.36.1

