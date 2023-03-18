Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD4FC76196
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCRXy6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjCRXys (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF911C304
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNn-00043L-Ea; Sun, 19 Mar 2023 00:54:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNm-0056a6-Pm; Sun, 19 Mar 2023 00:54:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNl-005zUB-SY; Sun, 19 Mar 2023 00:54:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>, Alexander Shiyan <shc_work@mail.ru>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 10/51] video: fbdev: clps711x-fb: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:53:47 +0100
Message-Id: <20230318235428.272091-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7XciOw7u/XULFto6K0Shpj1R0GHgUS4QU77mvneAEPk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk6xSTiu3Fh1C6zLZ/LLF1EVCMkX9DsskAtCY ehiVEyB7SyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOsQAKCRCPgPtYfRL+ TsbNB/wJdTFgsFm2NXJy1LBrfF+hMAkx/3kyrU+mvQmwKRAZX5yVzzIH1IXseQXXvdmagFSLfc6 3wbcP5HkEn15LkOCAuzOAudxezca3x9dIWy8uOqBkCaMod7zFouZvtDU2oAjooLJect0SLg78Gx 5XXZ22/NFachWJ8jOeS0l4tfPaGJvPKtPPQP/aSv+8j13My1dl/7zdUZzu0U+xoU6ji1zqaYQj1 hcbY8KrmbbZYBb6vvD2n3x1+q52rh1jeyJHPBWagf/RqkKJD8j579kFix1zO1LwX9O0oMiVUk+F fUG1anRtOVfk9/Stm+a/+pEAJ+S+lgCQajcIFoIruXwJaFDr
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
 drivers/video/fbdev/clps711x-fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 45c75ff01eca..51160a728566 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -351,7 +351,7 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int clps711x_fb_remove(struct platform_device *pdev)
+static void clps711x_fb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct clps711x_fb_info *cfb = info->par;
@@ -361,8 +361,6 @@ static int clps711x_fb_remove(struct platform_device *pdev)
 	unregister_framebuffer(info);
 	fb_dealloc_cmap(&info->cmap);
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static const struct of_device_id clps711x_fb_dt_ids[] = {
@@ -377,7 +375,7 @@ static struct platform_driver clps711x_fb_driver = {
 		.of_match_table	= clps711x_fb_dt_ids,
 	},
 	.probe	= clps711x_fb_probe,
-	.remove	= clps711x_fb_remove,
+	.remove_new = clps711x_fb_remove,
 };
 module_platform_driver(clps711x_fb_driver);
 
-- 
2.39.2

