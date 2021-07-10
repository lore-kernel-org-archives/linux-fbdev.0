Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A9C07E9C
	for <linux-fbdev@archiver.kernel.org>; Sat, 10 Jul 2021 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C556613D9
	for <linux-fbdev@archiver.kernel.org>; Sat, 10 Jul 2021 02:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhGJCbT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Jul 2021 22:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234577AbhGJC3g (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 9 Jul 2021 22:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EAD7613FD;
        Sat, 10 Jul 2021 02:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625884010;
        bh=tRb1rL9r1jHfW6knxthlrBoGc/o/vZ5eKhsuyfbMuSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGCUIewya6LzvkHWI2UeLomPsOw9jRmC9n7mRJX8oRYhC0cfaDUUhCrOfEKacAKrN
         JBryl2TFxGPeR02+qoogoFpAbzbaNihPkf3fkOBF8g+eZUvly04W+iZ8rPEs9O34QP
         Cw9n5hQV6JJnnUPhxcxAmVHPdz/DzIzjxhwRiJjfUJXEaFW9zFgfe3htmMc/gya84m
         xSPDfAH3MwY62w9QjYroJLSx79tuVgjeD+VpLd0bSOqFiI98TQsp4hV8X3aJOUN5Jc
         OM7+HHHgz3vs1YSFFImg9EsmvcyruXretnM9KtxLnKo30H+Qjm8QVw3Ks5Src3Y+Ks
         LBMoAy8o9TNVg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 82/93] backlight: lm3630a: Fix return code of .update_status() callback
Date:   Fri,  9 Jul 2021 22:24:16 -0400
Message-Id: <20210710022428.3169839-82-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit b9481a667a90ec739995e85f91f3672ca44d6ffa ]

According to <linux/backlight.h> .update_status() is supposed to
return 0 on success and a negative error code otherwise. Adapt
lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status() to
actually do it.

While touching that also add the error code to the failure message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/lm3630a_bl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index e88a2b0e5904..7140b0d98082 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -190,7 +190,7 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 	if ((pwm_ctrl & LM3630A_PWM_BANK_A) != 0) {
 		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
 				 bl->props.max_brightness);
-		return bl->props.brightness;
+		return 0;
 	}
 
 	/* disable sleep */
@@ -210,8 +210,8 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 	return 0;
 
 out_i2c_err:
-	dev_err(pchip->dev, "i2c failed to access\n");
-	return bl->props.brightness;
+	dev_err(pchip->dev, "i2c failed to access (%pe)\n", ERR_PTR(ret));
+	return ret;
 }
 
 static int lm3630a_bank_a_get_brightness(struct backlight_device *bl)
@@ -267,7 +267,7 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
 	if ((pwm_ctrl & LM3630A_PWM_BANK_B) != 0) {
 		lm3630a_pwm_ctrl(pchip, bl->props.brightness,
 				 bl->props.max_brightness);
-		return bl->props.brightness;
+		return 0;
 	}
 
 	/* disable sleep */
@@ -287,8 +287,8 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
 	return 0;
 
 out_i2c_err:
-	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");
-	return bl->props.brightness;
+	dev_err(pchip->dev, "i2c failed to access (%pe)\n", ERR_PTR(ret));
+	return ret;
 }
 
 static int lm3630a_bank_b_get_brightness(struct backlight_device *bl)
-- 
2.30.2

