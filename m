Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549FC07E99
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717E36115C
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 13:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhGIN3S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:29:18 -0400
Received: from phobos.denx.de ([85.214.62.61]:33676 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhGIN3H (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 9 Jul 2021 09:29:07 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DD37580C84;
        Fri,  9 Jul 2021 15:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1625837182;
        bh=sSgqNxTFibSijuHcfVmKDuviBaWK09/NQiHzxkjRxIc=;
        h=From:To:Cc:Subject:Date:From;
        b=F3tfm46SvVom5pE9TLnmse28n0E3SyGODqQnZYvRdqFgMVCHi7UXDCHf6QtaWeT0L
         fettj8uaKhScKQ39GX9XBoJvTIxRStDi6yeNyHAdguxow3JVrSzemdUACC9t80puLW
         HHRIwY4NNmxjRIag+VWdPjrAyJ7URY2Lgp3UYtUBPEfoPhLWyfzC3z0OCXOv+OzMa3
         CgcobFWGGig9ECFxn+oOpNQkuQrX+It0FSu6wPZ4uk25oHbGTY0T4yVEkScySCSaZs
         TtNPzJQ1/o+se8/VYxFvd3snJrHNeDXnCooWqYiGuZHTBPVqE2teF2pw0MiDammgoM
         0qCdNGXmhvRRw==
From:   Marek Vasut <marex@denx.de>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] video: backlight: Drop maximum brightness override for brightness zero
Date:   Fri,  9 Jul 2021 15:26:00 +0200
Message-Id: <20210709132600.5417-1-marex@denx.de>
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
This has been fixed since in ec665b756e6f7 ("backlight: gpio-backlight:
Correct initial power state handling") and other backlight drivers do not
require this workaround. Drop the workaround.

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
 drivers/video/backlight/backlight.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 537fe1b376ad7..fc990e576340b 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -688,12 +688,6 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 			of_node_put(np);
 			if (!bd)
 				return ERR_PTR(-EPROBE_DEFER);
-			/*
-			 * Note: gpio_backlight uses brightness as
-			 * power state during probe
-			 */
-			if (!bd->props.brightness)
-				bd->props.brightness = bd->props.max_brightness;
 		}
 	}
 
-- 
2.30.2

