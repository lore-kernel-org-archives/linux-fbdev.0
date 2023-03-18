Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875E7C7619A
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCRXys (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCRXyq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD391B2CF
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNm-000425-Ex; Sun, 19 Mar 2023 00:54:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNl-0056Ze-Oj; Sun, 19 Mar 2023 00:54:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNl-005zTw-3x; Sun, 19 Mar 2023 00:54:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 06/51] video: fbdev: bw2: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:53:43 +0100
Message-Id: <20230318235428.272091-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K08anLalQJbiuPYeNp8sUZ/pWKSOh0o3hwGpzmqpom0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk6tGm/Y42xGuS6iVSl4mROLcu/J5whA1KV9n 8CKNpFmSGOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOrQAKCRCPgPtYfRL+ TiLuB/wMk4B8Qjqnz5D+Kxh3phhRyXKqPLa8rnnkDYciv63fUbcy6yL8Q7lerSWtze1Y91EPg/M 1TRyXdE3+Q4vlFC+vZyGFxH+2+mCv0aJgZE30RN4+Fw/DMgKqhn3FXlJFNJFfX03VL4TugdlhGX Is1XHkkYdP8VTOmZiPe5q+zjimLtxpktvTOJk2KEtD/xwQZqedzXM7KjAIy9mtoGI29gVf1Wv+h rBYfOteradUM8rkcbApakKCJqoX6THfqMBs7qL2BbCq+iLiqnbQBkt3R06x/GGNRFo5l0nyYQ+N WPdw+sxrN8ed8YVlJvbNpgvzdKRBOnmxSn3VR+FxvqEwSiI+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/bw2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/bw2.c b/drivers/video/fbdev/bw2.c
index 6403ae07970d..ddd45048a131 100644
--- a/drivers/video/fbdev/bw2.c
+++ b/drivers/video/fbdev/bw2.c
@@ -352,7 +352,7 @@ static int bw2_probe(struct platform_device *op)
 	return err;
 }
 
-static int bw2_remove(struct platform_device *op)
+static void bw2_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct bw2_par *par = info->par;
@@ -363,8 +363,6 @@ static int bw2_remove(struct platform_device *op)
 	of_iounmap(&op->resource[0], info->screen_base, info->fix.smem_len);
 
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static const struct of_device_id bw2_match[] = {
@@ -381,7 +379,7 @@ static struct platform_driver bw2_driver = {
 		.of_match_table = bw2_match,
 	},
 	.probe		= bw2_probe,
-	.remove		= bw2_remove,
+	.remove_new	= bw2_remove,
 };
 
 static int __init bw2_init(void)
-- 
2.39.2

