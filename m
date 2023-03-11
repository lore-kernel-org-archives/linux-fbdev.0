Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEECC61DA4
	for <linux-fbdev@archiver.kernel.org>; Sat, 11 Mar 2023 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCKRhp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCKRhn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D8301A5
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Mar 2023 09:37:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y4so3584669edo.2
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Mar 2023 09:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcwlP/C06RxeVDsbVu82hAXbDbgdlPaZxHqgbrTaPqw=;
        b=Su/aYm+ZTxhdwla05jEevJ0f632jx/+dGtBRD+0Pb43ZuIKPJgecesaOqP19HlE0n/
         CbD0VYIm2qkEIWdET2R0C/xF3qwUigy4t+LM3J9Jcm3Mamykk8l0bFVkt043+mfvwm/8
         PbGjjwzlL6ZxlRLjMh0WPeYcdqWUykD+A6aj8fknMYz/IDGqQpeln8x7O/oPgMAx4F1T
         +ZJdJM1o5Ae8Ub6LGp6v+Q1L7gvYk8bLwj9YOfqeVD67jFGhzj9l4f/ESzIn8vfbvYBM
         e5C/vfyD6YZi5a1rIgjKtrkrhpVZJeUA2CmRyH1v8bEv60nj3Rc14DBVcxGxnQ//tDXV
         jKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcwlP/C06RxeVDsbVu82hAXbDbgdlPaZxHqgbrTaPqw=;
        b=qgptW4v+4C/le5QV3J6U8MA3tlDp0Sb8B8o19+jz3X0wFQ7CP+JHkeW+r8KCjpdRKk
         lP/50mmWj7pVR/OHAJNFwjpfCmoFsIhUJrPtXOpwXpPObV2burOr9FTZy4sgikOq3dmJ
         saMdisDX3Zc2I9NdV0gwi0Lbqab769fW/xMYew1738/bNItSSiwpU+j+QuaCnuNtdjlb
         /Q81S447FX3fhniKPAtP4MhEfgfjz/+LrZNVhEuO4ULyxzLkqJ6/eXfwkAxApSe9lO4s
         mq3nxkJLID31Y0xnf6kICiuS9FyxvXrCGDOylb9/QzIm5JH0+BkFZBQkrd1smFahvEha
         q5GA==
X-Gm-Message-State: AO0yUKXrnSpmUdIUaFV4X8GXmJcgn6hYadCpAeo7UsXc+5qM7AHS63ZM
        9llOXeJUY5rOzeE2dc0RBs3+8w==
X-Google-Smtp-Source: AK7set8m+DcbGrpKkaEu8cJcaWS/KDSEJAux+7j8RvWSGAfhO28fTqKPTee8W0ZBoQU26tCiqYNizA==
X-Received: by 2002:a05:6402:31e8:b0:4fb:31f1:425 with SMTP id dy8-20020a05640231e800b004fb31f10425mr654075edb.33.1678556160364;
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b009240a577b38sm245423ejg.14.2023.03.11.09.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] backlight: lp855x: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 18:35:55 +0100
Message-Id: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/video/backlight/lp855x_bl.c:551:34: error: ‘lp855x_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/lp855x_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 81012bf29baf..a57c9ef3b1cc 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -548,7 +548,7 @@ static void lp855x_remove(struct i2c_client *cl)
 	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
 }
 
-static const struct of_device_id lp855x_dt_ids[] = {
+static const struct of_device_id lp855x_dt_ids[] __maybe_unused = {
 	{ .compatible = "ti,lp8550", },
 	{ .compatible = "ti,lp8551", },
 	{ .compatible = "ti,lp8552", },
-- 
2.34.1

