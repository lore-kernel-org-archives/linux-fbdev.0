Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF74C49361
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B0B613B9
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Jun 2021 08:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhFRJBA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Jun 2021 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFRJA7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Jun 2021 05:00:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14ECC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Jun 2021 01:58:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1luAKs-0006sg-K9; Fri, 18 Jun 2021 10:58:46 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1luAKs-0004lQ-0i; Fri, 18 Jun 2021 10:58:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] backlight: lm3630a: convert to atomic PWM API and check for errors
Date:   Fri, 18 Jun 2021 10:58:44 +0200
Message-Id: <20210618085844.231751-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fbdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The practical upside here is that this only needs a single API call to
program the hardware which (depending on the underlaying hardware) can
be more effective and prevents glitches.

Up to now the return value of the pwm functions was ignored. Fix this
and propagate the error to the caller.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/lm3630a_bl.c | 33 +++++++++++++++-------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index e88a2b0e5904..24fa7e6938fa 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -52,6 +52,7 @@ struct lm3630a_chip {
 	struct gpio_desc *enable_gpio;
 	struct regmap *regmap;
 	struct pwm_device *pwmd;
+	struct pwm_state pwmd_state;
 };
 
 /* i2c access */
@@ -167,16 +168,19 @@ static int lm3630a_intr_config(struct lm3630a_chip *pchip)
 	return rval;
 }
 
-static void lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
+static int lm3630a_pwm_ctrl(struct lm3630a_chip *pchip, int br, int br_max)
 {
-	unsigned int period = pchip->pdata->pwm_period;
-	unsigned int duty = br * period / br_max;
+	int err;
 
-	pwm_config(pchip->pwmd, duty, period);
-	if (duty)
-		pwm_enable(pchip->pwmd);
-	else
-		pwm_disable(pchip->pwmd);
+	pchip->pwmd_state.period = pchip->pdata->pwm_period;
+
+	err = pwm_set_relative_duty_cycle(&pchip->pwmd_state, br, br_max);
+	if (err)
+		return err;
+
+	pchip->pwmd_state.enabled = pchip->pwmd_state.duty_cycle ? true : false;
+
+	return pwm_apply_state(pchip->pwmd, &pchip->pwmd_state);
 }
 
 /* update and get brightness */
@@ -188,8 +192,11 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 
 	/* pwm control */
 	if ((pwm_ctrl & LM3630A_PWM_BANK_A) != 0) {
-		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
-				 bl->props.max_brightness);
+		ret = lm3630a_pwm_ctrl(pchip, bl->props.brightness,
+				       bl->props.max_brightness);
+		if (ret)
+			return ret;
+
 		return bl->props.brightness;
 	}
 
@@ -563,11 +570,7 @@ static int lm3630a_probe(struct i2c_client *client,
 			return PTR_ERR(pchip->pwmd);
 		}
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pchip->pwmd);
+		pwm_init_state(pchip->pwmd, &pchip->pwmd_state);
 	}
 
 	/* interrupt enable  : irq 0 is not allowed */
-- 
2.30.2

