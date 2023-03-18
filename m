Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991EC76196
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCRXyu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCRXyq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB9E3B3
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNl-00041c-Rg; Sun, 19 Mar 2023 00:54:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNk-0056ZI-LS; Sun, 19 Mar 2023 00:54:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNk-005zTe-3d; Sun, 19 Mar 2023 00:54:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>, Yihao Han <hanyihao@vivo.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 01/51] video: fbdev: au1100fb: Drop if with an always false condition
Date:   Sun, 19 Mar 2023 00:53:38 +0100
Message-Id: <20230318235428.272091-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8kWUurH4mQ0OQU+6hHzGUiErN2Kfnbs34nApHHgcpDE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk6nHBGCOiE+/M3aKXnJAlEaRTWzKQCrKdPbn SMG1BEXdXKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOpwAKCRCPgPtYfRL+ TtcdB/sHZyq7+lOWcnSDCNYblMs68C5yGPa1zoJIvZF2l9woZ8JslTJvSBkE74YRQWewTGl7XZH Fsjt0/jru5qpeQUYGenecuBxA+Ww2nVhYiZZSqoy3mL/fl9wDKu8MAr3PJwnSNSGVuFxa5SYpDb wxjngFAM7FWyJUY4e3RBS7fpmeCqyKf1OYubiIYg6HtdNFogiv1RvNUnkn7Puml451veHvCxI5c k3v56FwLMZukdlAKvzZzhLCMX/070fNVkkkLD8QKsGvHaenk6DDFctR5AHn0tgO1ua+fm78pbzg WwdenuxF6BxxI8ma4P8zUsoBNPQGQEZMDyiRgM8ajv2W13Zq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver core never calls a remove callback with the platform_device
pointer being NULL. So the check for this condition can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/au1100fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 519313b8bb00..cd27e3b81bb8 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -524,9 +524,6 @@ int au1100fb_drv_remove(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = NULL;
 
-	if (!dev)
-		return -ENODEV;
-
 	fbdev = platform_get_drvdata(dev);
 
 #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
-- 
2.39.2

