Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC6C27C4C
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Oct 2023 21:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjJZVoc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Oct 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344913AbjJZVo2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD231BC
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Oct 2023 14:44:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw89O-0007cQ-WA; Thu, 26 Oct 2023 23:44:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw89O-004Ura-AM; Thu, 26 Oct 2023 23:44:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qw89O-006rNS-16; Thu, 26 Oct 2023 23:44:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH] staging: fbtft: Convert to platform remove callback returning void
Date:   Thu, 26 Oct 2023 23:44:08 +0200
Message-ID: <20231026214407.2508590-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.482.g2e8e77cbac8a.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2581; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=G+dezbZcw7p8pj0N/5GvouqBNElTWjWFFFROrY2tH/s=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSruyu69j2OvejzZcehad9XB2vUzpYz6Jnn5HPK7LxhY X/vIqfbnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5Jo8+3+H77KmE+JO+hS/ 45qYt7qHc0q32Mw77AURYvsUzipwGUim87RMuyKRafj39f7KwPDwRmley+AFojKMLfnlMheVp+l P+jLdJaYpJucPt63vXU77bdwJcboVm7v3JW+6fCGqklEu9OVfox7P30opq6Y1p5vuSwk2rkgpUy reIn/K8Pymth8VkctK2SsLxTU/n4ldt8HO+duTrhZJ9cBVLJdjlaI4vQXy7tWmC/WlF2ao3qh6f /dr7pYnp8yOMPec2vYqe+272VsT5xR3dTz9cPua6bbuUgMm2fi+zVcbN/Cahk9Yuk+qf38iS2OS pupvTb4dBg+9ai6JXKk+uqSFsc1ULCSX1X6XiIL7By4A
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
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

The function fbtft_driver_remove_pdev() (that exists several times as it's
part of a macro expansion) returns zero unconditionally, so it can be
trivially converted to return void without semantic changes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/fbtft/fbtft.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 2c2b5f1c1df3..f86ed9d470b8 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -310,12 +310,11 @@ static int fbtft_driver_probe_pdev(struct platform_device *pdev)           \
 	return fbtft_probe_common(_display, NULL, pdev);                   \
 }                                                                          \
 									   \
-static int fbtft_driver_remove_pdev(struct platform_device *pdev)          \
+static void fbtft_driver_remove_pdev(struct platform_device *pdev)	   \
 {                                                                          \
 	struct fb_info *info = platform_get_drvdata(pdev);                 \
 									   \
 	fbtft_remove_common(&pdev->dev, info);                             \
-	return 0;                                                          \
 }                                                                          \
 									   \
 FBTFT_DT_TABLE(_compatible)						   \
@@ -329,7 +328,7 @@ static struct platform_driver fbtft_driver_platform_driver = {             \
 		.of_match_table = dt_ids,                                  \
 	},                                                                 \
 	.probe  = fbtft_driver_probe_pdev,                                 \
-	.remove = fbtft_driver_remove_pdev,                                \
+	.remove_new = fbtft_driver_remove_pdev,				   \
 };                                                                         \
 									   \
 static int __init fbtft_driver_module_init(void)                           \

base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
-- 
2.42.0.482.g2e8e77cbac8a.dirty

