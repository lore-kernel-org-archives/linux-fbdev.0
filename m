Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01493C00140
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Aug 2022 10:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiHHKQ0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242240AbiHHKQY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 Aug 2022 06:16:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E868101F7
        for <linux-fbdev@vger.kernel.org>; Mon,  8 Aug 2022 03:16:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a9so11925334lfm.12
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Aug 2022 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWyHWpRZ1Kh32AMhlQIk7pyHBxJVf8IzTt5zqpwObhY=;
        b=MrROKyLJJ83f3Rr2mGc49Yse06wHtSB+UZ/fdnVkIROrdgd6G5U0BHv6wZCH0y/ELG
         AJ/m/Z/4Q7nc+d7bJBHuSjCXT9hyjQr6FsJpynKeTu7fw5UTIUgWnyB4ROV6D1v5kGxH
         vKTPX90RZrqPKvjtOl/EiKG71FvteMwCGWYOobnquUOQm8jIHa9oCCfQu+PvxlH5NrCW
         iwRFPN/ePSPg8LUGx4iyC/fG14Oske8ipp/nAcCYTlFCM7MokuuK008QWNlC2JyW29WO
         FHjxT9M+nzbkNOPuHVaA9LMMz6lcaIpnRfAwa8DyvaqiF6QwEl9fAi1PbdzqmFR0fH97
         EVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWyHWpRZ1Kh32AMhlQIk7pyHBxJVf8IzTt5zqpwObhY=;
        b=O10m2YBlWI4gIzo9SXVKESbCvOowqrZ43gV3uqVPuz/6p9iqqkHn2e7ff8Fh4jt2a5
         0MH6SRtVY7xokDQzlnhukW6jo1xvV2X+4Rmp7cjPodYl5md/k0Fje8jkZwl/eTt+dQYS
         LCR9qk+xcdbsvMRG+6rE2yc5OmFQFlZkSsBzoMUxdVFCl7qRCOWvVz+4Kf+tEXD6kCFk
         6RnGtDepp/1DH+GW0C7QHcMyN0pp1DYGbGGKWwTtQKSfiq7JbtSVqckwGd3nLoVUBPqQ
         bLNrCIxE1rLgqAIja3wW3NC8uvYRgmeMrcwfPnlFNAquK4mp4xZdSABFOOd5BmOrKwuj
         Ys7Q==
X-Gm-Message-State: ACgBeo2ETfFoybs/dytNR5uhpr1W4zt5PQ9SYFoye6YDwC39Uaz1/aZ5
        K0y8LzoPKgQ8/fxopSLc2nyW/g==
X-Google-Smtp-Source: AA6agR7cfm64Y6GBFeSO18v6MzV1E5WMXn0USHffiVixm1IpLgTYtoCxMdxCHJ8TpfOA7GHPubr/eg==
X-Received: by 2002:a05:6512:2349:b0:48c:ee14:7fc with SMTP id p9-20020a056512234900b0048cee1407fcmr1125838lfu.71.1659953780871;
        Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] MAINTAINERS: pwm-fan: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:25 +0300
Message-Id: <20220808101526.46556-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
References: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Bartlomiej's Samsung email address is not working since around last
year and there was no follow up patch take over of the drivers, so drop
the email from maintainers.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I assume that if other change was preferred, there was quite enough of
time to send a patch for this. :)
---
 MAINTAINERS | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 423c81f8ba61..4832b317fe05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16529,14 +16529,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/pwc/*
 F:	include/trace/events/pwc.h
 
-PWM FAN DRIVER
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-L:	linux-hwmon@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
-F:	Documentation/hwmon/pwm-fan.rst
-F:	drivers/hwmon/pwm-fan.c
-
 PWM IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

