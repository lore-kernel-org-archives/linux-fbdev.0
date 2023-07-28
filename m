Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6DC001DE
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjG1O6q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbjG1O6p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 10:58:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D32688
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 07:58:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvL-00030O-ON; Fri, 28 Jul 2023 16:58:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvH-002jOE-W9; Fri, 28 Jul 2023 16:58:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPOvH-008WkP-D3; Fri, 28 Jul 2023 16:58:31 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] video: fbdev: ssd1307fb: Print the PWM's label instead of its number
Date:   Fri, 28 Jul 2023 16:58:23 +0200
Message-Id: <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0P1/KpGQ9f8J6bY99RI2pVsdqUOU6FI+1+net6ZiEy4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkw9eKLLisLuS+D7TCHzgyRAnVPUSEs/f6CMa59 mfDk0tQp5OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMPXigAKCRCPgPtYfRL+ Tp7nB/4ud4oh/0jcHDyNPNBCOVkB7D5/nUUG87YrdL+ja3WHQHXhqfOln5fZEYDcwGa/5e4qKp3 xZZL9uWd+6+82o0Lbk8fWHgpN1DPfPXU4/B95qbpsBxTpPfMQTXekgEGrAravU9C1xxTDu2+ibG XnzQRGTD54M+OuCWdzu+o6qgmx26LU6uTjGKK/Mna2KEnNYSSJ5PFo7GoZAKehNRhG2w3O/+OLr sPPgyujzVBmwopYr6j07RxQyWiJvBGaPyOmPYXbC02lGldp4WhuNUJ5AuEk7ElR6L7zYC1PCqmB jnCRTDpVZrmyCrL220uHKYEIvR8cgAiMlbVqpPdMhQlId4dY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

struct pwm_device::pwm is a write-only variable in the pwm core and used
nowhere apart from this and another dev_dbg. So it isn't useful to
identify the used PWM. Emit the PWM's label instead in the debug
message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 11c373798279..46881a691549 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -399,8 +399,8 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		/* Enable the PWM */
 		pwm_enable(par->pwm);
 
-		dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
-			par->pwm->pwm, pwm_get_period(par->pwm));
+		dev_dbg(&par->client->dev, "Using PWM %s with a %lluns period.\n",
+			par->pwm->label, pwm_get_period(par->pwm));
 	}
 
 	/* Set initial contrast */
-- 
2.39.2

