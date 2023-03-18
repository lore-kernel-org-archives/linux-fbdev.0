Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89ECC7618A
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCRXzB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCRXys (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4361C590
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNq-0004Cp-6F; Sun, 19 Mar 2023 00:54:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNp-0056bC-Hz; Sun, 19 Mar 2023 00:54:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNo-005zV7-L5; Sun, 19 Mar 2023 00:54:44 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 24/51] video: fbdev: leo: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:54:01 +0100
Message-Id: <20230318235428.272091-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=F8N/+OapS1TwpsJrOs90b5CY8V/qJ8fAE1hzfGggvEI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk7BKWQ+SA+YbFeTxJkz/hx5Lu2NE7F9gETEo qMte9pIdpOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOwQAKCRCPgPtYfRL+ TttICACoMMt6rMFG4Ga+qTHqxKif2ExJc+e2gl+fHgqfzwVSNVZcOMNfwPtjtRzLt5NaBAA6oNN F8K6J/Nq54H66QnI1HAIiogXodJ/leE88KOgrbCsFi7NIWpFu4HUiQ8IhabdugOAPn6WdwcMa8R IjhkAWdkYLou2rhfUlEdShIupAKZFquH8BRYW07ZjE7x26B7RJ7I1kz5HAilm1w9s7n2dB+csHx n0ejD49jNBnmpSnPmFbCHYGckZpQp15ZvE/a1YgNg/B3u3SrdtsKDa3mLjHZo3IZ7pdaGMtPEbU 65Xjb9dJsts42Jfg/Ki/4roZB3hw4gt1ZKollnScFp7EkTsG
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
 drivers/video/fbdev/leo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/leo.c b/drivers/video/fbdev/leo.c
index 3eb0f3583f4f..3ffc0a725f89 100644
--- a/drivers/video/fbdev/leo.c
+++ b/drivers/video/fbdev/leo.c
@@ -637,7 +637,7 @@ static int leo_probe(struct platform_device *op)
 	return err;
 }
 
-static int leo_remove(struct platform_device *op)
+static void leo_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct leo_par *par = info->par;
@@ -648,8 +648,6 @@ static int leo_remove(struct platform_device *op)
 	leo_unmap_regs(op, info, par);
 
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static const struct of_device_id leo_match[] = {
@@ -666,7 +664,7 @@ static struct platform_driver leo_driver = {
 		.of_match_table = leo_match,
 	},
 	.probe		= leo_probe,
-	.remove		= leo_remove,
+	.remove_new	= leo_remove,
 };
 
 static int __init leo_init(void)
-- 
2.39.2

