Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953B8C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 18:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AD761039
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 18:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhJ0SsO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbhJ0SsN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Oct 2021 14:48:13 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A5C061570
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Oct 2021 11:45:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g25so1427934qvf.13
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Oct 2021 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=A8jRX0QKAYjn4xUH+e8/6epT1HZFBjy/zHPwJDB1y2I=;
        b=K7U4qb/VrSu9y/l5QSpg4GLpjpE4DHWO65bczNlJoB1bhg0hrBqn3A2T9fiY4T9G1g
         seete8LDVmbo2J1tkmUUXb9HYEP8271eMBDURzJpf5RxcTnfL7vxJJPZS7FPEvONUtud
         nRu15MNY7Qnclb5uhqiaNzLfSszJN3m+M5eaNSngck+D+4grh5sOhleX8EODccBJs2FN
         e/05bu5jx8ovF5sjSKKVwJB0UFhySD55QjgCEYrHriMh+olhHW3nyVUzF5iRdD5bNI5n
         rZ/O0E7ucfpdN4GUAqb5oTr6AHd8AkSJRCpU8Ls4lDq5Gg2fr7xWHHZJZ2oPH8I4Qil4
         zvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=A8jRX0QKAYjn4xUH+e8/6epT1HZFBjy/zHPwJDB1y2I=;
        b=FB6yo5dthJzpcG5oVQHnK1JKJZNxXzzIswMnsYws31UUrUbdZjAqGvVaMwJIj/P8rZ
         o1TEYJjWHxPaDbYDdz4niAmP6DMsJSxbEXe//wFbTPH8aOzcB+cA+l2vCAD6vHTaPdrl
         KGsVbSLrYtI7q6Bz30q9IHSVhAs+3xt+VIfRFIZL/19ombEdSH5eo8cXuOw+LiZ5vEMs
         uFKZ1EEIITGWE/ms9RVlrZzkkBBZuRQcVpJ21Tjl2PHBemb/OL4ro5nueiaFffIa5sXq
         8QWGu4vkWU56CAABXV+vzeRzxCm23hnvZuE5F4KEPLPBlrNfewZgTn3DTkl0mAnKkik+
         yeVg==
X-Gm-Message-State: AOAM531Uj55XChExcJiJmGa4rML39avaxu3IBmAfjRfIlNmHbjFQ9V4G
        pmGYz5tzOgPce9gZT2vOpjd32A==
X-Google-Smtp-Source: ABdhPJxctVR5Fb0BHbs0MVwHi/Q9mP9WYyhqidbxuJ/DJ9RSpTJk1zR1ZuujvluUZFWvXr0TH+VRow==
X-Received: by 2002:a05:6214:cce:: with SMTP id 14mr31764551qvx.49.1635360346759;
        Wed, 27 Oct 2021 11:45:46 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id i67sm461196qkd.90.2021.10.27.11.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:45:46 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:45:40 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     lkp@intel.com, llvm@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YXmeVPIroq96BXfm@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
replace it for the atomic PWM API.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
Reported-by: kernel test robot <lkp@intel.com>
---
V1 -> V2: Initializing variable and simplyfing conditional loop
---
 drivers/video/backlight/lp855x_bl.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..a895a8ca6d26 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
-	struct pwm_device *pwm;
+	struct pwm_device *pwm = NULL;
+	struct pwm_state state;
 
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -244,19 +243,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 			return;
 
 		lp->pwm = pwm;
-
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pwm);
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	pwm_init_state(pwm, &state);
+
+	state.period = lp->pdata->period_ns;
+	state.duty_cycle = br * state.period / max_br;
+	state.enabled = state.duty_cycle;
+
+	pwm_apply_state(pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

