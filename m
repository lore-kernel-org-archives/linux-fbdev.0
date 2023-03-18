Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B3AC77B61
	for <linux-fbdev@archiver.kernel.org>; Sat, 18 Mar 2023 23:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCRXzH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 18 Mar 2023 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCRXyw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 18 Mar 2023 19:54:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93920563
        for <linux-fbdev@vger.kernel.org>; Sat, 18 Mar 2023 16:54:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNs-0004Fq-4J; Sun, 19 Mar 2023 00:54:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNr-0056bz-Gh; Sun, 19 Mar 2023 00:54:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pdgNq-005zVl-PM; Sun, 19 Mar 2023 00:54:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>, Hyunwoo Kim <imv4bel@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 34/51] video: fbdev: pxa3xx-gcu: Convert to platform remove callback returning void
Date:   Sun, 19 Mar 2023 00:54:11 +0100
Message-Id: <20230318235428.272091-35-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
References: <20230318235428.272091-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JKZ6IR3L4a2OLi88lDwQKr+g94Zq3ULQOY7FNOxmM6k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkFk7SqKxd9OSiw2r2mgOM6kB6pXEOTBKefwZFB qJ0blCG4DGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBZO0gAKCRCPgPtYfRL+ TuKYB/sHCEAh6G/pHcfbnMaftJih/j0NrF+Qlm2SELDE0dmuJYOKfLvYYPwPnQaTYXhOcWKmBZZ ce5A1BBZ23ECINY+hDxCu9H5o8PmgHmUVOTjOoBfHPNZ4fAJ3dcX/sL4+cQkxEkr5fELFXgHjP9 xvTy8TcF65wMMzE4iYhBIuDv1qwlXjItNK9iiGbSaYLZB6FHnfvXO1K65ZTYw7ANRs2IExI/J1R 4NW+fC2JTtKXxGj/f6BOVHdGA1p5//OR+srn7V2oDoY/BzhRXIoSsSe95lfYR5UWa8qYWahm0KO mTJgrq87pdtSTwBVv9hdf8ITak/s0fpDcenjF/eVuoWy18AQ
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
 drivers/video/fbdev/pxa3xx-gcu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index c3cd1e1cc01b..2b6ec8c66074 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -676,7 +676,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pxa3xx_gcu_remove(struct platform_device *pdev)
+static void pxa3xx_gcu_remove(struct platform_device *pdev)
 {
 	struct pxa3xx_gcu_priv *priv = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
@@ -686,8 +686,6 @@ static int pxa3xx_gcu_remove(struct platform_device *pdev)
 	dma_free_coherent(dev, SHARED_SIZE, priv->shared, priv->shared_phys);
 	clk_disable_unprepare(priv->clk);
 	pxa3xx_gcu_free_buffers(dev, priv);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -700,7 +698,7 @@ MODULE_DEVICE_TABLE(of, pxa3xx_gcu_of_match);
 
 static struct platform_driver pxa3xx_gcu_driver = {
 	.probe	  = pxa3xx_gcu_probe,
-	.remove	 = pxa3xx_gcu_remove,
+	.remove_new	 = pxa3xx_gcu_remove,
 	.driver	 = {
 		.name   = DRV_NAME,
 		.of_match_table = of_match_ptr(pxa3xx_gcu_of_match),
-- 
2.39.2

