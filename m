Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D12C07E9C
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Jul 2021 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104466146E
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Jul 2021 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhGHJNu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Jul 2021 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhGHJNt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Jul 2021 05:13:49 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150FC061574
        for <linux-fbdev@vger.kernel.org>; Thu,  8 Jul 2021 02:11:07 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E194282DE8;
        Thu,  8 Jul 2021 11:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1625735463;
        bh=v4bVoRD53O4Rz8K6iYCnCgki569VZie03IcR3yzZahg=;
        h=From:To:Cc:Subject:Date:From;
        b=dOieoYE8YXLDAIzAxx6hfonY3mCuzzwin8M8jbaBmvdjStMAYSZLun9NSdJgwGxPM
         0mst50bKbrNtwIbg0+0P3Hub4GDxbLPU2jFRqHqYt7JLR29dihA1KFKk4jmcqHcMws
         CPx7gDnqLAIdUz3hy7Z9QRFsT0bDf6Eyw2UEnWdDVHQ4Ol0bbb2mDfPQLtb+9wCtwh
         86E3g9JJAt0bLFYbM4jUfIT8bKuEBheoZD2ifPduey8Ld49TYXF0mHSYLSGJ4hSZNI
         54mRCXTUga7KAwVlezwgkVjenkaKiN1AeiOpjEovx+cESYrsnBlyfHBUZzO8YD3QPy
         ZIG/6YazpxuDA==
From:   Marek Vasut <marex@denx.de>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] video: backlight: Only set maximum brightness for gpio-backlight
Date:   Thu,  8 Jul 2021 11:10:58 +0200
Message-Id: <20210708091058.56317-1-marex@denx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The note in c2adda27d202f ("video: backlight: Add of_find_backlight helper
in backlight.c") says that gpio-backlight uses brightness as power state.
Other backlight drivers do not, so limit this workaround to gpio-backlight.

This fixes the case where e.g. pwm-backlight can perfectly well be set to
brightness 0 on boot in DT, which without this patch leads to the display
brightness to be max instead of off.

Fixes: c2adda27d202f ("video: backlight: Add of_find_backlight helper in backlight.c")
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Meghana Madhyastha <meghana.madhyastha@gmail.com>
Cc: Noralf Trønnes <noralf@tronnes.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/backlight.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 537fe1b376ad7..dfb66171dec41 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -676,6 +676,7 @@ EXPORT_SYMBOL(of_find_backlight_by_node);
 static struct backlight_device *of_find_backlight(struct device *dev)
 {
 	struct backlight_device *bd = NULL;
+	bool is_gpio_backlight = false;
 	struct device_node *np;
 
 	if (!dev)
@@ -685,6 +686,8 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 		np = of_parse_phandle(dev->of_node, "backlight", 0);
 		if (np) {
 			bd = of_find_backlight_by_node(np);
+			is_gpio_backlight =
+				of_device_is_compatible(np, "gpio-backlight");
 			of_node_put(np);
 			if (!bd)
 				return ERR_PTR(-EPROBE_DEFER);
@@ -692,7 +695,7 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 			 * Note: gpio_backlight uses brightness as
 			 * power state during probe
 			 */
-			if (!bd->props.brightness)
+			if (is_gpio_backlight && !bd->props.brightness)
 				bd->props.brightness = bd->props.max_brightness;
 		}
 	}
-- 
2.30.2

