Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE48C7619A
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCRXzD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjCRXyu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C819699
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNr-0004F6-Ky; Sun, 19 Mar 2023 00:54:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNr-0056bm-0a; Sun, 19 Mar 2023 00:54:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNq-005zVZ-6L; Sun, 19 Mar 2023 00:54:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 31/51] video: fbdev: p9100: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:54:08 +0100
Message-Id: <20230318235428.272091-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7EdLunVGr5suPqaCLWBHwHgA+gHggLCAuloDzn875wE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk7Jl48h8/QTTCSlYMrUz2Lr/uz4SJyzle+/y cVqLZNDkAOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOyQAKCRCPgPtYfRL+ ToszCAC0FcFwFs1f9zShRUugPSqc+zWnA55zr7ys+GouolParjElJVQvUjQnyh4ttY9PKJyq3WP 1rG6WayfHFviSERmgGr3g4TOWEoA5myu4yRo+LCdOsa+EnEdJuYsCN6hQm16dInqliCvYfC1hsG zcdwPQBk0ZD8i8tYj5HsCbOr8sbVwAg6Tnst8v1cWli6qrgWXDpstAOA2OK/kLahJRM+aGyZuyX 4H46KfchGHb6i13hNana2+VvOcwayrGJMMLjXuCIi0g8oIJNPq9Mr9Gswi4poJ491CDQtoUdv+2 Mg2vVChGPH3GmDc2OlbSYAjk7c40bfOQ13xBAxqaZFFItIPX
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
 drivers/video/fbdev/p9100.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 4e88a0a195ad..3e44f9516318 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -327,7 +327,7 @@ static int p9100_probe(struct platform_device *op)
 	return err;
 }
 
-static int p9100_remove(struct platform_device *op)
+static void p9100_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct p9100_par *par = info->par;
@@ -339,8 +339,6 @@ static int p9100_remove(struct platform_device *op)
 	of_iounmap(&op->resource[2], info->screen_base, info->fix.smem_len);
 
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static const struct of_device_id p9100_match[] = {
@@ -357,7 +355,7 @@ static struct platform_driver p9100_driver = {
 		.of_match_table = p9100_match,
 	},
 	.probe		= p9100_probe,
-	.remove		= p9100_remove,
+	.remove_new	= p9100_remove,
 };
 
 static int __init p9100_init(void)
-- 
2.39.2

