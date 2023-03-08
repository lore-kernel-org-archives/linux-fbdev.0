Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF397C74A44
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCHHkn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCHHkh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52156A674E
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:39:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOu-0007Oa-5n; Wed, 08 Mar 2023 08:39:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-002fIM-Fp; Wed, 08 Mar 2023 08:39:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-003EM7-HU; Wed, 08 Mar 2023 08:39:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 05/13] backlight: hp680_bl: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:37 +0100
Message-Id: <20230308073945.2336302-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M9dLITsn5zab+0bkWoonyWYbuduSYEK0hkgzj0jiwuo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuhsi7kKTmv6O1V7PCdjHwDhkpge5FRgPUKu waPOjFYrZeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7oQAKCRDB/BR4rcrs CTc1B/40zt5MoKd0deHo8laqokL7r//tNWnvly6124OUQrP4dSoC26YyVfV+QksHACK611UNIZQ bLvC+aRBfpj2xEGIK/czkVfwd+aj0zEMO9wLT18dlAzLvK167Qvcc7SdubIKLg04196XmiB2FLg l3Smd7AY3CDK3O/AXoQDhXDm0eSoKaep5w3RkGUgC6xjL5Yb0Bp6lAKHfdnw6Lw/3iQENpowwkt RH5ozFkmq4PqlaObH0IppmEm9ASLEwxLOta2V85diVO/kTSztcDy5UlciTWnmOxMDyPTIQPwiG+ nRFle7DOr+7nt5Pg4zWLzv6oW7N9eW2ysmUcJ4WGCYYon5rB
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
 drivers/video/backlight/hp680_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
index 9123c33def05..ddb7ab4df77e 100644
--- a/drivers/video/backlight/hp680_bl.c
+++ b/drivers/video/backlight/hp680_bl.c
@@ -119,20 +119,18 @@ static int hp680bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hp680bl_remove(struct platform_device *pdev)
+static void hp680bl_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bd = platform_get_drvdata(pdev);
 
 	bd->props.brightness = 0;
 	bd->props.power = 0;
 	hp680bl_send_intensity(bd);
-
-	return 0;
 }
 
 static struct platform_driver hp680bl_driver = {
 	.probe		= hp680bl_probe,
-	.remove		= hp680bl_remove,
+	.remove_new	= hp680bl_remove,
 	.driver		= {
 		.name	= "hp680-bl",
 		.pm	= &hp680bl_pm_ops,
-- 
2.39.1

