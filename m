Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E2C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 23 Oct 2021 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB88060FE3
	for <linux-fbdev@archiver.kernel.org>; Sat, 23 Oct 2021 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJWNvD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 23 Oct 2021 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhJWNvD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 23 Oct 2021 09:51:03 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A00C061766
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Oct 2021 06:48:44 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id o12so8956427uap.0
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Oct 2021 06:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=iX6cmvyeDuJOkrf+xUpE4t3ouX8J2Wth4BJQBEZvdC0=;
        b=PJeoeHi87FNVFRvOrlMgjLSB19zOHxvaqVaQoUrbBe4NYsqIzVz13D19jqP7YYPmwm
         bfOeMMKrEDvAySkNkHtCod8Valdbum9uQXv6b4ehR91WNPb5RyQHcNY21EqgWoAeml9C
         1bFNYL6FXCBfcemkgqOhOGE3NdntABHsUYg3NTdi36gfFBk/ORKUVxzJnwhDISNtuEcg
         sK0Y0LIgTc+8oLv4H5GSpEnV67xHMeZV3OCAKSYuxVsQ2MO5QxQozKNP77ObQ8gJ1wAO
         ZO2LNyw8+Bex+C7bDFkZ4CqHqYmpMNq5XBOD0utmjYZigVejjziwpqx5ocw9i4Fzx+0X
         gKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=iX6cmvyeDuJOkrf+xUpE4t3ouX8J2Wth4BJQBEZvdC0=;
        b=Q0Vt5HWbM/Qwdguj6Kq2i0/6iMNl3evuhk75ss5/4CoUnDppkhb+kk4q9PRaoO+4aH
         nIigqHR3pw6XTgNkFbR/ToM1d3NUxLs/KUh/Z2gT9QzgBlaTxEbC4fBobaHgsoaWupZm
         a2ziuT1SoPDrcefJd7xT+Q6z9lT6VnbF9GO2KreY2ATAtfdWRMLlT3r9CFqdO5JsCc7e
         g7aIKtx3hnG7i4IVoGoE3zzAxrCYWLBCAFMbUkkUeX99qivJY0g6kuzRZdpSs1YZ2YIA
         bT4ccq5IyghiXbejeZQNHojkKD/7TKqLN1doaTCxRdjOa2BFp8b9anPqFs9W7++odAIU
         fiuQ==
X-Gm-Message-State: AOAM5318KSlOTEJq9Ipa3r2C6QQVfQek8msZBYixNpTEBu51u479SgrZ
        1/CLh+gVfpM+t9YrVjageFYB5Q==
X-Google-Smtp-Source: ABdhPJwxdDl4z01c9F66VI9AyRP7pXIo6Ntzy4KZdke4zr3ikYJXWWXs5oUwbePIExZg4WIuUSkp0A==
X-Received: by 2002:a67:ea0b:: with SMTP id g11mr6728954vso.2.1634996923166;
        Sat, 23 Oct 2021 06:48:43 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id m184sm6687249vsc.6.2021.10.23.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 06:48:42 -0700 (PDT)
Date:   Sat, 23 Oct 2021 10:48:38 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YXQStu5yv4bwj2Tn@fedora>
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
---
 drivers/video/backlight/lp855x_bl.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..dd63141a0d26 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -236,6 +236,7 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 	unsigned int period = lp->pdata->period_ns;
 	unsigned int duty = br * period / max_br;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -244,19 +245,19 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
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
+	pwm_init_state(pwm, &state);
+
+	state.duty_cycle = duty;
+	state.period = period;
+
 	if (duty)
-		pwm_enable(lp->pwm);
+		state.enabled = true;
 	else
-		pwm_disable(lp->pwm);
+		state.enabled = false;
+
+	pwm_apply_state(pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

