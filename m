Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCEEC74A4B
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCHHkq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCHHkj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592D7301B
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:39:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOv-0007RO-EF; Wed, 08 Mar 2023 08:39:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOu-002fIe-4W; Wed, 08 Mar 2023 08:39:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-003EMM-CS; Wed, 08 Mar 2023 08:39:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/13] backlight: mt6370-backlight: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:41 +0100
Message-Id: <20230308073945.2336302-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=izMl9qYZIjLfU5gY6yLq3ubZeeyc6JGvz++8GSEQJW0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuuUSpDDhEM7P5ntBvd6sGNC7ioJLTDFxq90 V60T6nzE3SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7rgAKCRDB/BR4rcrs Cc6oB/9WVJQFnIaDmnFEvpsCEp0G6K57Xf6TiCfAC7Jd+ERnAtUpHicrWrRBgZUNtxQL5wfepUv n+fEoQ3U8C5H3J/GsRo/Vvtvh8oe8F35YNtbwTKV6zUCLK/nCa5nGkkM1aHhDNCMty0reJxulh2 wTu6Kh9FqHqjUUN73Asvf1u3anMDk4fcmwYDLC3tDPcED9D/xwx+A0rE9A2arGu9J6y0bBmqZ/P 1AlmcACUajW1dL5NqPTch8fsxeRczOkX3719pRpStb4dmE0u96AoT0T1So38TH6E2CwCkE7qkxS OwC84dvY7InkTwU1CTclS7SlTp2h8HkMn2OC9mupMeJCrce4
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
 drivers/video/backlight/mt6370-backlight.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
index 623d4f2baca2..94422c956453 100644
--- a/drivers/video/backlight/mt6370-backlight.c
+++ b/drivers/video/backlight/mt6370-backlight.c
@@ -318,15 +318,13 @@ static int mt6370_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mt6370_bl_remove(struct platform_device *pdev)
+static void mt6370_bl_remove(struct platform_device *pdev)
 {
 	struct mt6370_priv *priv = platform_get_drvdata(pdev);
 	struct backlight_device *bl_dev = priv->bl;
 
 	bl_dev->props.brightness = 0;
 	backlight_update_status(priv->bl);
-
-	return 0;
 }
 
 static const struct of_device_id mt6370_bl_of_match[] = {
@@ -342,7 +340,7 @@ static struct platform_driver mt6370_bl_driver = {
 		.of_match_table = mt6370_bl_of_match,
 	},
 	.probe = mt6370_bl_probe,
-	.remove = mt6370_bl_remove,
+	.remove_new = mt6370_bl_remove,
 };
 module_platform_driver(mt6370_bl_driver);
 
-- 
2.39.1

