Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C95C761AF
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCRXzC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCRXyt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8D1B2D1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNq-0004Cx-A1; Sun, 19 Mar 2023 00:54:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNp-0056bK-Mr; Sun, 19 Mar 2023 00:54:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNp-005zVG-40; Sun, 19 Mar 2023 00:54:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 26/51] video: fbdev: metronomefb: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:54:03 +0100
Message-Id: <20230318235428.272091-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uvijOtEYTz9wJpcGd8vhuNLjoD+pwsiRbl1kBrYLVAM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk7EGYbM5itBa5puQAEeVIM7VoardxL72XpAm 4bwquxd+dGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOxAAKCRCPgPtYfRL+ TtWzB/0QyHUQPXtvJJ07xP+Cn+iIF7ye2UGjEUeV973hDvnbU1+/41KxPsYq29uC+dmDRg16Fkv uE0m/Hkm+Mo/g8ApgUcUMk0WFPX7FSCqoJAkbena/6pJV0mlDxt5pFnG2qYfSsQkRMOSTQAvXIh juwqe3+Bl7Us3UYVSv77xzbI9J5UxQ0YnMKXBu9/J4ACd1z+M1ApReTKf4x7FS7DEx9BMXno5+G HWhWBS2FHjOcjxrSiPBxls28ERO1Ofp0F9Gq2xInuJ003qnN4Sy/c6NInB6W9R0EMKtMsSKzzqG Eh1TUaXARFu6LPGsEMbJtKQPS0EKK07EE1VHsvcjYxaycWmr
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
 drivers/video/fbdev/metronomefb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 9fd4bb85d735..bbdbf463f0c8 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -744,7 +744,7 @@ static int metronomefb_probe(struct platform_device *dev)
 	return retval;
 }
 
-static int metronomefb_remove(struct platform_device *dev)
+static void metronomefb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
@@ -761,12 +761,11 @@ static int metronomefb_remove(struct platform_device *dev)
 		dev_dbg(&dev->dev, "calling release\n");
 		framebuffer_release(info);
 	}
-	return 0;
 }
 
 static struct platform_driver metronomefb_driver = {
 	.probe	= metronomefb_probe,
-	.remove = metronomefb_remove,
+	.remove_new = metronomefb_remove,
 	.driver	= {
 		.name	= "metronomefb",
 	},
-- 
2.39.2

