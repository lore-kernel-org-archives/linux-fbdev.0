Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948FC7618A
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCRXzE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRXyw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D520575
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNs-0004GN-Ed; Sun, 19 Mar 2023 00:54:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNr-0056c9-RV; Sun, 19 Mar 2023 00:54:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNr-005zVu-7c; Sun, 19 Mar 2023 00:54:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 36/51] video: fbdev: s1d13xxxfb: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:54:13 +0100
Message-Id: <20230318235428.272091-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=n0I3VdLYw621CybXUzty9yTbWQ3cM5Ojb62GtHF+q98=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk7e52rtSyMCY3ySsXTK4eetEMWnq0tEqG9hd p3dHIL/ACeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZO3gAKCRCPgPtYfRL+ Tn5gCACbK+2dXtVykxEI781AggALjrZgp7oHHYaWL/JCtdR5zYS+3bHfyi+WED9jIEbIdqDGVSq 0E9ZxvjUCvjKz8UCmmFBu+UQNWSL1kk4n5JtzwyGIHwwPyRR4iGBkrB6TeRzvWPg/65yBGhInb6 EhRiouSUbZzdf/VRD4x0QgsIvdRzZ6LjQUhemawfpcxVyx+QTU/YvbsMztIG7TKROHMZbHy8m9v HLQ64wqnWP43djxaoEViFVi2iQWeCtBoD9rWe83oplAz0SzvMk3E8C8GF4jS79b2A5Ufkby4a4H HeHeG1mcu9PvApj6/ir+9ZWmVhUg+eUboTuzhIJOGuiTGZeB
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
 drivers/video/fbdev/s1d13xxxfb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index d1b5f965bc96..8f2edccdba46 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -748,13 +748,12 @@ static void __s1d13xxxfb_remove(struct platform_device *pdev)
 			   resource_size(&pdev->resource[1]));
 }
 
-static int s1d13xxxfb_remove(struct platform_device *pdev)
+static void s1d13xxxfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
 	unregister_framebuffer(info);
 	__s1d13xxxfb_remove(pdev);
-	return 0;
 }
 
 static int s1d13xxxfb_probe(struct platform_device *pdev)
@@ -995,7 +994,7 @@ static int s1d13xxxfb_resume(struct platform_device *dev)
 
 static struct platform_driver s1d13xxxfb_driver = {
 	.probe		= s1d13xxxfb_probe,
-	.remove		= s1d13xxxfb_remove,
+	.remove_new	= s1d13xxxfb_remove,
 #ifdef CONFIG_PM
 	.suspend	= s1d13xxxfb_suspend,
 	.resume		= s1d13xxxfb_resume,
-- 
2.39.2

