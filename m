Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0E4C072A4
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Nov 2023 09:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKGJUm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Nov 2023 04:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjKGJUd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Nov 2023 04:20:33 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E1C6
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Nov 2023 01:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG3-0000PL-9R; Tue, 07 Nov 2023 10:20:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG2-007FmK-Pi; Tue, 07 Nov 2023 10:20:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG2-00ENWy-GE; Tue, 07 Nov 2023 10:20:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 13/22] fb: atmel_lcdfb: Convert to platform remove callback returning void
Date:   Tue,  7 Nov 2023 10:17:54 +0100
Message-ID: <20231107091740.3924258-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yKIqXghEuFOu58jVWtdhWAyXSDoLomDIur2uD0OICLY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlSgDDeJ1YBqzQqo534aSrJ3oLKy2VgTSkGnV70 vB1EnHsU2iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUoAwwAKCRCPgPtYfRL+ ThuvB/0WNkzl8Uw9DAlb3xLsTkb2sZVpEY31HH4Jp4iSBk11IlOZKHub/9TxscW/JUnKzy5xvpG KHnjX6AeLTlvysLONcW7boU28fjQ5KUtpD6ufq36+2ZHQjejJZb2AvH4aCcll3X24CzhSwGEu19 5gHHuqIwlV7rJUHIh3OaSFK6i83hKn5Mv8UABaJG7M8r7C41wPXTZxUq4mfIcsn9yV091DvJaMS NmQBkusik6s6ksWpQN4Trmr5k8Wvmr9YEDe78H4YP4ZaQ7l+G/ka+7AVoFew8mKiNtGQyvWJA/z nP3QmlfHIdrdf21nVU5S07iIUHV4hkWFJo+MsBjTTKIHvOtZ
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
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/atmel_lcdfb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index b218731ef732..0531d6f6dcc5 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1223,14 +1223,14 @@ static int atmel_lcdfb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmel_lcdfb_remove(struct platform_device *pdev)
+static void atmel_lcdfb_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct atmel_lcdfb_info *sinfo;
 
 	if (!info || !info->par)
-		return 0;
+		return;
 	sinfo = info->par;
 
 	cancel_work_sync(&sinfo->task);
@@ -1252,8 +1252,6 @@ static int atmel_lcdfb_remove(struct platform_device *pdev)
 	}
 
 	framebuffer_release(info);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1302,7 +1300,7 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
 
 static struct platform_driver atmel_lcdfb_driver = {
 	.probe		= atmel_lcdfb_probe,
-	.remove		= atmel_lcdfb_remove,
+	.remove_new	= atmel_lcdfb_remove,
 	.suspend	= atmel_lcdfb_suspend,
 	.resume		= atmel_lcdfb_resume,
 	.driver		= {
-- 
2.42.0

