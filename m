Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFCC433E6
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 14:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D05C64E98
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 14:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhBAOo2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhBAOmi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 09:42:38 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D147CC061756;
        Mon,  1 Feb 2021 06:42:22 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h11so17544481ioh.11;
        Mon, 01 Feb 2021 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vYWcn7sL4czH23insMbT/xXB/qPApleY+YB9g2DqZvw=;
        b=srCiPPLg+FKyiypCOM4HhWnQR9qLFpjBesMwYf6bJhq048o7gMqqliN0JoZ8TIrxx7
         lR2AhWdnqqRR1yM8pTNZYzgB5D8LFIvmsSp6UIlW0Gr2G8pHtDgwTswLA+T1xcC2Dz/s
         mTlTAYHbuU8GsoSGFIPPk3pUzkWkll0EbNP9gVdE2gFkJMUBTmiMZzLO9V+QwNpYCnXt
         MbaY22d3pkt7aVOjdbwzfFPez1PFGZ3tqSgM0E/8Yx80X2gkuLgvRACpuQICL1UX77g+
         gJkyjLusERVpodvFNV/sUnBP+SOlagv7mVfC7PYEcgFauxvzGa/6GHQT9ARSfjY9Z3Jx
         ShAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vYWcn7sL4czH23insMbT/xXB/qPApleY+YB9g2DqZvw=;
        b=bleSF52TPo36+4KnFsEBZxG5A26pEMKhukt+6UqXKGlFj5XSeX3vZSj1SCYg/QpLsU
         1acJ3MM7l6e7FCkln+l8pMQzUtgYpkiTOgY13c8uZBvbEQcpJqAJ9YAR2/tsVxain1H0
         J3835kdd9/RIkYG3g1SDORveCNrvRiWopP1ZQzwMrjLzCeClL54MURcDZcuCPOhWllg0
         mkYOmrz4EqR+kH9ty+W25Q8DHiPI8YOsm+0V127bnuTQtYNOKLbFY3lC6U6JA4RhkAo1
         ScQ6ECyWkNzulEQ5Cv0snbut3pSWD86LffLiPbkmn+YMcBYfr00v0aDOW73A4QTZbP0f
         4msA==
X-Gm-Message-State: AOAM5302ScF/5F2bva73n43IRUTDQhADNTGATi5+QOpQVsDusj6UAFB8
        U0sYsRnHXzxiTkwF8yGKGtk=
X-Google-Smtp-Source: ABdhPJybG8fZlQcKGj1GssmKBu/UxhmQ73Q9+3UlPhYlNwH0kDkW72buRTLQh4I5AFqrw8SG5cAWhA==
X-Received: by 2002:a6b:7501:: with SMTP id l1mr12314288ioh.92.1612190542355;
        Mon, 01 Feb 2021 06:42:22 -0800 (PST)
Received: from spring-Precision-5820-Tower.cs.umn.edu ([2607:ea00:101:3c74:b4b0:f34c:770:f33f])
        by smtp.gmail.com with ESMTPSA id w2sm8470106ioa.46.2021.02.01.06.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:42:22 -0800 (PST)
From:   Wenjia Zhao <driverfuzzing@gmail.com>
Cc:     driverfuzzing@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: pcf50633: pdata may be a null pointer, null pointer dereference cause crash
Date:   Mon,  1 Feb 2021 08:41:38 -0600
Message-Id: <1612190499-73818-1-git-send-email-driverfuzzing@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Signed-off-by: Wenjia Zhao <driverfuzzing@gmail.com>
---
 drivers/video/backlight/pcf50633-backlight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
index 540dd338..43267af 100644
--- a/drivers/video/backlight/pcf50633-backlight.c
+++ b/drivers/video/backlight/pcf50633-backlight.c
@@ -127,7 +127,8 @@ static int pcf50633_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcf_bl);
 
-	pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
+  if (pdata)
+    pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
 
 	/*
 	 * Should be different from bl_props.brightness, so we do not exit
-- 
2.7.4

