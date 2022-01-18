Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9443C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Jan 2022 18:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiARSNz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiARSNx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Jan 2022 13:13:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB11C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jan 2022 10:13:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9szM-000880-TH; Tue, 18 Jan 2022 19:13:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9szK-00B2zq-Tk; Tue, 18 Jan 2022 19:13:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9szJ-0006zF-K4; Tue, 18 Jan 2022 19:13:45 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Noralf Tronnes <notro@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 1/2] staging: fbtft: Fix error path in fbtft_driver_module_init()
Date:   Tue, 18 Jan 2022 19:13:37 +0100
Message-Id: <20220118181338.207943-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; h=from:subject; bh=gJiA8AksyJTrtpGrzRfF50OuBu19LDZN1xB1saUxAWQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBh5wNJFwDFQehIYnjVfgYfBt2NN9k1zG22si9Ri/8c S5fL84aJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYecDSQAKCRDB/BR4rcrsCbkLCA CMkktbQyNtmyTjX2Jy5zZT5GMGpn+o+jgaJObINj8Q2HSqz4hu5YuO23ib1z+scTXKXMoabCUYTqPl lfRCJHOlyxO8shOKTdvs/U66r1+Sy1pl0B6kyLAKmZYv+WSApKCCHH9URQXBwtkH4aAkkQpqrF+3Tw iz+HSbK676qIaG/aW5SWts2WSSruXzYwZSDIaS4Jt+KZkWf40agCIN5WEotN8N+bVCiVX3XOmgpmdG tRSOtkvnd8ff96S721N4CYsNFfS3tPtsTy7BofK1+sAYro3D1B42wAwuBywJ997GZyTG0IQQNUqclZ eZPgnMdjffd5X1xMXg9PfGTzYYovlH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

If registering the platform driver fails, the function must not return
without undoing the spi driver registration first.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/fbtft/fbtft.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 4cdec34e23d2..55677efc0138 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -334,7 +334,10 @@ static int __init fbtft_driver_module_init(void)                           \
 	ret = spi_register_driver(&fbtft_driver_spi_driver);               \
 	if (ret < 0)                                                       \
 		return ret;                                                \
-	return platform_driver_register(&fbtft_driver_platform_driver);    \
+	ret = platform_driver_register(&fbtft_driver_platform_driver);     \
+	if (ret < 0)                                                       \
+		spi_unregister_driver(&fbtft_driver_spi_driver);           \
+	return ret;                                                        \
 }                                                                          \
 									   \
 static void __exit fbtft_driver_module_exit(void)                          \

base-commit: 0c947b893d69231a9add855939da7c66237ab44f
-- 
2.34.1

