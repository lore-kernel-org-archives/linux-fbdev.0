Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F2C04E88
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Nov 2023 09:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjKGJUg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Nov 2023 04:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjKGJUb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Nov 2023 04:20:31 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F72C135
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Nov 2023 01:20:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG1-0000Ia-7N; Tue, 07 Nov 2023 10:20:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG0-007FlO-Jz; Tue, 07 Nov 2023 10:20:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r0IG0-00ENWA-8S; Tue, 07 Nov 2023 10:20:24 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 02/22] fb: atmel_lcdfb: Stop using platform_driver_probe()
Date:   Tue,  7 Nov 2023 10:17:43 +0100
Message-ID: <20231107091740.3924258-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dViB4btntHJ8M6t2Xogb0R6R3AcjJZCT3JGQYrKvEno=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlSgC2f+uKvbz9/nNrsa9JiZSvDTZ/flnLpvlDk HrLIcTj6s+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZUoAtgAKCRCPgPtYfRL+ TuWrCACHxojW66Ruyo7Q9FV007Rvu0G1GK7/0ei2gddy1gnhgoj5PLFm3ShyqF1fn2UPq18F3gX 2bKTSwKHvJ/qSHpnEkCqf5yZB6Nf0CT+PuOnXho0v9ccL/zcHp8GW2TvaaUZHI8Kw792Ut6BZgW xbEhZBn24Xq3iVvkBZ2vsYx4JJoyNipKagrDE2rMZK7lIZBdM4NA5Dp/59Z2eulL4mzZEl/VNY9 qyeylRWqN7RffrjgsJO8suNDWORZfhygfnANCwMlJTco93tlJzE2fN20o2IvI5xlwXW/EeX7cJW AsnheFt8g+Q/Nca6ehrM2JI9V4d9uD3+gKhnd8NkLerQ08ou
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On today's platforms the benefit of platform_driver_probe() isn't that
relevant any more. It allows to drop some code after booting (or module
loading) for .probe() and discard the .remove() function completely if
the driver is built-in. This typically saves a few 100k.

The downside of platform_driver_probe() is that the driver cannot be
bound and unbound at runtime which is ancient and also slightly
complicates testing. There are also thoughts to deprecate
platform_driver_probe() because it adds some complexity in the driver
core for little gain. Also many drivers don't use it correctly. This
driver for example misses to mark the driver struct with __refdata which
is needed to suppress a (W=1) modpost warning:

	WARNING: modpost: drivers/video/fbdev/atmel_lcdfb: section mismatch in reference: atmel_lcdfb_driver+0x4 (section: .data) -> atmel_lcdfb_remove (section: .exit.text)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/atmel_lcdfb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index a908db233409..b218731ef732 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1017,7 +1017,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	return ret;
 }
 
-static int __init atmel_lcdfb_probe(struct platform_device *pdev)
+static int atmel_lcdfb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fb_info *info;
@@ -1223,7 +1223,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
+static int atmel_lcdfb_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct fb_info *info = dev_get_drvdata(dev);
@@ -1301,7 +1301,8 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver atmel_lcdfb_driver = {
-	.remove		= __exit_p(atmel_lcdfb_remove),
+	.probe		= atmel_lcdfb_probe,
+	.remove		= atmel_lcdfb_remove,
 	.suspend	= atmel_lcdfb_suspend,
 	.resume		= atmel_lcdfb_resume,
 	.driver		= {
@@ -1310,7 +1311,7 @@ static struct platform_driver atmel_lcdfb_driver = {
 	},
 };
 
-module_platform_driver_probe(atmel_lcdfb_driver, atmel_lcdfb_probe);
+module_platform_driver(atmel_lcdfb_driver, );
 
 MODULE_DESCRIPTION("AT91 LCD Controller framebuffer driver");
 MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
-- 
2.42.0

