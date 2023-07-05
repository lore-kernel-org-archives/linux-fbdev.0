Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732AFC001DF
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 14:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjGEO0P (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjGEO0A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 10:26:00 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E12125;
        Wed,  5 Jul 2023 07:25:17 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 162AE15360;
        Wed,  5 Jul 2023 15:24:57 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id BFC15219FC1; Wed,  5 Jul 2023 15:24:56 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: led_bl: fix initial power state
Date:   Wed,  5 Jul 2023 15:24:14 +0100
Message-ID: <20230705142447.15546-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The condition for the initial power state based on the default
brightness value is reversed.  Fix it.

Furthermore, use the actual state of the LEDs rather than the default
brightness specified in the devicetree as the latter should not cause
the backlight to be automatically turned on.

If the backlight device is not linked to any display, set the initial
power to on unconditionally.

Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changes in v3:
- Add comment

Changes in v2:
- Use the reported LED state to set initial power state
- Always power on if no phandle in DT
---
 drivers/video/backlight/led_bl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index 3259292fda76..c94843c00a30 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -176,6 +176,7 @@ static int led_bl_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct led_bl_data *priv;
+	int init_brightness;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -190,6 +191,8 @@ static int led_bl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	init_brightness = priv->default_brightness;
+
 	ret = led_bl_parse_levels(&pdev->dev, priv);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to parse DT data\n");
@@ -200,8 +203,11 @@ static int led_bl_probe(struct platform_device *pdev)
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = priv->max_brightness;
 	props.brightness = priv->default_brightness;
-	props.power = (priv->default_brightness > 0) ? FB_BLANK_POWERDOWN :
-		      FB_BLANK_UNBLANK;
+
+	/* Set power on if LEDs already on or not linked to a display. */
+	props.power = (init_brightness || !pdev->dev.of_node->phandle) ?
+		FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+
 	priv->bl_dev = backlight_device_register(dev_name(&pdev->dev),
 			&pdev->dev, priv, &led_bl_ops, &props);
 	if (IS_ERR(priv->bl_dev)) {
-- 
2.41.0

