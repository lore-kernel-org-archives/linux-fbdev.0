Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A20C742A7
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCHHkl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCHHkh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3397EA3376
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:39:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOu-0007Oh-8j; Wed, 08 Mar 2023 08:39:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-002fIS-Jl; Wed, 08 Mar 2023 08:39:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-003EME-Un; Wed, 08 Mar 2023 08:39:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/13] backlight: lm3533_bl: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:39 +0100
Message-Id: <20230308073945.2336302-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=B10aYkfZ10FicDbAmbArgdL8NIfQOPQPQfoyXrHPbeo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuoNu328oHteZgsiA+uD3pMoYQH5hzb/hbSm XEg4dcEQUiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7qAAKCRDB/BR4rcrs CVXyB/9oqCZo+mKUEcEePjXGWgM2GQIIQj0rSQo/n1Fm2sY+G3KQthTpNcK993asVg2EmPK3BGq yUHh1hDFwLrlJ1D81fAeYIy04xIAXh51Qs0ECGkfY0/0dFjzzk9ym44XBQiPMLNK+abO6Xt2m4N R3TX3pQSDasgkyjfdmfJBjdistYqC5cCqck6MbP4yicoXKsWmf8bBOI87Qrdaak2k8g2k8UXMO8 WOK8JbRGalQBmNs/KKuYNsWjR47l1SgPD5HhyTqvMh96wH1wx44oDnV3qm1u6OwgQMlNYp2C+WB prSJnK5tlFHIYfFSum8LPJIuHDJGI6tLkZOAGApmbgnlTC+n
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
 drivers/video/backlight/lm3533_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 1df1b6643c0b..3e10d480cb7f 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -337,7 +337,7 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lm3533_bl_remove(struct platform_device *pdev)
+static void lm3533_bl_remove(struct platform_device *pdev)
 {
 	struct lm3533_bl *bl = platform_get_drvdata(pdev);
 	struct backlight_device *bd = bl->bd;
@@ -349,8 +349,6 @@ static int lm3533_bl_remove(struct platform_device *pdev)
 
 	lm3533_ctrlbank_disable(&bl->cb);
 	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -390,7 +388,7 @@ static struct platform_driver lm3533_bl_driver = {
 		.pm	= &lm3533_bl_pm_ops,
 	},
 	.probe		= lm3533_bl_probe,
-	.remove		= lm3533_bl_remove,
+	.remove_new	= lm3533_bl_remove,
 	.shutdown	= lm3533_bl_shutdown,
 };
 module_platform_driver(lm3533_bl_driver);
-- 
2.39.1

