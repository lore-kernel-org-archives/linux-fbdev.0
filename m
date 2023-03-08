Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37847C64EC4
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCHHko (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHHki (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F08A7295
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:39:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOu-0007Qy-PT; Wed, 08 Mar 2023 08:39:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOu-002fIa-1L; Wed, 08 Mar 2023 08:39:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-003EMJ-5y; Wed, 08 Mar 2023 08:39:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/13] backlight: lp8788_bl: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:40 +0100
Message-Id: <20230308073945.2336302-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eZI2qgwe+z8FxS6pbJzftF3JfolPn27Am+dAm+EqCn4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDurfYrDtgJfwBic1T4d+VfIM8TB6g012i0x+ Je7+gATV6yJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7qwAKCRDB/BR4rcrs CZZ0B/0QhsnRPRM0EqgHnN2TxIbhgVISwtWaMPMoi2eqmn+RMBDOiGiTRcIN7cLgdllOuf/oizt pG50D8bVhyHyfyjJVKSnT+JNeEWCWfiC9U0hEuw+L8Okat1sr6vEXaFWtoK4sV9hI5lIX7nwYco /NqQUHbz35SJG2zM97u1SLneo/Ix5Vg3LfD94EwNLD8IU/2Y61M6JLwKBldlMMlCPnlLiibxzix 0kvQvebJZmNRHiFT0OuH9pCVQ2plhZsfdSLpPfXsLwFlBUsNZ3FpHY4Pm8oro/VL/E9nHdwBEJX vdOT8yFWO6eXaRF1/OoYntrPb5jEgJlo+rJsUGwzYEB3SRKk
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
 drivers/video/backlight/lp8788_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index ba42f3fe0c73..d1a14b0db265 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -298,7 +298,7 @@ static int lp8788_backlight_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lp8788_backlight_remove(struct platform_device *pdev)
+static void lp8788_backlight_remove(struct platform_device *pdev)
 {
 	struct lp8788_bl *bl = platform_get_drvdata(pdev);
 	struct backlight_device *bl_dev = bl->bl_dev;
@@ -307,13 +307,11 @@ static int lp8788_backlight_remove(struct platform_device *pdev)
 	backlight_update_status(bl_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &lp8788_attr_group);
 	lp8788_backlight_unregister(bl);
-
-	return 0;
 }
 
 static struct platform_driver lp8788_bl_driver = {
 	.probe = lp8788_backlight_probe,
-	.remove = lp8788_backlight_remove,
+	.remove_new = lp8788_backlight_remove,
 	.driver = {
 		.name = LP8788_DEV_BACKLIGHT,
 	},
-- 
2.39.1

