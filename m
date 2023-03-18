Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C7FC761A6
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCRXzA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCRXys (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2251C58F
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNp-00049c-Dv; Sun, 19 Mar 2023 00:54:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNo-0056au-OF; Sun, 19 Mar 2023 00:54:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNn-005zUs-S2; Sun, 19 Mar 2023 00:54:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 20/51] video: fbdev: hecubafb: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:53:57 +0100
Message-Id: <20230318235428.272091-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OdZ3pDt714v4VNRS/xI1QELFOYfM+/Dof2avBOgjwV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk69nbV7M8ogkAdJIngzLl676pYAjS2URcoUp HIJJymlrJOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOvQAKCRCPgPtYfRL+ TozOB/wPKBTawbIdjVWGDowkVm/ZgPvHiXMncEBYqkYK0TwXWyX+5Yatu42zRua+kk1ppSSTtsm 280vii7/ejCTQ3uUOyYP9UuQut8Hp2DxfMEdIYqjIDSBiMPZLDbbh6ZwPJNh+3/xfi/jwvh/L2I BRaWnm/BU6l2u1/aUHHmjuvEkL2HXw7+4m0LfO4tK/VnCEG3kqmMCLw9Y/1dSolqA+nP/xmbN1/ jY+TD6iDpuESNHEmr0/2YR32Pt++0Z55AZAdRXkRVma9Sj7/BqXZAY7KvLy72M30W5rqikwQ1CC QqFmrH5WoQPVi8XpMnJntkXPzA8PGSXp0ggSKtOoCm7rtvHC
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
 drivers/video/fbdev/hecubafb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index eb1eaadc1bbb..5a149458d3b4 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -279,7 +279,7 @@ static int hecubafb_probe(struct platform_device *dev)
 	return retval;
 }
 
-static int hecubafb_remove(struct platform_device *dev)
+static void hecubafb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 
@@ -293,12 +293,11 @@ static int hecubafb_remove(struct platform_device *dev)
 		module_put(par->board->owner);
 		framebuffer_release(info);
 	}
-	return 0;
 }
 
 static struct platform_driver hecubafb_driver = {
 	.probe	= hecubafb_probe,
-	.remove = hecubafb_remove,
+	.remove_new = hecubafb_remove,
 	.driver	= {
 		.name	= "hecubafb",
 	},
-- 
2.39.2

