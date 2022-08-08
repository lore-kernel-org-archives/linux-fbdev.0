Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91113C25B06
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 Aug 2022 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiHHKQZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiHHKQW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 Aug 2022 06:16:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B74FD13
        for <linux-fbdev@vger.kernel.org>; Mon,  8 Aug 2022 03:16:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o2so4642960lfb.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Aug 2022 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSWhWVIMTdJmNV7dT9qbKSPZrPrjVzwG2y9B/jqm4bI=;
        b=wGcPgMyieO9cFvxTr79rS8AREemXIwc2wUFNElRfqEBdu9/xR5fsJEYyDhTDCpnFU5
         5XQthhQY2MGzL+JC/gVaFgeMpiHud6rGrIfIArCUVLUxFgpBiR+OT3G0n3jgDS9pGxqY
         24uzj13OFJGEuWH7D51hwsfbRXhSrGL61Ri87xWfoZEnwTjUmcKJ9Md6qb+El90tUsp0
         qRdiqyG1WDavMTJtM9WybGesHfpCnseXWIhvasJxOuzkhjQ3TTJkiYTsqugKCDTuV5WC
         0wvpdFIKSTfIb9VJwK6AdgDQfLBmXlRopfSfJRJn/8ekWknLSVL7XSE9mJMWcth8Vmo+
         KNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSWhWVIMTdJmNV7dT9qbKSPZrPrjVzwG2y9B/jqm4bI=;
        b=4edJHeV7s4sA2JOC7BFEfr143pA0vcP0vNxeAO4xGOAppwoZsSbAGf3p6ISMc9FAgt
         GijjKc1+fYM1WJwZk4xsi5CsR8blUiJlD5I0AWU+wnn2nOM0RYH6tjccSg7LQP4eOZrZ
         tXl5rYNX5fh6XO8inMkxYR9pGZbk6afZYEGJJuKaWYCMK+TPBUbhDknCiSpHoymTo88N
         NNy7CE4+DHz4HWNF0zvy7mZ9NS7NmFKIu/tJfqs3kNUeODw4uwRzn5Rnn7tjIF2f0pkE
         hljrMR8w8Uz7U10+8xEFfyX8Qli5fx4/S+KU33TbfG6Ou+v5a4dOkiUM8aiTe2idf7Vj
         dhmQ==
X-Gm-Message-State: ACgBeo1SR94Z1MkLt5iem6wEHM+4+q+SkRRrBBeOJxJKfmQzml8yqUyc
        bJnBs04UWR8JIaE6Jdnh/FJ+lA==
X-Google-Smtp-Source: AA6agR6WbH/uUBPu/P11zqkM//sK+ay53hJ55+HI/jBG+cpCuOejT7yCoIJ5LI688QEEuBe0vJLETA==
X-Received: by 2002:a05:6512:13a0:b0:48c:e86e:fe1a with SMTP id p32-20020a05651213a000b0048ce86efe1amr57526lfa.594.1659953779439;
        Mon, 08 Aug 2022 03:16:19 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id b2-20020a056512070200b0048b193f677dsm1377489lfs.178.2022.08.08.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:16:18 -0700 (PDT)
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
Subject: [PATCH 1/3] MAINTAINERS: Drop Bartlomiej Zolnierkiewicz
Date:   Mon,  8 Aug 2022 13:15:24 +0300
Message-Id: <20220808101526.46556-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2180312fe0a4..423c81f8ba61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5369,8 +5369,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	drivers/cpuidle/cpuidle-big_little.c
 
 CPUIDLE DRIVER - ARM EXYNOS
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Kukjin Kim <kgene@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
@@ -12404,7 +12404,6 @@ F:	drivers/power/supply/max77976_charger.c
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 B:	mailto:linux-samsung-soc@vger.kernel.org
@@ -12416,7 +12415,6 @@ F:	drivers/power/supply/max77693_charger.c
 MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 B:	mailto:linux-samsung-soc@vger.kernel.org
@@ -17973,7 +17971,6 @@ F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
-- 
2.34.1

