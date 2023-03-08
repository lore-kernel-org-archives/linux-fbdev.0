Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D0C6FD1E
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCHHkr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCHHkj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:40:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE2EA8817
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:40:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOt-0007OK-L4; Wed, 08 Mar 2023 08:39:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOs-002fI8-KR; Wed, 08 Mar 2023 08:39:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZoOr-003ELw-TN; Wed, 08 Mar 2023 08:39:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/13] backlight: adp5520_bl: Convert to platform remove callback returning void
Date:   Wed,  8 Mar 2023 08:39:34 +0100
Message-Id: <20230308073945.2336302-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
References: <20230308073945.2336302-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gOBnzR2FF/koiMMcqx34hKsR+7ybHAkCMa+CwEXqxFs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCDuXYNmO3NtbTUsMqalUWwC49XtSc/DTykbEs fWY6talIVOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAg7lwAKCRDB/BR4rcrs CV6KB/9516SBG0MTfjl0UnyYjLk3+tHSugq/bagLjRtizR1CWHUBR4zHjwGuQmdUbQVjsTObQL3 WYN8YuWpCVDVM9wPYbPwbyffSrOetB51+5yAyWbEKUreZ6eObfmcpjo21N4J1xxcMkqp/TgJt2g DQetL6TivVy8hUbRgQu5oHGRza0D7N9MfYUpwYXWFne3wTx/2OzfI8xohILblR6hN/S/ZsyQyn7 2m29riSLTyoPa3Z0/l6bw8/MMPD3k/PXxNmeKhajJfx+s/LjPL/7fPlr8ELSdi0iirYy+aWuN5S i9OP2Q+Lvthj21aoSTEYRq/HMF+ChRAGBtsFE80xXbjI+5SG
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
 drivers/video/backlight/adp5520_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index 686988c3df3a..8e0e9cfe5fe9 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -337,7 +337,7 @@ static int adp5520_bl_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int adp5520_bl_remove(struct platform_device *pdev)
+static void adp5520_bl_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct adp5520_bl *data = bl_get_data(bl);
@@ -347,8 +347,6 @@ static int adp5520_bl_remove(struct platform_device *pdev)
 	if (data->pdata->en_ambl_sens)
 		sysfs_remove_group(&bl->dev.kobj,
 				&adp5520_bl_attr_group);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -377,7 +375,7 @@ static struct platform_driver adp5520_bl_driver = {
 		.pm	= &adp5520_bl_pm_ops,
 	},
 	.probe		= adp5520_bl_probe,
-	.remove		= adp5520_bl_remove,
+	.remove_new	= adp5520_bl_remove,
 };
 
 module_platform_driver(adp5520_bl_driver);
-- 
2.39.1

