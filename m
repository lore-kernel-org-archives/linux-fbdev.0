Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A408C74A5B
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCRXy5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCRXys (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A951BAD1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNp-00048o-5q; Sun, 19 Mar 2023 00:54:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNo-0056al-CU; Sun, 19 Mar 2023 00:54:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNn-005zUo-M4; Sun, 19 Mar 2023 00:54:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 19/51] video: fbdev: grvga: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:53:56 +0100
Message-Id: <20230318235428.272091-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=w3PbzBb6n2nqBuV8qZCtoHtBJv59krNA/XZ/KJwDO5o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk68IZzDWqm6ttd7b9/mkNOCsDB+EdeM2L5v5 MKeZTADV12JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOvAAKCRCPgPtYfRL+ TmGtB/0VA/sthxPkFudCxTwFIwGFs6hZ7ntBJzqtUyhX7UoYNQsX9+pJelo10q1gneCkD9IRP0G nRD8FhduwIi2qi+GhojDJA2TophuuKYDYWcPVzaqrdfBQeibNyT5ipM1xGA8DZyAJEUnMCRBu2e svj3Jqgd4diQWg/VNx7pATkiQ9gibi+6TrGRDiymjJv12Frok9kRbPSC4CgR18/0HuGUAj3QPWu q9Ed06xLJtnEnaBtP+QQcbclO+g+toGkFnO7pMT39AZhdQ3R8vnPkoazAtITRmu/MqnbNA4HN1e pfukF3gHEepnFtqYkCI/kpwBWXx5SMeCg1NijYroKmOAOoC3
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
 drivers/video/fbdev/grvga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index 24818b276241..9aa15be29ea9 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -504,7 +504,7 @@ static int grvga_probe(struct platform_device *dev)
 	return retval;
 }
 
-static int grvga_remove(struct platform_device *device)
+static void grvga_remove(struct platform_device *device)
 {
 	struct fb_info *info = dev_get_drvdata(&device->dev);
 	struct grvga_par *par;
@@ -524,8 +524,6 @@ static int grvga_remove(struct platform_device *device)
 
 		framebuffer_release(info);
 	}
-
-	return 0;
 }
 
 static struct of_device_id svgactrl_of_match[] = {
@@ -545,7 +543,7 @@ static struct platform_driver grvga_driver = {
 		.of_match_table = svgactrl_of_match,
 	},
 	.probe		= grvga_probe,
-	.remove		= grvga_remove,
+	.remove_new	= grvga_remove,
 };
 
 module_platform_driver(grvga_driver);
-- 
2.39.2

