Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B07C678D5
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCHHkn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCHHki (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9AA6BD7
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:39:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-0007OL-QD; Wed, 08 Mar 2023 08:39:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-002fIC-VB; Wed, 08 Mar 2023 08:39:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-003EM3-B9; Wed, 08 Mar 2023 08:39:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/13] backlight: da9052_bl: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:36 +0100
Message-Id: <20230308073945.2336302-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bsoydFuZCk7syqjkaRBH4nNkv8kajLzc7EUVWw/edXs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuemQc+2aVMDUVj3v07So/1xAS89BPFUySvT J2PXq2kDa+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7ngAKCRDB/BR4rcrs CbA3CAChTT3ij2gxCbOiu8P1jArQwOUMPG9w/MfZAVySIFX7pxJklGwzUBLhhJveypp9+CHJmpB QfWoh5Zh6vEocDec8zpJr7iNfyhOdeYe3bHzUZDaBZAWjT9r+EI2mHGBDbjZv0VCJJxO9nMxZIi E2w/D1nBopdEsOTkgEoHKTzcD3UvnlCoUdevx3VurYJUPlQHqiIXVyqheQ3uqvO8naGv2172VSY W/DyR5EICMx8lrbmL/BEvC3QMony7viDB92KP8wvdRr8ab1itZ4SY1D0+R/J8abPKbKXKzfwZDd 0/DNaujRHr9H+uZCq2/7hSc3kd86T/j0vMb+21jTS2N06w5s
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
 drivers/video/backlight/da9052_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 882359dd288c..1cdc8543310b 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -135,7 +135,7 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	return da9052_adjust_wled_brightness(wleds);
 }
 
-static int da9052_backlight_remove(struct platform_device *pdev)
+static void da9052_backlight_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct da9052_bl *wleds = bl_get_data(bl);
@@ -143,8 +143,6 @@ static int da9052_backlight_remove(struct platform_device *pdev)
 	wleds->brightness = 0;
 	wleds->state = DA9052_WLEDS_OFF;
 	da9052_adjust_wled_brightness(wleds);
-
-	return 0;
 }
 
 static const struct platform_device_id da9052_wled_ids[] = {
@@ -166,7 +164,7 @@ MODULE_DEVICE_TABLE(platform, da9052_wled_ids);
 
 static struct platform_driver da9052_wled_driver = {
 	.probe		= da9052_backlight_probe,
-	.remove		= da9052_backlight_remove,
+	.remove_new	= da9052_backlight_remove,
 	.id_table	= da9052_wled_ids,
 	.driver	= {
 		.name	= "da9052-wled",
-- 
2.39.1

