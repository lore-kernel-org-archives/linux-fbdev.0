Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFBCC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Nov 2021 13:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C2F60F0F
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Nov 2021 13:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhKANWE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Nov 2021 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhKANWB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Nov 2021 09:22:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CAC061714
        for <linux-fbdev@vger.kernel.org>; Mon,  1 Nov 2021 06:19:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bl12so2151495qkb.13
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Nov 2021 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=TtX9VhCBKuhF3Ol7gnPYFLRhj5nFsqp3SrQe6dqQFXM=;
        b=ZnSQtUuzlxpPJR1GQQpbQSUoHtb09P8H7VrR18O2ahTTXRWmIDnxQOQgnULadzL610
         JTN6lYue33HVu7p8L3y+810xNbHrJ19Tbeg/nOHqdYm3ftynFUO/NzeHUfMkEmSBM0as
         ixAQxM3YbNoJXyv6pSbwPGcTlgAAOJXCqc13eV7HVkg/mau8AHrgfsWxgHABcrz2rwRh
         UeEIEFLjysCIxUATqgwwbyaCpZHBJytSLFFgeo2NtXcSey60XzPh+fJHD56twsIX7o+/
         PaI3j9470t9hHKW9dYvhUboq8DOEMMJw2ouHi3SnG6XPpzRVJ/ugKM+EZj1UusPbJosC
         Qq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TtX9VhCBKuhF3Ol7gnPYFLRhj5nFsqp3SrQe6dqQFXM=;
        b=SW839HM1v127KcjiH08U1/MM87/YCHjWn9stkQS+YNFwS8XoyUhyl4S5dRLzEy12Qn
         DUpPEXGF1dnTtL/qhH+ltbFTNLCq6XEgbJ90n/Af8TTng3SHlL1ow3KzIYEfEOgZlqlL
         lj1VzrQmolUvPeEU582NNSOiTWijOp3jOSQcdTOmvi9s6ZLRMG3hMjDvrRcxHYbH9XHd
         fUGPQiF4Rk0P5Bef4OHQwpfYpPuIa0c7rHRQATwxdowTQwKLfpmuFb1rxm6EYkUQ3d78
         qopn5akPB3ucTtjIzIEBCvmr45iI8qetL/4M59zR1uWkmNXpbktpu9D3OzOT3hmxB4Lr
         Z04g==
X-Gm-Message-State: AOAM531nJ497FTsZEX6Gges//sztc2skz4QKaJ4GkwBTLMXzIsgr9TD1
        QTg3J6mZpEUnKtSVwGJ0NyT/dA==
X-Google-Smtp-Source: ABdhPJwRu8kRDMOftlvRTysjNpt3BbtoelDYP69+cdAc8RNpfvYVVPhdMVgDl11Rbi0bEU43xN5/Tg==
X-Received: by 2002:a05:620a:1999:: with SMTP id bm25mr23030512qkb.40.1635772767335;
        Mon, 01 Nov 2021 06:19:27 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id h17sm4185790qtx.64.2021.11.01.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 06:19:27 -0700 (PDT)
Date:   Mon, 1 Nov 2021 10:19:21 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v4] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YX/pWeXPv1bykg2g@fedora>
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
V1 -> V2: Initialize variable and simply conditional loop
V2 -> V3: Fix assignment of NULL variable
V3 -> V4: Replace division for pwm_set_relative_duty_cycle
---
 drivers/video/backlight/lp855x_bl.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..bbf24564082a 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -245,18 +244,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 
 		lp->pwm = pwm;
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pwm);
+		pwm_init_state(lp->pwm, &state);
+		state.period = lp->pdata->period_ns;
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	pwm_get_state(lp->pwm, &state);
+	pwm_set_relative_duty_cycle(&state, br, max_br);
+	state.enabled = state.duty_cycle;
+
+	pwm_apply_state(lp->pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

