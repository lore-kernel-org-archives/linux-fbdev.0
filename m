Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFADCC761A6
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCRXyw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCRXyq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E421B2E1
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNm-00042f-WC; Sun, 19 Mar 2023 00:54:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNm-0056Zz-CE; Sun, 19 Mar 2023 00:54:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNl-005zU7-Lt; Sun, 19 Mar 2023 00:54:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 09/51] video: fbdev: cg6: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:53:46 +0100
Message-Id: <20230318235428.272091-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BHZSBcQSAl1nP+UQSe7IGJ85XXXdncitBc4w1Vv9EIY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk6wlHpbx5We+LSgvhGZCVCN9KxuZg3Bw/ykH wv6TbOFON+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZOsAAKCRCPgPtYfRL+ TlptB/98ytdhHuqOkw2bk8CiTJ6H9Vs0+XdLT8pkn2fJlC3BXOPrIRlrfrSF+Wa9a4qqPfFZ3bX 9zKHQXpxAbHaUTUiv72IB91VaZWUOD2WBQQeMFM3B41Ce7UBx1LG3JNKSiDlBQNQ/qj2rk6SKjV Ni/PA+OZP6BMxuLrZZ7YYra9jXyOO5ZMOwwVfvCUcpFf7RKWYKqYK5GiBugru9g2OCbgOeiRXR6 q+TL7ykki4M2yN80CKTRAi/xMswuDAOH9ZiEx4lGoMdJwcpBPot2Ujdomm8WUqIln4pZjE+7yww HHmOPpkEe7srWEJOKk6gyxyUnj7BIjB6KZSPUqGVJ5mF2yxY
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
 drivers/video/fbdev/cg6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/cg6.c b/drivers/video/fbdev/cg6.c
index 97ef43c25974..6884572efea1 100644
--- a/drivers/video/fbdev/cg6.c
+++ b/drivers/video/fbdev/cg6.c
@@ -828,7 +828,7 @@ static int cg6_probe(struct platform_device *op)
 	return err;
 }
 
-static int cg6_remove(struct platform_device *op)
+static void cg6_remove(struct platform_device *op)
 {
 	struct fb_info *info = dev_get_drvdata(&op->dev);
 	struct cg6_par *par = info->par;
@@ -839,8 +839,6 @@ static int cg6_remove(struct platform_device *op)
 	cg6_unmap_regs(op, info, par);
 
 	framebuffer_release(info);
-
-	return 0;
 }
 
 static const struct of_device_id cg6_match[] = {
@@ -860,7 +858,7 @@ static struct platform_driver cg6_driver = {
 		.of_match_table = cg6_match,
 	},
 	.probe		= cg6_probe,
-	.remove		= cg6_remove,
+	.remove_new	= cg6_remove,
 };
 
 static int __init cg6_init(void)
-- 
2.39.2

